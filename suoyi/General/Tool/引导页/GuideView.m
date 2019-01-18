//
//  GuideView.m
//  乐销
//
//  Created by 隋林栋 on 2017/5/30.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GuideView.h"

@implementation GuideView

#pragma mark 懒加载

- (AutoScView *)backView{
    if (_backView == nil) {
        _backView = [AutoScView new];
        _backView.frame =CGRectMake(0, 0, SCREEN_WIDTH, W(417));
        [_backView resetWithImageAry:@[@"zy_1",@"zy_2",@"zy_3",@"zy_4"]];
        _backView.isClickValid = false;
        _backView.pageControlToBottom = _backView.height - SCREEN_HEIGHT + W(165);
        _backView.pageCurrentColor = COLOR_CURRENTPAGE;
        _backView.pageDefaultColor = COLOR_PAGEBACK;
        [_backView timerStart];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UIButton *)loginBtn{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.tag = 2;
        [_loginBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _loginBtn.backgroundColor = COLOR_BLUE;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:F(17)];
        [GlobalMethod setRoundView:_loginBtn color:[UIColor clearColor] numRound:5 width:0];
        [_loginBtn setTitle:@"注册" forState:(UIControlStateNormal)];
        _loginBtn.widthHeight = XY(W(150),W(44));
    }
    return _loginBtn;
}

-(UIButton *)signBtn{
    if (_signBtn == nil) {
        _signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _signBtn.tag = 1;
        [_signBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _signBtn.backgroundColor = COLOR_GREEN;
        _signBtn.titleLabel.font = [UIFont systemFontOfSize:F(17)];
        [GlobalMethod setRoundView:_signBtn color:[UIColor clearColor] numRound:5 width:0];
        [_signBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        _signBtn.widthHeight = XY(W(150),W(44));
    }
    return _signBtn;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self addSubview:self.backView];
    [self addSubview:self.loginBtn];
    [self addSubview:self.signBtn];
    [self resetView];
}


#pragma mark 刷新view
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.backView.leftTop = XY(0,0);
    
    self.loginBtn.leftBottom = XY(W(25),SCREEN_HEIGHT - W(65));
    
    self.signBtn.rightBottom = XY(SCREEN_WIDTH - W(25),SCREEN_HEIGHT - W(65));
    
    self.height = SCREEN_HEIGHT;
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://login
        {
            if (self.blockLogin) {
                self.blockLogin();
            }
//            self.hidden = true;//改为隐藏 不会出现动画bug
            [self removeFromSuperview];

        }
            break;
        case 2://register
        {
            if (self.blockRegiste) {
                self.blockRegiste();
            }
            [self removeFromSuperview];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark 销毁
- (void)dealloc{
    [self.backView timerStop];
}


@end
