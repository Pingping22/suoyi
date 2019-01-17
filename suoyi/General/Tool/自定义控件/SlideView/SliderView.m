//
//  SliderView.m
//  乐销
//
//  Created by 隋林栋 on 2016/12/19.
//  Copyright © 2016年 ping. All rights reserved.
//


#import "SliderView.h"

@implementation SliderView

#define Height_View    44//默认总高度

#pragma mark 懒加载
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
        _scrollView.contentSize = CGSizeMake(0, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
    }
    return _scrollView;
}
- (UIView *)viewSlid{
    if (!_viewSlid) {
        _viewSlid =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, self.viewSlidHeight)];
        _viewSlid.backgroundColor = self.viewSlidColor;
    }
    return _viewSlid;
}
- (UIColor *)viewSlidColor{
    if (!_viewSlidColor) {
        _viewSlidColor = COLOR_GREEN;
    }
    return _viewSlidColor;
}
- (CGFloat )viewSlidHeight{
    if (!_viewSlidHeight) {
        _viewSlidHeight = 1;
    }
    return _viewSlidHeight;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置frame
        self.frame = frame;
        float height = frame.size.height;
        if (height == 0) {
            height = Height_View;
        }
        self.backgroundColor = [UIColor whiteColor];
        //add scroll
        [self addSubview:self.scrollView];

    }
    return self;
}
- (instancetype)initWithModels:(NSArray *)aryModel frame:(CGRect)frame isHasSlider:(BOOL)isHasSlider isImageLeft:(BOOL)isImageLeft isScroll:(BOOL)isScroll delegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self != nil) {
        if (delegate != nil) self.delegate = delegate;
        float height = frame.size.height;
        if (height == 0) {
            height = Height_View;
        }
        self.isHasSlider =  isHasSlider;
        self.isImageLeft = isImageLeft;
        self.isScroll = isScroll;
        //设置frame
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
        self.backgroundColor = [UIColor whiteColor];
        //add scroll
        [self addSubview:self.scrollView];
        //刷新页面
        [self resetWithAry:aryModel];
    }
    return self;
}

- (void)resetWithAry:(NSArray *)aryModel{
    if (!isAry(aryModel)) {
        return;
    }
    [self.scrollView removeAllSubViews];
    self.scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    
    //添加按钮
    float btnWidth  = self.isScroll ? 0 : self.width/aryModel.count;
    float btnHeight = self.isHasSlider? self.height - self.viewSlidHeight : self.height;
    float numX = 0;
    //添加滑动条
    if (self.isHasSlider) {
        [self.scrollView addSubview:self.viewSlid];
        self.viewSlid.backgroundColor = self.viewSlidColor;
        self.viewSlid.height = self.viewSlidHeight;
        self.viewSlid.top = btnHeight;
    }
    for (int i=0; i<aryModel.count; i++) {
        ModelBtn * model = aryModel[i];
        CustomSliderControl * control = [CustomSliderControl new];
        control.titleFontNum = self.titleFontNum;
        control.textColor = model.color;
        control.textColorSelect = model.colorSelect;
        control.textColorSelect = self.textColorSelect;
        [control resetControlFrame:CGRectMake(numX, 0, btnWidth, btnHeight) tag:i title:model.title imageName:model.imageName highImageName:model.highImageName isImageLeft:self.isImageLeft hasLineVertical:self.isLineVerticalHide?false: i<aryModel.count-1];
        [control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            self.viewSlid.width = self.viewSlidWidth?:control.width;
            self.viewSlid.centerX = control.centerX;
            control.selected = YES;
        }
        numX = control.right;
        [self.scrollView addSubview:control];
        self.scrollView.contentSize = CGSizeMake(numX, 0);
    }
}

//按钮点击
- (void)btnClick:(CustomSliderControl *)btn
{
    //设置按钮选择
    NSArray * ary = self.scrollView.subviews;
    for (UIView * viewSub in ary) {
        if ([viewSub isKindOfClass:[CustomSliderControl class]]) {
            CustomSliderControl * btnSub = (CustomSliderControl *)viewSub;
            btnSub.selected = NO;
        }
    }
    //滑动条滑动
    [self animateSlide:btn];
    //代理回调
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(protocolSliderViewBtnSelect:btn:)]) {
        [self.delegate protocolSliderViewBtnSelect:btn.tag btn:btn];
    }
}

#pragma mark 滑动滑块
- (void)sliderToIndex:(int)index  noticeDelegate:(BOOL)notice animate:(BOOL)animate{
    //设置按钮选择
    NSArray * ary = self.scrollView.subviews;
    for (UIView * viewSub in ary) {
        if ([viewSub isKindOfClass:[CustomSliderControl class]]) {
            CustomSliderControl * btnSub = (CustomSliderControl *)viewSub;
            //如果选择的没变则返回
            if (btnSub.tag == index) {
                if (btnSub.selected) {
                    return;
                }
                //滑动条滑动
                [self animateSlide:btnSub animated:animate];
                //代理回调
                if (notice) {
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(protocolSliderViewBtnSelect:btn:)]) {
                        [self.delegate protocolSliderViewBtnSelect:index btn:btnSub];
                    }
                }
            }else{
                btnSub.selected = NO;
            }
        }
    }
}
- (void)sliderToIndex:(int)index  noticeDelegate:(BOOL)notice{
    [self sliderToIndex:index noticeDelegate:notice animate:true];
}

#pragma mark 获取选中状态
- (NSUInteger)selectedIndex{
    NSArray * ary = self.scrollView.subviews;
    for (UIView * viewSub in ary) {
        if ([viewSub isKindOfClass:[CustomSliderControl class]]) {
            CustomSliderControl * btnSub = (CustomSliderControl *)viewSub;
            if (btnSub.selected) {
                return btnSub.tag;
            }
        }
    }
    return 0;
    
}

- (void)refreshBtn:(int)index title:(NSString *)strTitle{
    CustomSliderControl * btn = (CustomSliderControl *) [self viewWithTag:index];
    if (btn != nil && [btn isKindOfClass:[CustomSliderControl class]]) {
        [btn changeTitle:strTitle];
    }
}

#pragma mark 滑动动画
- (void)animateSlide:(UIControl *)btn {
    [self animateSlide:btn animated:true];
}
- (void)animateSlide:(UIControl *)btn  animated:(BOOL)animate{
    btn.selected = YES;
    //滑动条滑动
    [UIView animateWithDuration:animate?0.5:0 animations:^{
        self.viewSlid.centerX = btn.centerX;
        self.viewSlid.width = self.viewSlidWidth?:btn.width;
        float numX = SCREEN_WIDTH/2-btn.centerX;
        
        //判断是否可以滑动
        if (self.scrollView.contentSize.width-SCREEN_WIDTH>0) {
            if (-numX<0) {
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }else if(-numX>self.scrollView.contentSize.width-SCREEN_WIDTH){
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width-SCREEN_WIDTH, 0);
            }else{
                self.scrollView.contentOffset = CGPointMake(-numX, 0);
            }
        }
    }];

}
@end



@implementation CustomSliderControl
@synthesize textColor = _textColor;
@synthesize textColorSelect = _textColorSelect;
#pragma mark 初始化

//懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:1 fontNum:self.titleFontNum textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (CGFloat )titleFontNum{
    if (!_titleFontNum) {
        _titleFontNum = F(16);
    }
    return  _titleFontNum;
}
- (UIImageView *)iv{
    if (_iv == nil) {
        _iv = [UIImageView new];
        _iv.backgroundColor = [UIColor clearColor];
    }
    return  _iv;
}

- (UIColor *)textColor{
    if (_textColor == nil) {
        _textColor = COLOR_LABEL;
    }
    return  _textColor;
}
- (UIColor *)textColorSelect{
    if (_textColorSelect == nil) {
        _textColorSelect = COLOR_GREEN;
    }
    return  _textColorSelect;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.labelTitle.textColor = selected ? self.textColorSelect : self.textColor;
    self.iv.highlighted = selected;
}
#pragma mark 加载页面
- (void)resetControlFrame:(CGRect )rect
                      tag:(int )tag
                    title:(NSString *)title
                imageName:(NSString *)imageName
            highImageName:(NSString *)highImageName
              isImageLeft:(BOOL)isImageLeft
          hasLineVertical:(BOOL)hasLineVertical
{
    [self addSubview:self.labelTitle];
    [self addSubview:self.iv];

    self.frame = rect;
    self.tag = tag;
    [GlobalMethod resetLabel:self.labelTitle text:title isWidthLimit:0];
    if (rect.size.width == 0) {
        self.width = self.labelTitle.width + W(10)*2;
    }
    self.labelTitle.center = CGPointMake(self.width/2.0, self.height/2.0);
    if (imageName != nil) {
        UIImage * image = [UIImage imageNamed:imageName];
        self.iv.image = image;
        self.iv.width = W(image.size.width);
        self.iv.height = W(image.size.height);
        if (highImageName != nil) {
            [self.iv setHighlightedImage:[UIImage imageNamed:highImageName]];
        }
        if (rect.size.width == 0) {
            self.width +=self.iv.width + W(10);
            self.labelTitle.center = CGPointMake(self.width/2.0, self.height/2.0);
        }
        if (isImageLeft) {
            self.labelTitle.left += self.iv.width/2.0 + W(10)/2.0;
            self.iv.left = self.labelTitle.left - self.iv.width - W(10);
        } else {
            self.labelTitle.left -= self.iv.width/2.0 + W(10)/2.0;
            self.iv.left = self.labelTitle.right + W(10);
        }
        self.iv.centerY = self.height/2.0;
    }
    self.labelTitle.textColor = self.textColor;
    if (hasLineVertical) {
        [self addLineFrame:CGRectMake(self.width - 1, W(4), 1, self.height - W(8))];
    }
}

//更改title
- (void)changeTitle:(NSString *)strTitle{
    self.labelTitle.text = strTitle;
}

@end
