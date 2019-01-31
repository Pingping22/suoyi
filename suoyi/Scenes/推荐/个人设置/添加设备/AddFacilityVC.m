//
//  AddFacilityVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/31.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "AddFacilityVC.h"

@interface AddFacilityVC ()<UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIButton *helpBtn;
@end

@implementation AddFacilityVC
#pragma mark 懒加载
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"22"];
        _imgView.widthHeight = XY(SCREEN_WIDTH,W(100));
    }
    return _imgView;
}
- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.font = [UIFont systemFontOfSize:F(15)];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.textColor = COLOR_LABEL;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.delegate = self;
        _textField.placeholder = @"输入视频号码/验证码";
        [_textField addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _textField;
}
-(UIButton *)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.tag = 1;
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = COLOR_DETAIL;
        _btn.titleLabel.font = [UIFont systemFontOfSize:F(17)];
        [GlobalMethod setRoundView:_btn color:[UIColor clearColor] numRound:W(20) width:0];
        [_btn setTitle:@"确认添加" forState:(UIControlStateNormal)];
        _btn.widthHeight = XY(SCREEN_WIDTH - W(60),W(40));
    }
    return _btn;
}
-(UIButton *)helpBtn{
    if (_helpBtn == nil) {
        _helpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _helpBtn.tag = 2;
        [_helpBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _helpBtn.titleLabel.font = [UIFont systemFontOfSize:F(12)];
        [GlobalMethod setRoundView:_helpBtn color:[UIColor clearColor] numRound:5 width:0];
        [_helpBtn setTitle:@"如何查看视频号码/验证码?" forState:(UIControlStateNormal)];
        _helpBtn.widthHeight = XY(SCREEN_WIDTH - W(60),W(40));
        [_helpBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    }
    return _helpBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"添加" rightView:nil]];
    [self resetView];
    //add keyboard observe
    [self addObserveOfKeyboard];
}

#pragma mark addsubview
- (void)resetView{
    [self.view removeSubViewWithTag:TAG_LINE];
    //添加subView
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.helpBtn];
    
    self.imgView.leftTop = XY(0,NAVIGATIONBAR_HEIGHT);
    
    self.textField.widthHeight = XY(SCREEN_WIDTH, [GlobalMethod fetchHeightFromFont:self.textField.font.pointSize]);
    self.textField.leftTop = XY(0,self.imgView.bottom+W(15));
    
    self.btn.centerXTop = XY(SCREEN_WIDTH/2,W(15)+[self.view addLineFrame:CGRectMake(W(40), self.textField.bottom+W(10), SCREEN_WIDTH-W(80), 1)]);

    self.helpBtn.centerXTop = XY(self.btn.centerX,self.btn.bottom+W(15));
    
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark tf 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:true];
    return true;
}
- (void)textFileAction:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        self.btn.backgroundColor = COLOR_DETAIL;
    }else{
        self.btn.backgroundColor = [UIColor orangeColor];
    }
}
@end
