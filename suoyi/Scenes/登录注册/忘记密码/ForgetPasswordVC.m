//
//  ForgetPasswordVC.m
//  乐销
//
//  Created by mengxi on 16/12/27.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "ForgetPasswordVC.h"
//button 扩展
#import "UIButton+countDown.h"
// 下一步
#import "NextForViewController.h"
//keyboard observe

@interface ForgetPasswordVC ()
@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) UIImageView *phoneIcon;
@property (strong, nonatomic) UIImageView *pwdIcon;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UIView *phoneView;
@property (strong, nonatomic) UITextField *codeTextField;
@property (strong, nonatomic) UIButton *codeButton;
@property (strong, nonatomic) UIView *captchaView;
@property (strong, nonatomic) UIButton *nextButton;
@end

@implementation ForgetPasswordVC
#pragma mark 懒加载
- (UIImageView *)phoneIcon{
    if (_phoneIcon == nil) {
        _phoneIcon = [UIImageView new];
        _phoneIcon.image = [UIImage imageNamed:@"phone"];
        _phoneIcon.widthHeight = XY(W(9),W(16));
    }
    return _phoneIcon;
}
- (UIImageView *)pwdIcon{
    if (_pwdIcon == nil) {
        _pwdIcon = [UIImageView new];
        _pwdIcon.image = [UIImage imageNamed:@"dx"];
        _pwdIcon.widthHeight = XY(W(13),W(10));
    }
    return _pwdIcon;
}
- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [UITextField new];
        _phoneTextField.font = [UIFont systemFontOfSize:F(16)];
        _phoneTextField.textColor = COLOR_LABEL;
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.placeholder = @"填写手机号码";
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTextField;
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
- (UITextField *)codeTextField{
    if (_codeTextField == nil) {
        _codeTextField = [UITextField new];
        _codeTextField.font = [UIFont systemFontOfSize:F(16)];
        _codeTextField.textColor = COLOR_LABEL;
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.backgroundColor = [UIColor whiteColor];
        _codeTextField.placeholder = @"填写验证码";
        _codeTextField.keyboardType = UIKeyboardTypePhonePad;

    }
    return _codeTextField;
}
- (UIButton *)codeButton{
    if (_codeButton == nil) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeButton.tag = 1;
        [_codeButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _codeButton.backgroundColor = [UIColor blueColor];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:W(13)];
        [GlobalMethod setRoundView:_codeButton color:[UIColor clearColor] numRound:5 width:0];
    }
    return _codeButton;
}
- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.tag = 2;
        [_nextButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.backgroundColor = [UIColor blueColor];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:W(18)];
        [_nextButton setTitle:@"下一步" forState:(UIControlStateNormal)];
        [GlobalMethod setRoundView:_nextButton color:[UIColor clearColor] numRound:5 width:0];
    }
    return _nextButton;
}

#pragma mark 初始化
- (void)addView{
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.headerView];
        [self.headerView addSubview:self.phoneView];
        [self.phoneView addSubview:self.phoneIcon];
        [self.phoneView addSubview:self.phoneTextField];
        [self.headerView addSubview:self.captchaView];
        [self.captchaView addSubview:self.pwdIcon];
        [self.captchaView addSubview:self.codeTextField];
        [self.headerView addSubview:self.codeButton];
        [self.headerView addSubview:self.nextButton];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"忘记密码" rightView:nil]];
    [self resetWithModel:nil];
    
    [self addView];

    //添加键盘监听
    [self.view addKeyboardHideGesture];
    
    
}
- (void)resetWithModel:(id)model{
    [self.phoneView removeSubViewWithTag:TAG_LINE];//移除线
    [self.captchaView removeSubViewWithTag:TAG_LINE];//移除线
    
    self.phoneView.widthHeight = XY(SCREEN_WIDTH-W(40), W(44));
    self.phoneView.leftTop = XY(W(20),W(30));
    
    self.phoneIcon.leftCenterY = XY(W(15), self.phoneView.height/2);
    
    [self.phoneView addLineFrame:CGRectMake(W(39), self.phoneIcon.y, 1, self.phoneIcon.height)];
    
    self.phoneTextField.widthHeight = XY(self.phoneView.width-W(60), [GlobalMethod fetchHeightFromFont:self.phoneTextField.font.pointSize]);
    self.phoneTextField.leftCenterY = XY(W(50),self.phoneIcon.centerY);
    
    self.captchaView.widthHeight = XY(SCREEN_WIDTH-W(40)-W(110), W(44));
    self.captchaView.leftTop = XY(W(20),self.phoneView.bottom+W(20));
    
    self.pwdIcon.leftCenterY = XY(W(15), self.captchaView.height/2);
    
    [self.captchaView addLineFrame:CGRectMake(W(39), self.pwdIcon.y-W(3), 1, self.phoneIcon.height)];
    
    self.codeTextField.widthHeight = XY(self.captchaView.width-W(60), [GlobalMethod fetchHeightFromFont:self.codeTextField.font.pointSize]);
    self.codeTextField.leftCenterY = XY(W(50),self.pwdIcon.centerY);
    
    self.codeButton.widthHeight = XY(W(100), W(44));
    self.codeButton.rightTop = XY(SCREEN_WIDTH-W(20),self.captchaView.top);
    
    self.nextButton.widthHeight = XY(SCREEN_WIDTH - W(40), W(50));
    self.nextButton.leftTop = XY(W(20),self.captchaView.bottom+W(30));
    
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    NSArray *phone = [self.phoneTextField.text componentsValidSeparatedByString:@"-"];
    NSString *phoneNumber = [phone componentsJoinedByString:@""];
    switch (sender.tag) {
        case 1:// 获取验证码
        {
//            [RequestApi requestForgetUserSmsWithTel:phoneNumber delegate:self success:^(NSDictionary *response, id mark) {
//                [self.codeButton startWithTime:59 title:@"获取验证码" countDownTitle:@"重新发送" mainColor:[UIColor blueColor] countColor:[UIColor lightGrayColor]];
//            } failure:^(NSString *errorStr, id mark) {
//                
//            }];

        }
            break;
        case 2:// 下一步
        {
            if (!isStr(phoneNumber)) {
                [GlobalMethod showAlert:@"请输入手机号"];
                return;
            }
            if (!isStr(self.codeTextField.text)) {
                [GlobalMethod showAlert:@"请输入验证码"];
                return;
            }
//            [RequestApi requestJudgecodeWithPhone:phoneNumber type:@"forget" smscode:self.codeTextField.text delegate:self success:^(NSDictionary *response, id mark) {
                NextForViewController *next = [NextForViewController new];
                next.mindPhone = phoneNumber;
                next.mindCode = self.codeTextField.text;
                [GB_Nav pushViewController:next animated:true];
//            } failure:^(NSString *errorStr, id mark) {
//
//            }];
            
        }
            break;
        default:
            break;
    }
}


@end
