//
//  SecondRegisterVC.h
//  乐销
//
//  Created by mengxi on 17/1/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseVC.h"
#import "BaseVC+BaseImageSelectVC.h"//选择图片

@interface SecondRegisterVC : BaseVC
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *imageURL;

@end

@interface SecondRegisterView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *uploadLabel;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UIView *nameLine;
@property (strong, nonatomic) UITextField *passWordTextFiled;
@property (strong, nonatomic) UIView *passWordLine;
@property (strong, nonatomic) UITextField *repassWordTextFiled;
@property (strong, nonatomic) UIView *repassLine;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UILabel *LoginLabel;
@property (strong, nonatomic) UIButton *XYButton;
@property (strong, nonatomic) UIButton *YSButton;
@property (strong, nonatomic) UIButton *IconButton;

@property (weak,   nonatomic) id delegate;

#pragma mark 创建
+ (instancetype)initWithModel:(id)delegate;
- (void)resetWithModel:(id)delegate;

@end
