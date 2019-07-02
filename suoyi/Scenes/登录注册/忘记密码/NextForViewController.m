//
//  NextForViewController.m
//  乐销
//
//  Created by mengxi on 16/12/27.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "NextForViewController.h"
// 登录vc
#import "LoginViewController.h"
//keyboard observe


@interface NextForViewController ()
@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) UIImageView *phoneIcon;
@property (strong, nonatomic) UIImageView *pwdIcon;
@property (strong, nonatomic) UIView *phoneView;
@property (strong, nonatomic) UIView *captchaView;
@property (strong, nonatomic) UITextField *passWordTextFiled;
@property (strong, nonatomic) UITextField *repassWordTextFiled;
@property (strong, nonatomic) UIButton *submitbutton;
@end

@implementation NextForViewController
#pragma mark 懒加载
- (UIImageView *)phoneIcon{
    if (_phoneIcon == nil) {
        _phoneIcon = [UIImageView new];
        _phoneIcon.image = [UIImage imageNamed:@"password"];
        _phoneIcon.widthHeight = XY(W(11),W(14));
    }
    return _phoneIcon;
}
- (UIImageView *)pwdIcon{
    if (_pwdIcon == nil) {
        _pwdIcon = [UIImageView new];
        _pwdIcon.image = [UIImage imageNamed:@"password"];
        _pwdIcon.widthHeight = XY(W(11),W(14));
    }
    return _pwdIcon;
}
- (UITextField *)passWordTextFiled{
    if (_passWordTextFiled == nil) {
        _passWordTextFiled = [UITextField new];
        _passWordTextFiled.font = [UIFont systemFontOfSize:F(16)];
        _passWordTextFiled.textColor = COLOR_LABEL;
        _passWordTextFiled.borderStyle = UITextBorderStyleNone;
        _passWordTextFiled.backgroundColor = [UIColor whiteColor];
        _passWordTextFiled.placeholder = @"填写新密码(6-16位)";
        _passWordTextFiled.delegate = self;
        _passWordTextFiled.secureTextEntry = true;
    }
    return _passWordTextFiled;
}

- (UITextField *)repassWordTextFiled{
    if (_repassWordTextFiled == nil) {
        _repassWordTextFiled = [UITextField new];
        _repassWordTextFiled.font = [UIFont systemFontOfSize:F(16)];
        _repassWordTextFiled.textColor = COLOR_LABEL;
        _repassWordTextFiled.borderStyle = UITextBorderStyleNone;
        _repassWordTextFiled.backgroundColor = [UIColor whiteColor];
        _repassWordTextFiled.placeholder = @"再次填写新密码(6-16位)";
        _repassWordTextFiled.delegate = self;
        _repassWordTextFiled.secureTextEntry = true;
    }
    return _repassWordTextFiled;
}
- (UIButton *)submitbutton{
    if (_submitbutton == nil) {
        _submitbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitbutton.tag = 2;
        [_submitbutton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _submitbutton.backgroundColor = [UIColor blueColor];
        _submitbutton.titleLabel.font = [UIFont systemFontOfSize:W(18)];
        [_submitbutton setTitle:@"保存" forState:(UIControlStateNormal)];
        [GlobalMethod setRoundView:_submitbutton color:[UIColor clearColor] numRound:5 width:0];
    }
    return _submitbutton;
}
- (UIView *)phoneView{
    if (_phoneView == nil) {
        _phoneView = [UIView new];
        _phoneView.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_phoneView color:COLOR_LINE numRound:5 width:1];
    }
    return _phoneView;
}
- (UIView *)captchaView{
    if (_captchaView == nil) {
        _captchaView = [UIView new];
        _captchaView.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_captchaView color:COLOR_LINE numRound:5 width:1];
    }
    return _captchaView;
}
#pragma mark 初始化
- (void)addView{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.phoneView];
    [self.phoneView addSubview:self.phoneIcon];
    [self.phoneView addSubview:self.passWordTextFiled];
    [self.headerView addSubview:self.captchaView];
    [self.captchaView addSubview:self.pwdIcon];
    [self.captchaView addSubview:self.repassWordTextFiled];
    [self.headerView addSubview:self.submitbutton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"忘记密码" rightView:nil]];
    [self resetWithModel:nil];
    [self addView];
    //添加键盘监听
    [self.view addKeyboardHideGesture];
    //add keyboard observe
    [self addObserveOfKeyboard];
}


- (void)resetWithModel:(id)model{
    [self.phoneView removeSubViewWithTag:TAG_LINE];//移除线
    [self.captchaView removeSubViewWithTag:TAG_LINE];//移除线
    
    self.phoneView.widthHeight = XY(SCREEN_WIDTH-W(40), W(44));
    self.phoneView.leftTop = XY(W(20),W(30));
    
    self.phoneIcon.leftCenterY = XY(W(15), self.phoneView.height/2);
    
    [self.phoneView addLineFrame:CGRectMake(W(39), self.phoneIcon.y, 1, self.phoneIcon.height)];
    
    self.passWordTextFiled.widthHeight = XY(self.phoneView.width-W(60), [GlobalMethod fetchHeightFromFont:self.passWordTextFiled.font.pointSize]);
    self.passWordTextFiled.leftCenterY = XY(W(50),self.phoneIcon.centerY);
    
    self.captchaView.widthHeight = XY(SCREEN_WIDTH-W(40), W(44));
    self.captchaView.leftTop = XY(W(20),self.phoneView.bottom+W(20));
    
    self.pwdIcon.leftCenterY = XY(W(15), self.captchaView.height/2);
    
    [self.captchaView addLineFrame:CGRectMake(W(39), self.pwdIcon.y, 1, self.phoneIcon.height)];
    
    self.repassWordTextFiled.widthHeight = XY(self.captchaView.width-W(60), [GlobalMethod fetchHeightFromFont:self.repassWordTextFiled.font.pointSize]);
    self.repassWordTextFiled.leftCenterY = XY(W(50),self.pwdIcon.centerY);
    
    self.submitbutton.widthHeight = XY(SCREEN_WIDTH - W(40), W(50));
    self.submitbutton.leftTop = XY(W(20),self.captchaView.bottom+W(30));
    
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 2:
        {
           
            if (!isStr(self.passWordTextFiled.text)) {
                [GlobalMethod showAlert:@"请输入新密码"];
                return;
            }
            if (!isStr(self.repassWordTextFiled.text)) {
                [GlobalMethod showAlert:@"请再次输入新密码"];
                return;
            }
            if (![self.passWordTextFiled.text isEqualToString:self.repassWordTextFiled.text]) {
                [GlobalMethod showAlert:@"两次输入密码不一致,请重新输入"];
                return;
            }
            [RequestApi requestUserUpdatepwWithPhone:self.mindPhone opw:self.passWordTextFiled.text npw:self.repassWordTextFiled.text delegate:self success:^(NSDictionary *response, id mark) {
                LoginViewController *lo = [LoginViewController new];
                [GB_Nav pushViewController:lo animated:true];
                [GlobalMethod showAlert:@"修改成功"];
            } failure:^(NSString *errorStr, id mark) {
                
            }];
            
        }
            break;
        default:
            break;
    }
}
@end
