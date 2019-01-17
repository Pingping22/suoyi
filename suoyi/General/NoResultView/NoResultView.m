//
//  NoResultView.m
//  乐销
//
//  Created by mengxi on 17/1/19.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NoResultView.h"

@implementation NoResultView

#pragma mark - lazy
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(20) textColor:COLOR_DETAIL text:@""];
    }
    return _labelTitle;
}
- (UIView *)lineTop{
    if (!_lineTop) {
        _lineTop = [UIView new];
        _lineTop.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        _lineTop.backgroundColor = COLOR_BACKGROUND;
    }
    return _lineTop;
}
- (UIImageView *)ivNoResult{
    if (!_ivNoResult) {
        _ivNoResult = [UIImageView new];
        _ivNoResult.backgroundColor = [UIColor whiteColor];
        _ivNoResult.hidden = true;
    }
    return _ivNoResult;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.labelTitle];
    [self addSubview:self.lineTop];
    [self addSubview:self.ivNoResult];
}

#pragma mark - show
- (void)showInView:(UIView *)viewShow frame:(CGRect)frame{
    self.frame = frame;
    [self resetView];
    [viewShow addSubview:self];
}

#pragma mark - 创建
+ (instancetype)initWithFrame:(CGRect)frame{
    NoResultView * view = [NoResultView new];
    view.frame = frame;
    [view resetView];
    return view;
}

#pragma mark - 刷新view
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.lineTop.top = 0;
    self.lineTop.width = self.width;
    
    [self.labelTitle  fitTitle:@"暂无数据"  variable:0];
    self.labelTitle.centerXTop = XY(self.width / 2,self.height/2.0 - W(50));
    
    self.ivNoResult.leftTop = XY(0, 0);
    self.ivNoResult.width = SCREEN_WIDTH;
    self.ivNoResult.height = SCREEN_WIDTH * self.ivNoResult.image.size.height/(self.ivNoResult.image.size.width?:1);
}

//reset with image
- (void)resetWithImageName:(NSString *)imageName{
    if (!isStr(imageName)) return;
    self.ivNoResult.image = [UIImage imageNamed:imageName];
    self.labelTitle.hidden = true;
    self.ivNoResult.hidden = false;
}

@end
