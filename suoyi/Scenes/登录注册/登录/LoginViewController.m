//
//  LoginViewController.m
//  乐销
//
//  Created by mengxi on 16/11/18.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomTabBarController.h"
////网络请求
//#import "RequestApi+User.h"

// 重置密码
#import "ForgetPasswordVC.h"
////公共方法
//#import "GlobalMethod+Data.h"
//
////guide view
//#import "GuideView.h"



@interface LoginViewController ()<UINavigationControllerDelegate>
@property (strong, nonatomic) UITextField *phoneTextFiled;
@property (strong, nonatomic) UITextField *passWordTextField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIButton *forgetButton;
@property (strong, nonatomic) UIImageView *logoImg;
@property (strong, nonatomic) UIImageView *phoneIcon;
@property (strong, nonatomic) UIImageView *pwdIcon;

//@property (nonatomic, strong) GuideView *guideView;//引导页
@end

@implementation LoginViewController

#pragma mark lazy init
//- (GuideView *)guideView{
//    if (!_guideView) {
//        _guideView = [GuideView new];
//        WEAKSELF
//        _guideView.blockLogin = ^(void){
//            [weakSelf.phoneTextFiled becomeFirstResponder];
//        };
//        _guideView.blockRegiste = ^(void){
//            [weakSelf registBtnClick];
//        };
//
//    }
//    return _guideView;
//}
#pragma mark 懒加载
- (UITextField *)phoneTextFiled{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [UITextField new];
        _phoneTextFiled.textAlignment = NSTextAlignmentLeft;
        _phoneTextFiled.textColor = [UIColor blackColor];
        _phoneTextFiled.borderStyle = UITextBorderStyleNone;
        _phoneTextFiled.backgroundColor = [UIColor whiteColor];
        _phoneTextFiled.delegate = self;
        // 手机号码显示格式
        _phoneTextFiled.placeholder = @"请输入手机号码";
        _phoneTextFiled.font = [UIFont systemFontOfSize:F(20)];
        _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextFiled.widthHeight = XY(W(294), _phoneTextFiled.font.pointSize+1) ;
    }
    return _phoneTextFiled;
}
- (UITextField *)passWordTextField{
    if (_passWordTextField == nil) {
        _passWordTextField = [UITextField new];
        _passWordTextField.font = [UIFont systemFontOfSize:F(20)];
        _passWordTextField.textAlignment = NSTextAlignmentLeft;
        _passWordTextField.textColor = [UIColor blackColor];
        _passWordTextField.borderStyle = UITextBorderStyleNone;
        _passWordTextField.backgroundColor = [UIColor whiteColor];
        _passWordTextField.delegate = self;
        _passWordTextField.placeholder = @"请输入密码";
        _passWordTextField.returnKeyType = UIReturnKeyGo;
        _passWordTextField.widthHeight = XY(W(294), _passWordTextField.font.pointSize+1);
        _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _passWordTextField.secureTextEntry = YES;
        _passWordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _passWordTextField;
}

- (UIButton *)forgetButton{
    if (!_forgetButton) {
        _forgetButton = [UIButton  buttonWithType:UIButtonTypeCustom];
        _forgetButton.tag = 3;
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _forgetButton.titleLabel.fontNum = F(14);
        _forgetButton.widthHeight = XY(W(80), W(29));
    }
    return _forgetButton;
}
- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.tag = TAG_KEYBOARD;
        [_loginButton addTarget:self action:@selector(loginBtnClik) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.backgroundColor = COLOR_GREEN;
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:F(17)];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_loginButton color:[UIColor clearColor] numRound:5 width:0];
        [_loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
        _loginButton.widthHeight = XY(W(150),W(44));
    }
    return _loginButton;
}
- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.tag = TAG_KEYBOARD;
        [_registerButton addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:F(17)];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_registerButton color:[UIColor clearColor] numRound:5 width:0];
        [_registerButton setTitle:@"新用户注册" forState:(UIControlStateNormal)];
        _registerButton.widthHeight = XY(W(150),W(44));
    }
    return _registerButton;
}
- (UIImageView *)logoImg{
    if (_logoImg == nil) {
        _logoImg = [UIImageView new];
        _logoImg.image = [UIImage imageNamed:@"dl_tx"];
        _logoImg.widthHeight = XY(W(90),W(90));
        _logoImg.centerXTop = XY(SCREEN_WIDTH/2.0, W(100));
        [GlobalMethod setRoundView:_logoImg color:[UIColor clearColor] numRound:_logoImg.width/2.0 width:0];
    }
    return _logoImg;
}
- (UIImageView *)phoneIcon{
    if (_phoneIcon == nil) {
        _phoneIcon = [UIImageView new];
        _phoneIcon.image = [UIImage imageNamed:@"dl_sj"];
        _phoneIcon.widthHeight = XY(W(10),W(16));
    }
    return _phoneIcon;
}
- (UIImageView *)pwdIcon{
    if (_pwdIcon == nil) {
        _pwdIcon = [UIImageView new];
        _pwdIcon.image = [UIImage imageNamed:@"dl_mm"];
        _pwdIcon.widthHeight = XY(W(12),W(15));
    }
    return _pwdIcon;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    
    //读取本地数据
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * strValue = [user objectForKey:LOCAL_PHONE];
    
    self.phoneTextFiled.text = isStr(strValue)?strValue:@"";
//    [GlobalMethod logoutHyphen];
    
    //添加键盘监听
    [self.view addKeyboardHideGesture];
    //add keyboard observe
    [self addObserveOfKeyboard];
    
    [self resetView];
    
    [self showGuideView];
    
}

#pragma mark show guide view
- (void)showGuideView{
    //    判断是否显示引导页
    //    if (![GlobalMethod readBoolLocal:LOCAL_SHOWED_GUIDE_BEFORE]) {
    if (true) {
        //第一次
//        [GlobalMethod writeBool:YES local:LOCAL_SHOWED_GUIDE_BEFORE];
//        [self.view addSubview:self.guideView];//gbnav 上增加 会出现动画bug
    }
}
#pragma mark addsubview
- (void)resetView{
    [self.view removeSubViewWithTag:TAG_LINE];
    //添加subView
    [self.view addSubview:self.phoneTextFiled];
    [self.view addSubview:self.passWordTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.phoneIcon];
    [self.view addSubview:self.pwdIcon];
    
    //刷新view
    self.phoneIcon.leftTop = XY(W(20), self.logoImg.bottom + W(64));
    
    [self.view addLineFrame:CGRectMake(self.phoneIcon.right + W(15), self.phoneIcon.top, 1, W(16))];
    self.phoneTextFiled.leftCenterY = XY(self.phoneIcon.right + W(30),self.phoneIcon.centerY);
    
    CGFloat lineBottom = [self.view addLineFrame:CGRectMake(W(20), self.phoneTextFiled.bottom + W(10), SCREEN_WIDTH - W(40), 1)];
    
    
    self.pwdIcon.leftTop = XY(W(20), lineBottom + W(30));
    [self.view addLineFrame:CGRectMake(self.pwdIcon.right + W(15), self.pwdIcon.top, 1, W(16))];
    self.passWordTextField.leftCenterY = XY(self.pwdIcon.right + W(30),self.pwdIcon.centerY);
    
    lineBottom = [self.view addLineFrame:CGRectMake(W(20), self.passWordTextField.bottom + W(10), SCREEN_WIDTH - W(40), 1)];
    
    self.forgetButton.rightTop = XY(SCREEN_WIDTH - W(20), lineBottom + W(15));
    
    self.registerButton.leftTop = XY(W(25),lineBottom+W(67));
    
    self.loginButton.rightCenterY = XY(SCREEN_WIDTH - W(25),self.registerButton.centerY);
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.passWordTextField) {
        [self loginBtnClik];
    }
    return true;
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 3://forget
        {
            ForgetPasswordVC *fo = [ForgetPasswordVC new];
            [GB_Nav pushViewController:fo animated:true];
        }
            break;
        default:
            break;
    }
}

- (void)loginBtnClik{
    [RequestApi requestUserLoginWithPhone:_phoneTextFiled.text password:_passWordTextField.text delegate:self success:^(NSDictionary *response, id mark) {
//        [[RCIM sharedRCIM] connectWithToken:[responseObject valueForKey:@"imtoken"] success:^(NSString *userId) {
//            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//
//        } error:^(RCConnectErrorCode status) {
//            NSLog(@"登陆的错误码为:%ld", (long)status);
//        } tokenIncorrect:^{
//            //token过期或者不正确。
//            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//            [self getIMToken];
//
//            NSLog(@"token错误");
//        }]
        [GlobalData sharedInstance].GB_UserModel = [ModelUser modelObjectWithDictionary:response];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:_phoneTextFiled.text  forKey:PHONE];
        [user synchronize];
        [GlobalData sharedInstance].GB_Key = [NSString stringWithFormat:@"%.f",[GlobalData sharedInstance].GB_UserModel.uid];
        [GB_Nav popToRootViewControllerAnimated:false];
    } failure:^(NSString *errorStr, id mark) {

    }];
    
}
- (void)registBtnClick{
    [GB_Nav pushVCName:@"FirstRegisterVC"  animated:true];
    //#warning 创建企业，暂时用的注册的跳转方法，调好创建企业后，会改回来
    //    [GB_Nav pushVCName:@"CreatCompanyVC" animated:YES];
}

#pragma mark 改变statusbar颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
