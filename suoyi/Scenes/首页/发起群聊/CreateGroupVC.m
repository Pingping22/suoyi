//
//  CreateGroupVC.m
//  suoyi
//
//  Created by 王伟 on 2019/7/3.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "CreateGroupVC.h"

@interface CreateGroupVC ()
@property (strong, nonatomic) UITextField *phoneTextFiled;
@property (strong, nonatomic) UITextField *passWordTextField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) UILabel *pwdLabel;
@end

@implementation CreateGroupVC

#pragma mark 懒加载
- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [UILabel new];
        [GlobalMethod setLabel:_phoneLabel widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_LABEL text:@""];
    }
    return _phoneLabel;
}
- (UILabel *)pwdLabel{
    if (_pwdLabel == nil) {
        _pwdLabel = [UILabel new];
        [GlobalMethod setLabel:_pwdLabel widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_LABEL text:@""];
    }
    return _pwdLabel;
}
- (UITextField *)phoneTextFiled{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [UITextField new];
        _phoneTextFiled.textAlignment = NSTextAlignmentLeft;
        _phoneTextFiled.textColor = [UIColor blackColor];
        _phoneTextFiled.borderStyle = UITextBorderStyleNone;
        _phoneTextFiled.backgroundColor = [UIColor whiteColor];
        _phoneTextFiled.delegate = self;
        // 手机号码显示格式
        _phoneTextFiled.placeholder = @"给群取个名字吧";
        _phoneTextFiled.font = [UIFont systemFontOfSize:F(17)];
        _phoneTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextFiled.keyboardType = UIKeyboardTypeDefault;
        _phoneTextFiled.widthHeight = XY(SCREEN_WIDTH-W(16)*2, _phoneTextFiled.font.pointSize+1) ;
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
        _passWordTextField.placeholder = @"输入群公告，不超过200字";
        _passWordTextField.returnKeyType = UIReturnKeyGo;
        _passWordTextField.widthHeight = XY(SCREEN_WIDTH-W(16)*2, _passWordTextField.font.pointSize+1);
        _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _passWordTextField.keyboardType = UIKeyboardTypeDefault;
    }
    return _passWordTextField;
}

- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.tag = TAG_KEYBOARD;
        [_loginButton addTarget:self action:@selector(loginBtnClik) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.backgroundColor = COLOR_GREEN;
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_loginButton color:[UIColor clearColor] numRound:5 width:0];
        [_loginButton setTitle:@"完成创建" forState:(UIControlStateNormal)];
        _loginButton.widthHeight = XY(SCREEN_WIDTH-W(16)*2,W(44));
    }
    return _loginButton;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"新建群聊" rightView:nil]];
    
    //添加键盘监听
    [self.view addKeyboardHideGesture];
    //add keyboard observe
    [self addObserveOfKeyboard];
    
    [self resetView];
    
}

#pragma mark addsubview
- (void)resetView{
    [self.view removeSubViewWithTag:TAG_LINE];
    //添加subView
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.pwdLabel];
    [self.view addSubview:self.phoneTextFiled];
    [self.view addSubview:self.passWordTextField];
    [self.view addSubview:self.loginButton];
    
    //刷新view
    [GlobalMethod resetLabel:self.phoneLabel text:@"群组名称" widthLimit:0];
    self.phoneLabel.leftTop = XY(W(16), W(30)+NAVIGATIONBAR_HEIGHT);
    
    self.phoneTextFiled.leftTop = XY(self.phoneLabel.left,self.phoneLabel.bottom+W(18));
    
    CGFloat lineBottom = [self.view addLineFrame:CGRectMake(W(16), self.phoneTextFiled.bottom + W(10), SCREEN_WIDTH - W(16)*2, 1)];
    
    [GlobalMethod resetLabel:self.pwdLabel text:@"群公告" widthLimit:0];
    self.pwdLabel.leftTop = XY(W(16), lineBottom + W(22));
    
    self.passWordTextField.leftTop = XY(self.pwdLabel.left,self.pwdLabel.bottom+W(18));
    
    self.loginButton.leftTop = XY(W(16),[self.view addLineFrame:CGRectMake(W(16), self.passWordTextField.bottom + W(10), SCREEN_WIDTH - W(16)*2, 1)]+W(25));
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.passWordTextField) {
        [self loginBtnClik];
    }
    return true;
}

- (void)loginBtnClik{
    [RequestApi requestUserGroupCreateGroupWithGname:self.phoneTextFiled.text gnotice:self.passWordTextField.text invites:USER_PHONE delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"创建成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

#pragma mark 改变statusbar颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
