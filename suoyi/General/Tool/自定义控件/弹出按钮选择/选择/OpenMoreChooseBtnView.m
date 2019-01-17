//
//  OpenMoreChooseBtnView.m
//  ngj
//
//  Created by lirenbo on 2017/10/13.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import "OpenMoreChooseBtnView.h"

@implementation OpenMoreChooseBtnView

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:105/255 green:105/255 blue:105/255 alpha:0.0];
        self.userInteractionEnabled = YES;
        //点击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSelfView)];
        [self addGestureRecognizer:tap];
        
        //右滑
        UISwipeGestureRecognizer * right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSelfView)];
        [right setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self addGestureRecognizer:right];
        
        //左滑
        UISwipeGestureRecognizer * left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSelfView)];
        [left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:left];
        
        //上滑
        UISwipeGestureRecognizer * upTap = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSelfView)];
        [upTap setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [self addGestureRecognizer:upTap];
        
        //下滑
        UISwipeGestureRecognizer * downTap = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSelfView)];
        [downTap setDirection:(UISwipeGestureRecognizerDirectionDown)];
        [self addGestureRecognizer:downTap];
        
        [self addSubview:self.markImage];
        //[self addSubview:self.backView];
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)markImage
{
    if (_markImage == nil) {
        _markImage = [UIImageView  new];
        _markImage.widthHeight = XY(20, 9);
    }
    return  _markImage;
}

- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [UIView  new];
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return  _backView;
}

#pragma mark - 创建
+ (instancetype)initWithFrame:(CGRect)frame
{
    OpenMoreChooseBtnView * view = [OpenMoreChooseBtnView new];
    view.frame = frame;
    return view;
}

#pragma mark - 刷新位置
- (void)resetViewWithFrame:(CGRect)frame withArray:(NSArray *)nameArray withOnTheUp:(BOOL)onTheUp isBlack:(BOOL)isBlack
{
    self.isBlack = isBlack;
    
    self.markImage.image = [UIImage imageNamed:onTheUp==YES?(isBlack==YES?@"ic_上箭头-黑":@"ic_上箭头"):(isBlack==YES?@"ic_下箭头-黑":@"ic_下箭头")];
    self.backView.backgroundColor = isBlack==YES?UIColorFromHexRGB(@"#49484B"):[UIColor whiteColor];
    self.backView.widthHeight = XY(frame.size.width, frame.size.height);
    
    if (onTheUp == YES) {
        self.markImage.rightTop = XY(frame.origin.x, frame.origin.y);
        self.backView.layer.anchorPoint = CGPointMake(1, 0);
        self.backView.rightTop = XY(SCREEN_WIDTH-W(10), self.markImage.bottom-0.5);
    }else{
        self.markImage.rightBottom = XY(frame.origin.x, frame.origin.y);
        self.backView.layer.anchorPoint = CGPointMake(1,1);
        self.backView.rightBottom = XY(SCREEN_WIDTH-W(10), self.markImage.top+0.5);
    }
    //定义层的边界矩形的锚点，作为一个点标,(0，0)是左下角的,(1,1)“是右上角,默认为(0.5,0.5)，也就是边界矩形的中心，动画。
    //self.backView.layer.anchorPoint = CGPointMake(1, 0);
    self.backView.transform = CGAffineTransformMakeScale(0, 0);
    self.markImage.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.3 animations:^{
        self.markImage.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.backView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.backgroundColor = [UIColor colorWithRed:105/255 green:105/255 blue:105/255 alpha:0.3];
    }];
    [self addSubview:self.backView];
}

#pragma mark - 刷新按钮
- (void)resetViewBtnWithAry:(NSArray *)dataArray
{
    [self.backView removeAllSubViews];
    for (int i = 0; i < dataArray.count; i ++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.widthHeight = XY(self.backView.width, self.backView.height/dataArray.count);
        btn.leftTop = XY(0, btn.height*i);
        [btn setAttributedTitle:dataArray[i] forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        btn.titleLabel.textColor = self.isBlack==YES?[UIColor whiteColor]:COLOR_LABEL;
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:btn];
    }
    for (int i = 1; i < dataArray.count; i ++) {
        UIView * line = [UIView new];
        line.backgroundColor = self.isBlack==YES?UIColorFromHexRGB(@"#58575A"):COLOR_LINE;
        line.frame = CGRectMake( W(10), i*self.backView.height/dataArray.count, self.backView.width-2*W(10), 1);
        [self.backView addSubview:line];
    }
}

#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)sender
{
    [self hiddenSelfView];
    NSLog(@"---tag---%ld",sender.tag);
    if (self.myBtnClickBlock) {
        self.myBtnClickBlock(sender.tag);
    }
}

#pragma mark - 隐藏
- (void)hiddenSelfView
{
    self.backgroundColor = [UIColor colorWithRed:105/255 green:105/255 blue:105/255 alpha:0.0];
    [self.backView removeFromSuperview];
    [self removeFromSuperview];
}

@end
