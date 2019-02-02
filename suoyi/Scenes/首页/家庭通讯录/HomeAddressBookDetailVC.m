//
//  HomeAddressBookDetailVC.m
//  suoyi
//
//  Created by 王伟 on 2019/2/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "HomeAddressBookDetailVC.h"

@interface HomeAddressBookDetailVC ()
@property (nonatomic, strong) HomeAddressBookDetailHeaderView * headerView;
@property (nonatomic, strong) HomeAddressBookDetailFooterView * footerView;
@end

@implementation HomeAddressBookDetailVC
- (HomeAddressBookDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [HomeAddressBookDetailHeaderView new];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _headerView.height);
    }
    return  _headerView;
}
- (HomeAddressBookDetailFooterView *)footerView
{
    if (_footerView == nil) {
        _footerView = [HomeAddressBookDetailFooterView new];
        _footerView.frame = CGRectMake(0, SCREEN_HEIGHT-_footerView.height, SCREEN_WIDTH, _footerView.height);
    }
    return  _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.footerView];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end






@implementation HomeAddressBookDetailHeaderView
#pragma mark 懒加载
-(UIButton *)leftBtn{
    if (_leftBtn == nil) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.tag = 1;
        [_leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.widthHeight = XY(W(50),W(50));
        [_leftBtn setImage:[UIImage imageNamed:@"left_white"] forState:(UIControlStateNormal)];
    }
    return _leftBtn;
}
- (UIImageView *)backView{
    if (_backView == nil) {
        _backView = [UIImageView new];
        _backView.image = [UIImage imageNamed:@"12"];
        _backView.widthHeight = XY(SCREEN_WIDTH,W(300));
        _backView.userInteractionEnabled = true;
    }
    return _backView;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"22"];
        _iconImg.widthHeight = XY(W(80),W(80));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
    }
    return _iconImg;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(20) textColor:[UIColor whiteColor] text:@""];
    }
    return _labelName;
}
- (UILabel *)labelNum{
    if (_labelNum == nil) {
        _labelNum = [UILabel new];
        [GlobalMethod setLabel:_labelNum widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor whiteColor] text:@""];
    }
    return _labelNum;
}
- (UILabel *)labelMana{
    if (_labelMana == nil) {
        _labelMana = [UILabel new];
        [GlobalMethod setLabel:_labelMana widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor whiteColor] text:@""];
    }
    return _labelMana;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.backView];
    [self.backView addSubview:self.leftBtn];
    [self.backView addSubview:self.iconImg];
    [self.backView addSubview:self.labelName];
    [self.backView addSubview:self.labelNum];
    [self.backView addSubview:self.labelMana];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self.backView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.backView.leftTop = XY(0,0);
    
    self.leftBtn.leftTop = XY(0,W(15));

    self.iconImg.centerXTop = XY(SCREEN_WIDTH/2,NAVIGATIONBAR_HEIGHT+W(15)+STATUSBAR_HEIGHT);
    
    [GlobalMethod resetLabel:self.labelName text:@"你好的家" widthLimit:0];
    self.labelName.centerXTop = XY(SCREEN_WIDTH/2,self.iconImg.bottom+W(15));
    
    [GlobalMethod resetLabel:self.labelNum text:@"视频号码：606995" widthLimit:0];
    self.labelNum.centerXTop = XY(SCREEN_WIDTH/2,self.labelName.bottom+W(10));
    
    [GlobalMethod resetLabel:self.labelMana text:@"管理员：你好" widthLimit:0];
    self.labelMana.centerXTop = XY(SCREEN_WIDTH/2,self.labelNum.bottom+W(10));
    
    self.backView.height = self.labelMana.bottom+W(70);
    self.height = self.backView.bottom;
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav popViewControllerAnimated:true];
        }
            break;
            
        default:
            break;
    }
}

@end








@implementation HomeAddressBookDetailFooterView
#pragma mark 懒加载
- (UIImageView *)phoneImg{
    if (_phoneImg == nil) {
        _phoneImg = [UIImageView new];
        _phoneImg.image = [UIImage imageNamed:@"phone"];
        _phoneImg.widthHeight = XY(W(30),W(30));
    }
    return _phoneImg;
}
- (UILabel *)labelPhone{
    if (_labelPhone == nil) {
        _labelPhone = [UILabel new];
        [GlobalMethod setLabel:_labelPhone widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor orangeColor] text:@""];
    }
    return _labelPhone;
}
- (UIControl *)phoneControl{
    if (_phoneControl == nil) {
        _phoneControl = [UIControl new];
        _phoneControl.tag = 1;
        [_phoneControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _phoneControl.backgroundColor = [UIColor clearColor];
        _phoneControl.widthHeight = XY(W(100),W(100));
    }
    return _phoneControl;
}
- (UIImageView *)liuImg{
    if (_liuImg == nil) {
        _liuImg = [UIImageView new];
        _liuImg.image = [UIImage imageNamed:@"ly"];
        _liuImg.widthHeight = XY(W(30),W(30));
    }
    return _liuImg;
}
- (UILabel *)labelLiu{
    if (_labelLiu == nil) {
        _labelLiu = [UILabel new];
        [GlobalMethod setLabel:_labelLiu widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor orangeColor] text:@""];
    }
    return _labelLiu;
}
- (UIControl *)liuControl{
    if (_liuControl == nil) {
        _liuControl = [UIControl new];
        _liuControl.tag = 2;
        [_liuControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _liuControl.backgroundColor = [UIColor clearColor];
        _liuControl.widthHeight = XY(W(100),W(100));
    }
    return _liuControl;
}
- (UIImageView *)spImg{
    if (_spImg == nil) {
        _spImg = [UIImageView new];
        _spImg.image = [UIImage imageNamed:@"sp"];
        _spImg.widthHeight = XY(W(30),W(30));
    }
    return _spImg;
}
- (UILabel *)labelSp{
    if (_labelSp == nil) {
        _labelSp = [UILabel new];
        [GlobalMethod setLabel:_labelSp widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor orangeColor] text:@""];
    }
    return _labelSp;
}
- (UIControl *)controlSp{
    if (_controlSp == nil) {
        _controlSp = [UIControl new];
        _controlSp.tag = 3;
        [_controlSp addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _controlSp.backgroundColor = [UIColor clearColor];
        _controlSp.widthHeight = XY(W(100),W(100));
    }
    return _controlSp;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.phoneImg];
    [self addSubview:self.labelPhone];
    [self addSubview:self.phoneControl];
    [self addSubview:self.liuImg];
    [self addSubview:self.labelLiu];
    [self addSubview:self.liuControl];
    [self addSubview:self.spImg];
    [self addSubview:self.labelSp];
    [self addSubview:self.controlSp];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.height = W(100);

    [GlobalMethod resetLabel:self.labelPhone text:@"留言" widthLimit:0];
    self.labelPhone.centerXBottom = XY(SCREEN_WIDTH/4,self.height-W(20));
    
    self.phoneImg.centerXBottom = XY(self.labelPhone.centerX,self.labelPhone.top-W(15));

    self.phoneControl.centerXBottom = XY(SCREEN_WIDTH/4,self.height-W(20));
    
    [GlobalMethod resetLabel:self.labelLiu text:@"语音" widthLimit:0];
    self.labelLiu.centerXBottom = XY(SCREEN_WIDTH/2,self.height-W(20));
    
    self.liuImg.centerXBottom = XY(self.labelLiu.centerX,self.labelLiu.top-W(15));

    self.liuControl.centerXBottom = XY(SCREEN_WIDTH/2,self.height-W(20));
    
    [GlobalMethod resetLabel:self.labelSp text:@"视频" widthLimit:0];
    self.labelSp.centerXBottom = XY(SCREEN_WIDTH/4*3,self.height-W(20));
    
    self.spImg.centerXBottom = XY(self.labelSp.centerX,self.labelSp.top-W(15));

    self.controlSp.centerXBottom = XY(SCREEN_WIDTH/4*3,self.height-W(20));
    
}

@end
