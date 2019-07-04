//
//  SecondRegisterVC.m
//  乐销
//
//  Created by mengxi on 17/1/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "SecondRegisterVC.h"
//button 扩展
#import "UIButton+countDown.h"
//网络请求
//#import "RequestApi+User.h"
//#import "RequestApi+LiuHuiPing.h"
//上传图片
//#import "AliClient.h"
//global data
//#import "GlobalMethod+Data.h"
//base image
#import "BaseImage.h"
//keyboard observe

//协议
//#import "ServiceAgreementVC.h"

@interface SecondRegisterVC ()
@property (nonatomic, strong) SecondRegisterView *secondView;
@end

@implementation SecondRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"新用户注册" rightView:nil]];
    self.secondView = [SecondRegisterView initWithModel:self];
    self.secondView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.secondView];
    
    //添加键盘监听
    self.secondView.nameTextField.tag = TAG_KEYBOARD;
    self.secondView.passWordTextFiled.tag = TAG_KEYBOARD;
    self.secondView.repassWordTextFiled.tag = TAG_KEYBOARD;
    [self.view addKeyboardHideGesture];
    //add keyboard observe
    [self addObserveOfKeyboard];
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag-TAG_KEYBOARD) {
            
        case 1: // 注册
        {
            [self.view endEditing:true];
            [RequestApi requestUserRegisterWithPhone:self.phone password:self.secondView.passWordTextFiled.text nick:self.secondView.nameTextField.text delegate:self success:^(NSDictionary *response, id mark) {
                [RequestApi requestUserGroupCreateFamilyGroupWithFname:@"家庭组" invites:@"15105363643" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    
                }];
                [GB_Nav pushVCName:@"LoginViewController"  animated:true];
            } failure:^(NSString *errorStr, id mark) {

            }];
            
            
        }
            break;
        case 2://服务协议
        {
//            ServiceAgreementVC * vc = [ServiceAgreementVC new];
//            vc.cfgKey = @"user_agreement";
//            vc.navTitle = @"用户服务协议";
//            [GB_Nav pushViewController:vc animated:true];
        }
            break;
        case 3://隐私协议
        {
            
        }
            break;
        case 4://头像点击
        {
            [self showImageVC:1];
        }
            break;
        default:
            break;
    }
}

#pragma mark 选择图片

- (void)imageSelect:(BaseImage *)image{
//    [[AliClient sharedInstance] updateImageAry:@[image]  pathType:ENUM_UPIMAGE_USER_HEAD
// storageSuccess:nil upSuccess:nil fail:nil];
    self.secondView.iconImg.image = image;
    self.imageURL = image.imageURL;
}

@end

@implementation SecondRegisterView

#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.widthHeight = XY(W(70),W(70));
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        [GlobalMethod setRoundView:_iconImg color:COLOR_LINE numRound:_iconImg.width / 2 width:0];
    }
    return _iconImg;
}
- (UILabel *)uploadLabel{
    if (_uploadLabel == nil) {
        _uploadLabel = [UILabel new];
        [GlobalMethod setLabel:_uploadLabel widthLimit:0 numLines:0 fontNum:F(12) textColor:[UIColor blueColor] text:@""];
    }
    return _uploadLabel;
}
- (UITextField *)nameTextField{
    if (_nameTextField == nil) {
        _nameTextField = [UITextField new];
        _nameTextField.font = [UIFont systemFontOfSize:F(16)];
        _nameTextField.textColor = COLOR_LABEL;
        _nameTextField.borderStyle = UITextBorderStyleNone;
        _nameTextField.backgroundColor = [UIColor whiteColor];
        _nameTextField.placeholder = @"填写真实姓名";
        _nameTextField.delegate = self;
    }
    return _nameTextField;
}
- (UITextField *)passWordTextFiled{
    if (_passWordTextFiled == nil) {
        _passWordTextFiled = [UITextField new];
        _passWordTextFiled.font = [UIFont systemFontOfSize:F(16)];
        _passWordTextFiled.textColor = COLOR_LABEL;
        _passWordTextFiled.borderStyle = UITextBorderStyleNone;
        _passWordTextFiled.backgroundColor = [UIColor whiteColor];
        _passWordTextFiled.placeholder = @"填写密码(6-16位)";
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
        _repassWordTextFiled.placeholder = @"再次填写密码(6-16位)";
        _repassWordTextFiled.delegate = self;
        _repassWordTextFiled.secureTextEntry = true;
    }
    return _repassWordTextFiled;
}
- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.tag = 1+TAG_KEYBOARD;
        [_registerButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.backgroundColor = [UIColor blueColor];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:W(17)];
        [_registerButton setTitle:@"注册" forState:(UIControlStateNormal)];
        [GlobalMethod setRoundView:_registerButton color:[UIColor clearColor] numRound:5 width:0];
    }
    return _registerButton;
}
- (UILabel *)LoginLabel{
    if (_LoginLabel == nil) {
        _LoginLabel = [UILabel new];
        [GlobalMethod setLabel:_LoginLabel widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_DETAIL text:@""];
    }
    return _LoginLabel;
}
- (UIButton *)XYButton{
    if (_XYButton == nil) {
        _XYButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _XYButton.tag = 2+TAG_KEYBOARD;
        [_XYButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _XYButton.backgroundColor = [UIColor clearColor];
        _XYButton.titleLabel.font = [UIFont systemFontOfSize:W(12)];
        [_XYButton setTitle:@"《老刀用户协议》" forState:(UIControlStateNormal)];
        [_XYButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    }
    return _XYButton;
}
- (UIButton *)YSButton{
    if (_YSButton == nil) {
        _YSButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _YSButton.tag = 3+TAG_KEYBOARD;
        [_YSButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _YSButton.backgroundColor = [UIColor clearColor];
        _YSButton.titleLabel.font = [UIFont systemFontOfSize:W(12)];
        [_YSButton setTitle:@"《隐私政策》" forState:(UIControlStateNormal)];
        [_YSButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    }
    return _YSButton;
}
- (UIButton *)IconButton{
    if (_IconButton == nil) {
        _IconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _IconButton.tag = 4+TAG_KEYBOARD;
        [_IconButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _IconButton.backgroundColor = [UIColor clearColor];
        _IconButton.widthHeight = XY(SCREEN_WIDTH,W(0));
    }
    return _IconButton;
}

#pragma mark 初始化
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.iconImg];
        [self addSubview:self.uploadLabel];
        [self addSubview:self.nameTextField];
        [self addSubview:self.passWordTextFiled];
        [self addSubview:self.repassWordTextFiled];
        [self addSubview:self.registerButton];
//        [self addSubview:self.LoginLabel];
//        [self addSubview:self.XYButton];
        //                [self addSubview:self.YSButton];
        
        [self addSubview:self.IconButton];
        self.nameLine = [UIView new];
        self.nameLine.backgroundColor = COLOR_LINE;
        self.passWordLine = [UIView new];
        self.passWordLine.backgroundColor = COLOR_LINE;
        self.repassLine = [UIView new];
        self.repassLine.backgroundColor = COLOR_LINE;
        [self addSubview:self.nameLine];
        [self addSubview:self.passWordLine];
        [self addSubview:self.repassLine];
    }
    return self;
}

#pragma mark 创建
+ (instancetype)initWithModel:(id)delegate{
    SecondRegisterView *view = [SecondRegisterView new];
    view.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT);
    [view resetWithModel:delegate];
    return view;
}
#pragma mark 刷新view
- (void)resetWithModel:(id)delegate{
    self.delegate = delegate;
    
    self.iconImg.centerXTop = XY(SCREEN_WIDTH / 2,W(40));
    self.iconImg.image = [UIImage imageNamed:@"rza_xj_xj"];
    self.IconButton.frame = self.iconImg.frame;
    
    [self.uploadLabel  fitTitle:@"点击上传头像"  variable:0];
    self.uploadLabel.centerXTop = XY(SCREEN_WIDTH / 2,W(10) + self.iconImg.bottom);
    
    self.nameTextField.frame = CGRectMake(W(20), W(75) + self.uploadLabel.bottom, SCREEN_WIDTH - W(40), W(20));
    
    self.nameLine.frame = CGRectMake(self.nameTextField.left, W(10) + self.nameTextField.bottom, SCREEN_WIDTH - W(40), 1);
    
    self.passWordTextFiled.frame = CGRectMake(self.nameTextField.left, W(30) + self.nameLine.bottom, SCREEN_WIDTH - W(40), self.nameTextField.height);
    
    self.passWordLine.frame = CGRectMake(self.nameTextField.left, W(5) + self.passWordTextFiled.bottom, self.nameLine.width, 1);
    
    
    self.repassWordTextFiled.frame = CGRectMake(self.nameTextField.left, W(30) +self.passWordLine.bottom, SCREEN_WIDTH - W(40), self.nameTextField.height);
    
    self.repassLine.frame = CGRectMake(self.nameTextField.left, W(5) + self.repassWordTextFiled.bottom, self.nameLine.width, 1);
    
    
    self.registerButton.frame = CGRectMake(W(20), W(30) + self.repassLine.bottom, SCREEN_WIDTH - W(40), W(50));
    
    [self.LoginLabel  fitTitle:@"注册意味着同意老刀营销的"  variable:0];
    self.LoginLabel.leftTop = XY(self.nameTextField.left,W(10) + self.registerButton.bottom);
    
    self.XYButton.frame = CGRectMake(self.LoginLabel.right, self.LoginLabel.y, W(100), self.LoginLabel.height);
    
    self.YSButton.frame = CGRectMake(self.XYButton.right, self.LoginLabel.y, W(74), self.LoginLabel.height);
    
    
    
}
#pragma mark tfdelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:true];
    return true;
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(btnClick:)]) {
        [self.delegate btnClick:sender];
    }
}
@end
