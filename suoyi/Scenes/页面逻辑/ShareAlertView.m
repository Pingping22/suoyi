//
//  ShareAlertView.m
//  suoyi
//
//  Created by 王伟 on 2019/1/23.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "ShareAlertView.h"

@implementation ShareAlertView
#pragma mark 懒加载
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_backView color:[UIColor whiteColor] numRound:5 width:0];
    }
    return _backView;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (UIImageView *)wechatImg{
    if (_wechatImg == nil) {
        _wechatImg = [UIImageView new];
        _wechatImg.image = [UIImage imageNamed:@"wexin"];
        _wechatImg.widthHeight = XY(W(30),W(30));
    }
    return _wechatImg;
}
- (UILabel *)labelWechat{
    if (_labelWechat == nil) {
        _labelWechat = [UILabel new];
        [GlobalMethod setLabel:_labelWechat widthLimit:0 numLines:0 fontNum:F(10) textColor:COLOR_LABEL text:@""];
    }
    return _labelWechat;
}
- (UIControl *)wechatControl{
    if (_wechatControl == nil) {
        _wechatControl = [UIControl new];
        _wechatControl.tag = 11;
        _wechatControl.backgroundColor = [UIColor clearColor];
        _wechatControl.widthHeight = XY(W(50),W(50));
    }
    return _wechatControl;
}
- (UIImageView *)personImg{
    if (_personImg == nil) {
        _personImg = [UIImageView new];
        _personImg.image = [UIImage imageNamed:@"pengyou"];
        _personImg.widthHeight = XY(W(30),W(30));
    }
    return _personImg;
}
- (UILabel *)labelPerson{
    if (_labelPerson == nil) {
        _labelPerson = [UILabel new];
        [GlobalMethod setLabel:_labelPerson widthLimit:0 numLines:0 fontNum:F(10) textColor:COLOR_LABEL text:@""];
    }
    return _labelPerson;
}
- (UIControl *)personControl{
    if (_personControl == nil) {
        _personControl = [UIControl new];
        _personControl.tag = 12;
        _personControl.backgroundColor = [UIColor clearColor];
        _personControl.widthHeight = XY(W(50),W(50));
    }
    return _personControl;
}
- (UIImageView *)weiboImg{
    if (_weiboImg == nil) {
        _weiboImg = [UIImageView new];
        _weiboImg.image = [UIImage imageNamed:@"weibo"];
        _weiboImg.widthHeight = XY(W(30),W(30));
    }
    return _weiboImg;
}
- (UILabel *)labelWeibo{
    if (_labelWeibo == nil) {
        _labelWeibo = [UILabel new];
        [GlobalMethod setLabel:_labelWeibo widthLimit:0 numLines:0 fontNum:F(10) textColor:COLOR_LABEL text:@""];
    }
    return _labelWeibo;
}
- (UIControl *)weiboControl{
    if (_weiboControl == nil) {
        _weiboControl = [UIControl new];
        _weiboControl.tag = 13;
        _weiboControl.backgroundColor = [UIColor clearColor];
        _weiboControl.widthHeight = XY(W(50),W(50));
    }
    return _weiboControl;
}
- (UIImageView *)downImg{
    if (_downImg == nil) {
        _downImg = [UIImageView new];
        _downImg.image = [UIImage imageNamed:@"xiazai"];
        _downImg.widthHeight = XY(W(30),W(30));
    }
    return _downImg;
}
- (UILabel *)labelDown{
    if (_labelDown == nil) {
        _labelDown = [UILabel new];
        [GlobalMethod setLabel:_labelDown widthLimit:0 numLines:0 fontNum:F(10) textColor:COLOR_LABEL text:@""];
    }
    return _labelDown;
}
- (UIControl *)downControl{
    if (_downControl == nil) {
        _downControl = [UIControl new];
        _downControl.tag = 14;
        _downControl.backgroundColor = [UIColor clearColor];
        _downControl.widthHeight = XY(W(50),W(50));
    }
    return _downControl;
}
- (UIImageView *)deleteImg{
    if (_deleteImg == nil) {
        _deleteImg = [UIImageView new];
        _deleteImg.image = [UIImage imageNamed:@"shanchu"];
        _deleteImg.widthHeight = XY(W(30),W(30));
    }
    return _deleteImg;
}
- (UILabel *)labelDelete{
    if (_labelDelete == nil) {
        _labelDelete = [UILabel new];
        [GlobalMethod setLabel:_labelDelete widthLimit:0 numLines:0 fontNum:F(10) textColor:COLOR_LABEL text:@""];
    }
    return _labelDelete;
}
- (UIControl *)deleteControl{
    if (_deleteControl == nil) {
        _deleteControl = [UIControl new];
        _deleteControl.tag = 15;
        _deleteControl.backgroundColor = [UIColor clearColor];
        _deleteControl.widthHeight = XY(W(50),W(50));
    }
    return _deleteControl;
}
-(UIButton *)conBtn{
    if (_conBtn == nil) {
        _conBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _conBtn.tag = 1;
        [_conBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _conBtn.backgroundColor = [UIColor whiteColor];
        _conBtn.titleLabel.font = [UIFont systemFontOfSize:F(14)];
        [_conBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [_conBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        _conBtn.widthHeight = XY(SCREEN_WIDTH,W(40));
    }
    return _conBtn;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.backView];
    [self.backView addSubview:self.labelTitle];
    [self.backView addSubview:self.wechatImg];
    [self.backView addSubview:self.labelWechat];
    [self.backView addSubview:self.wechatControl];
    [self.backView addSubview:self.personImg];
    [self.backView addSubview:self.labelPerson];
    [self.backView addSubview:self.personControl];
    [self.backView addSubview:self.weiboImg];
    [self.backView addSubview:self.labelWeibo];
    [self.backView addSubview:self.weiboControl];
    [self.backView addSubview:self.downImg];
    [self.backView addSubview:self.labelDown];
    [self.backView addSubview:self.downControl];
    [self.backView addSubview:self.deleteImg];
    [self.backView addSubview:self.labelDelete];
    [self.backView addSubview:self.deleteControl];
    [self.backView addSubview:self.conBtn];
    [self addTarget:self action:@selector(viewClick:) forControlEvents:(UIControlEventTouchUpInside)];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self.backView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.backView.frame = CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, self.backView.height);

    [GlobalMethod resetLabel:self.labelTitle text:@"分享至" widthLimit:0];
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH / 2,W(15));
    
    self.wechatImg.centerXTop = XY(SCREEN_WIDTH/6,self.labelTitle.bottom+W(15));
    
    [GlobalMethod resetLabel:self.labelWechat text:@"微信好友" widthLimit:0];
    self.labelWechat.centerXTop = XY(self.wechatImg.centerX,self.wechatImg.bottom+W(6));
    
    self.wechatControl.centerXTop = XY(SCREEN_WIDTH/6,self.labelTitle.bottom+W(15));
    
    self.personImg.centerXTop = XY(SCREEN_WIDTH/2,self.wechatImg.top);
    
    [GlobalMethod resetLabel:self.labelPerson text:@"微信朋友圈" widthLimit:0];
    self.labelPerson.centerXTop = XY(self.personImg.centerX,self.personImg.bottom+W(6));
    
    self.personControl.centerXTop = XY(SCREEN_WIDTH/2,self.wechatImg.top);
    
    self.weiboImg.centerXTop = XY(SCREEN_WIDTH/6*5,self.wechatImg.top);
    
    [GlobalMethod resetLabel:self.labelWeibo text:@"新浪微博" widthLimit:0];
    self.labelWeibo.centerXTop = XY(self.weiboImg.centerX,self.weiboImg.bottom+W(6));
    
    self.weiboControl.centerXTop = XY(SCREEN_WIDTH/6*5,self.wechatImg.top);
    
    self.downImg.centerXTop = XY(self.wechatImg.centerX,self.labelWechat.bottom+W(20));
    
    [GlobalMethod resetLabel:self.labelDown text:@"保存" widthLimit:0];
    self.labelDown.centerXTop = XY(self.downImg.centerX,self.downImg.bottom+W(6));
    
    self.downControl.centerXTop = XY(self.wechatImg.centerX,self.labelWechat.bottom+W(20));
    
    self.deleteImg.centerXTop = XY(self.personImg.centerX,self.downImg.top);
    
    [GlobalMethod resetLabel:self.labelDelete text:@"删除" widthLimit:0];
    self.labelDelete.centerXTop = XY(self.deleteImg.centerX,self.deleteImg.bottom+W(6));
    
    self.deleteControl.centerXTop = XY(self.personImg.centerX,self.downImg.top);;
    
    self.conBtn.leftTop = XY(0,[self.backView addLineFrame:CGRectMake(0, self.labelDown.bottom+W(20), SCREEN_WIDTH, 1)]);
    
    self.backView.height = self.conBtn.bottom;
    self.backView.bottom = SCREEN_HEIGHT;
    
    //设置总高度
    self.height = SCREEN_HEIGHT;
}
#pragma mark 点击事件
- (void)viewClick:(UIButton *)sender{
    [self removeFromSuperview];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [self removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark 销毁
- (void)dealloc{
    NSLog(@"%s  %@",__func__,self.class);
}
@end

