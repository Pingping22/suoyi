//
//  Next_ChangePasswordVC.m
//  乐销
//
//  Created by mengxi on 17/2/13.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "Next_ChangePasswordVC.h"
// 登录vc
#import "LoginViewController.h"

@interface Next_ChangePasswordVC ()
@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) UITextField *passWordTextFiled;
@property (strong, nonatomic) UITextField *newPwdTextFiled;
@end


@implementation Next_ChangePasswordVC
#pragma mark 懒加载
- (UIView *)headerView{
    if(_headerView == nil) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
- (UITextField *)passWordTextFiled{
    if (_passWordTextFiled == nil) {
        _passWordTextFiled = [UITextField new];
        _passWordTextFiled.font = [UIFont systemFontOfSize:F(15)];
        _passWordTextFiled.textColor = COLOR_LABEL;
        _passWordTextFiled.backgroundColor = [UIColor whiteColor];
        _passWordTextFiled.placeholder = @"请输入当前密码";
        _passWordTextFiled.delegate = self;
        _passWordTextFiled.secureTextEntry = true;
    }
    return _passWordTextFiled;
}
- (UITextField *)newPwdTextFiled{
    if (_newPwdTextFiled == nil) {
        _newPwdTextFiled = [UITextField new];
        _newPwdTextFiled.font = [UIFont systemFontOfSize:F(15)];
        _newPwdTextFiled.textColor = COLOR_LABEL;
        _newPwdTextFiled.backgroundColor = [UIColor whiteColor];
        _newPwdTextFiled.placeholder = @"新的6至16位的登录密码";
        _newPwdTextFiled.delegate = self;
        _newPwdTextFiled.secureTextEntry = true;
    }
    return _newPwdTextFiled;
}

#pragma mark 初始化
- (void)addView{
    self.viewBG.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.passWordTextFiled];
    [self.headerView addSubview:self.newPwdTextFiled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"修改密码" rightTitle:@"保存" rightBlock:^{
            if (!isStr(weakSelf.passWordTextFiled.text)) {
                [GlobalMethod showAlert:@"请输入原密码"];
                return;
            }
            if (!isStr(weakSelf.newPwdTextFiled.text)) {
                [GlobalMethod showAlert:@"请输入新密码"];
                return;
            }
    }]];
    [self resetWithModel:nil];
    [self addView];
    //添加键盘监听
    [self.view addKeyboardHideGesture];
}
- (void)resetWithModel:(id)model{
    [self.headerView removeSubViewWithTag:TAG_LINE];//移除线
 
    self.headerView.widthHeight = XY(SCREEN_WIDTH, W(200));
    self.headerView.leftTop = XY(W(0),W(5)+NAVIGATIONBAR_HEIGHT);
    
    self.passWordTextFiled.widthHeight = XY(SCREEN_WIDTH-W(15), [GlobalMethod fetchHeightFromFont:self.passWordTextFiled.font.pointSize]);
   self.passWordTextFiled.leftTop = XY(W(15),[self.headerView addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(5)) color:COLOR_BACKGROUND]+W(10));
    
    self.newPwdTextFiled.widthHeight = XY(SCREEN_WIDTH-W(15), [GlobalMethod fetchHeightFromFont:self.newPwdTextFiled.font.pointSize]);
    self.newPwdTextFiled.leftTop = XY(W(15),[self.headerView addLineFrame:CGRectMake(W(15), self.passWordTextFiled.bottom+W(10), SCREEN_WIDTH-W(15), 1)]+W(10));
    
    self.headerView.height = [self.headerView addLineFrame:CGRectMake(0, self.newPwdTextFiled.bottom+W(10), SCREEN_WIDTH, 1)];
}

@end
