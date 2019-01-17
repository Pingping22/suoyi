//
//  OpenMoreLevelBtnView.m
//  ngj
//
//  Created by Mac on 2017/8/10.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import "OpenMoreLevelBtnView.h"

@implementation OpenMoreLevelBtnView

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
        
        [self addSubview:self.backView];
    }
    return self;
}

#pragma mark - 懒加载
- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [UIView  new];
        _backView.layer.cornerRadius = 3;
        _backView.layer.masksToBounds = YES;
        _backView.hidden = YES;
        _backView.backgroundColor = UIColorFromHexRGB(@"#666666");
    }
    return  _backView;
}

#pragma mark - 创建
+ (instancetype)initWithFrame:(CGRect)frame
{
    OpenMoreLevelBtnView * view = [OpenMoreLevelBtnView new];
    view.frame = frame;
    return view;
}

#pragma mark - 刷新位置
- (void)resetViewWithFrame:(CGRect)frame withArray:(NSArray *)nameArray
{
    self.backView.frame = frame;
    self.backView.centerY = frame.origin.y;
    for (UIView * view in self.backView.subviews) {
        [view removeFromSuperview];
    }
    static UIButton * recordBtn = nil;
    for ( int i = 0 ; i < nameArray.count ; i ++ )
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(14)];
        
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:F(14)];
        [label setAttributedText:nameArray[i]];
        [label sizeToFit];
        
        CGFloat btnW = label.width+W(20);
        
        btn.frame = CGRectMake( frame.size.width/nameArray.count*i, 0, frame.size.width/nameArray.count, frame.size.height);
        btn.frame = CGRectMake( i==0?0:CGRectGetMaxX(recordBtn.frame), 0, btnW, frame.size.height);
        recordBtn = btn;
        btn.titleLabel.textColor = [UIColor whiteColor];
        [btn setAttributedTitle:nameArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(14)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:btn];
        
        if (i < nameArray.count-1) {
            //UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake( (frame.size.width/nameArray.count-0.5)*i, W(8), 1, frame.size.height-2*W(8))];
            UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake( CGRectGetMaxX(btn.frame), W(8), 1, frame.size.height-2*W(8))];
            lineView.backgroundColor = [UIColor whiteColor];
            [self.backView addSubview:lineView];
        }
    }
    
    self.backView.width = CGRectGetMaxX(recordBtn.frame);
    self.backView.x = frame.origin.x+frame.size.width-self.backView.width;
    
    self.backView.hidden = NO;
    CGRect ww = self.backView.bounds;
    CGRect ww1= ww;
    ww.size.width = 0;
    
    CGPoint center = self.backView.center;
    CGPoint center1  = center;
    center.x +=ww1.size.width/2;
    self.backView.center = center;
    
    self.backView.bounds = ww;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.bounds = ww1;
        self.backView.center = center1;
    }];
}

#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)sender
{
    [self hiddenSelfView];
    if (self.myBtnClickBlock) {
        self.myBtnClickBlock( sender.tag);
    }
}

#pragma mark - 隐藏
- (void)hiddenSelfView
{
    CGRect ww = self.backView.bounds;
    CGRect ww1= ww;
    ww.size.width = 0;
    CGPoint center = self.backView.center;
    CGPoint center1  = center;
    center.x +=ww1.size.width/2;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.bounds = ww;
        self.backView.center = center;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        self.backView.hidden = YES;
        self.backView.bounds = ww1;
        self.backView.center = center1;
    });
}

@end
