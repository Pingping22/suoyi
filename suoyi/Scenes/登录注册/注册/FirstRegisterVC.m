//
//  FirstRegisterVC.m
//  乐销
//
//  Created by mengxi on 17/1/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "FirstRegisterVC.h"
//button 扩展
#import "UIButton+countDown.h"
//网络请求
//#import "RequestApi+User.h"
//#import "RequestApi+LiuHuiPing.h"
// 下一步
#import "SecondRegisterVC.h"
//keyboard observe

//协议
//#import "ServiceAgreementVC.h"
@interface FirstRegisterVC ()
@property (nonatomic, strong) FirstRegisterView *firstView;
@property (nonatomic, strong) NSString *phoneNumber;
@end

@implementation FirstRegisterVC

#pragma mark mark lazy init

- (FirstRegisterView *)firstView{
    if (!_firstView) {
        _firstView = [FirstRegisterView new];
        WEAKSELF
        _firstView.blockBtnNextClick = ^{
            [weakSelf next];
        };
        _firstView.blockBtnFetchCodeClick = ^{
            [weakSelf fetchCode];
        };
        _firstView.blockClick = ^{
//             ServiceAgreementVC * vc = [ServiceAgreementVC new];
//             vc.cfgKey = @"user_agreement";
//             vc.navTitle = @"用户服务协议";
//             [GB_Nav pushViewController:vc animated:YES];
        };
    }
    return _firstView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"新用户注册" rightView:nil]];
    //regist view
    [self.view addSubview:self.firstView];
    
    //添加键盘监听
    self.firstView.phoneTextFiled.tag = TAG_KEYBOARD;
    self.firstView.captchaTextFiled.tag = TAG_KEYBOARD;
    [self.view addKeyboardHideGesture];
    //add keyboard observe
    [self addObserveOfKeyboard];
}

#pragma mark 点击事件
- (void)fetchCode{
    self.phoneNumber = self.firstView.phoneTextFiled.text;
    [RequestApi requestUserSmcodeWithPhone:self.phoneNumber delegate:self success:^(NSDictionary *response, id mark) {
       [self.firstView.captchaButton startWithTime:59 title:@"获取验证码" countDownTitle:@"重新发送" mainColor:[UIColor blueColor] countColor:[UIColor lightGrayColor]];
    } failure:^(NSString *errorStr, id mark) {

    }];
}
- (void)next{
    self.phoneNumber = self.firstView.phoneTextFiled.text;
    if (self.phoneNumber == nil || self.phoneNumber.length == 0) {
        [GlobalMethod showAlert:@"请输入手机号"];
        return;
    }
    if (self.firstView.captchaTextFiled.text == nil || self.firstView.captchaTextFiled.text == 0) {
        [GlobalMethod showAlert:@"请输入验证码"];
        return;
    }
    if (self.firstView.captchaTextFiled.text.length < 5) {
        [GlobalMethod showAlert:@"请输入正确验证码"];
        return;
    }
    [RequestApi requestUserVerfiySmcodeWithPhone:self.phoneNumber smCode:self.firstView.captchaTextFiled.text delegate:self success:^(NSDictionary *response, id mark) {
        SecondRegisterVC *sec = [SecondRegisterVC new];
        sec.phone = self.phoneNumber;
        sec.code = self.firstView.captchaTextFiled.text;
        [GB_Nav pushViewController:sec animated:true];
    } failure:^(NSString *errorStr, id mark) {

    }];
    
}


@end


@implementation FirstRegisterView
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
- (UITextField *)phoneTextFiled{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [UITextField new];
        _phoneTextFiled.font = [UIFont systemFontOfSize:F(15)];
        _phoneTextFiled.textColor = COLOR_LABEL;
        _phoneTextFiled.borderStyle = UITextBorderStyleNone;
        _phoneTextFiled.backgroundColor = [UIColor whiteColor];
        _phoneTextFiled.placeholder = @"请输入手机号码";
        _phoneTextFiled.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextFiled.delegate = self;
    }
    return _phoneTextFiled;
}
- (UITextField *)captchaTextFiled{
    if (_captchaTextFiled == nil) {
        _captchaTextFiled = [UITextField new];
        _captchaTextFiled.font = [UIFont systemFontOfSize:F(15)];
        _captchaTextFiled.textColor = COLOR_LABEL;
        _captchaTextFiled.borderStyle = UITextBorderStyleNone;
        _captchaTextFiled.backgroundColor = [UIColor whiteColor];
        _captchaTextFiled.placeholder = @"请输入验证码";
        _captchaTextFiled.keyboardType = UIKeyboardTypePhonePad;
        _captchaTextFiled.delegate = self;
        
    }
    return _captchaTextFiled;
}
- (UIButton *)captchaButton{
    if (_captchaButton == nil) {
        _captchaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _captchaButton.tag = TAG_KEYBOARD;
        [_captchaButton addTarget:self action:@selector(btnFetchCodeClick) forControlEvents:UIControlEventTouchUpInside];
        _captchaButton.backgroundColor = [UIColor blueColor];
        [_captchaButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [_captchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _captchaButton.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        [GlobalMethod setRoundView:_captchaButton color:[UIColor clearColor] numRound:5 width:0];
    }
    return _captchaButton;
}
- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.tag = TAG_KEYBOARD;
        [_nextButton addTarget:self action:@selector(btnNextClick) forControlEvents:UIControlEventTouchUpInside];
        [_nextButton setTitle:@"下一步" forState:(UIControlStateNormal)];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:W(17)];
        _nextButton.backgroundColor = [UIColor blueColor];
        [GlobalMethod setRoundView:_nextButton color:[UIColor clearColor] numRound:5 width:0];
    }
    return _nextButton;
}
- (UIControl *)control{
    if (_control == nil) {
        _control = [UIControl new];
        _control.tag = 11;
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor = [UIColor clearColor];
        _control.widthHeight = XY(SCREEN_WIDTH,W(0));
    }
    return _control;
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
- (UILabel *)labelExplain{
    if (_labelExplain == nil) {
        _labelExplain = [UILabel new];
        _labelExplain.textColor = COLOR_LABEL;
        _labelExplain.fontNum = F(12);
        _labelExplain.numberOfLines = 0;
        _labelExplain.lineSpace = 0;
    }
    return _labelExplain;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT);
        [self addSubview:self.phoneView];
        [self.phoneView addSubview:self.phoneIcon];
        [self.phoneView addSubview:self.phoneTextFiled];

        [self addSubview:self.captchaView];
        [self.captchaView addSubview:self.captchaTextFiled];
        [self.captchaView addSubview:self.pwdIcon];
        [self addSubview:self.captchaButton];
        [self addSubview:self.nextButton];
        [self addSubview:self.labelExplain];
        [self addSubview:self.control];

        [self resetView];
    }
    return self;
}

#pragma mark 刷新view
- (void)resetView{
    [self.phoneView removeSubViewWithTag:TAG_LINE];//移除线
    [self.captchaView removeSubViewWithTag:TAG_LINE];//移除线

    self.phoneView.widthHeight = XY(SCREEN_WIDTH-W(40), W(44));
    self.phoneView.leftTop = XY(W(20),W(30));
    
    self.phoneIcon.leftCenterY = XY(W(15), self.phoneView.height/2);

    [self.phoneView addLineFrame:CGRectMake(W(39), self.phoneIcon.y, 1, self.phoneIcon.height)];
    
    self.phoneTextFiled.widthHeight = XY(self.phoneView.width-W(60), [GlobalMethod fetchHeightFromFont:self.phoneTextFiled.font.pointSize]);
    self.phoneTextFiled.leftCenterY = XY(W(50),self.phoneIcon.centerY);
    
    self.captchaView.widthHeight = XY(SCREEN_WIDTH-W(40)-W(110), W(44));
    self.captchaView.leftTop = XY(W(20),self.phoneView.bottom+W(20));
    
    self.pwdIcon.leftCenterY = XY(W(15), self.captchaView.height/2);

    [self.captchaView addLineFrame:CGRectMake(W(39), self.pwdIcon.y-W(3), 1, self.phoneIcon.height)];
    
    self.captchaTextFiled.widthHeight = XY(self.captchaView.width-W(60), [GlobalMethod fetchHeightFromFont:self.captchaTextFiled.font.pointSize]);
    self.captchaTextFiled.leftCenterY = XY(W(50),self.pwdIcon.centerY);
    
    
    self.captchaButton.widthHeight = XY(W(100), W(44));
    self.captchaButton.rightTop = XY(SCREEN_WIDTH-W(20),self.captchaView.top);
    
    self.nextButton.widthHeight = XY(SCREEN_WIDTH - W(40), W(50));
    self.nextButton.leftTop = XY(W(20),self.captchaView.bottom+W(30));
    
    [GlobalMethod resetLabel:self.labelExplain attributeString:[self exchangeUnit:@"注册意味着同意老刀营销的" price:@"《老刀用户协议》"] widthLimit:SCREEN_WIDTH-W(40)];
    self.labelExplain.leftTop = XY(W(20),W(10)+self.nextButton.bottom);
    
    self.control.widthHeight = XY(SCREEN_WIDTH, self.labelExplain.height);
    self.control.leftTop = XY(0,self.labelExplain.top);

}
- (NSAttributedString *)exchangeUnit:(NSString *)unit price:(NSString *)price{
    NSString * str1 = [NSString stringWithFormat:@"%@",unit];
    NSString * str2 = [NSString stringWithFormat:@"%@",price];
    
    NSMutableAttributedString * strAttribute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str1,str2]];
    [strAttribute setAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor],        NSFontAttributeName : [UIFont systemFontOfSize:F(12)]} range:NSMakeRange(0, str1.length)];
    [strAttribute setAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor],        NSFontAttributeName : [UIFont systemFontOfSize:F(12)]} range:NSMakeRange(str1.length, str2.length)];
    
    return strAttribute;
}
#pragma mark tfdelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:true];
    return true;
}
#pragma mark 点击事件
- (void)btnFetchCodeClick{
    if (self.blockBtnFetchCodeClick) {
        self.blockBtnFetchCodeClick();
    }
}
- (void)btnNextClick{
    if (self.blockBtnNextClick) {
        self.blockBtnNextClick();
    }
}
#pragma mark click
- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 11:
        {
            if (self.blockClick) {
                self.blockClick();
            }
        }
            break;
            
        default:
            break;
    }
}
@end
