//
//  FirstRegisterVC.h
//  乐销
//
//  Created by mengxi on 17/1/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC.h"

@interface FirstRegisterVC : BaseVC

@end


@interface FirstRegisterView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *phoneIcon;
@property (strong, nonatomic) UIImageView *pwdIcon;
@property (strong, nonatomic) UITextField *phoneTextFiled;
@property (strong, nonatomic) UIView *phoneView;
@property (strong, nonatomic) UITextField *captchaTextFiled;
@property (strong, nonatomic) UIButton *captchaButton;
@property (strong, nonatomic) UIView *captchaView;
@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UILabel *labelExplain;
@property (strong, nonatomic) UIControl *control;
@property (nonatomic, strong) void(^blockBtnNextClick)();//btnClick
@property (nonatomic, strong) void(^blockBtnFetchCodeClick)();//btnClick
@property (nonatomic, strong) void (^blockClick)();

#pragma mark 创建
- (void)resetView;
@end
