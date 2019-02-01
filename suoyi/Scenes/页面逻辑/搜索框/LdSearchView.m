//
//  LdSearchView.m
//  天下农商渠道版
//
//  Created by 刘惠萍 on 2017/6/22.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "LdSearchView.h"

@implementation LdSearchView

#pragma mark init
-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.searchTextField];
        [self addSubview:self.rightView];
        self.backgroundColor = [UIColor whiteColor];
        [self resetView];
    }
    return self;
}


#pragma mark 刷新页面
- (void)resetView{
    //reset text field
    self.searchTextField.leftTop = XY(W(15),W(10));
//    self.searchTextField.width = self.width-W(15)*2 - self.rightView.width-W(20);
    //right view
    self.rightView.rightCenterY = XY(SCREEN_WIDTH-W(15), self.searchTextField.centerY);
    self.height = self.searchTextField.bottom+W(10);
}


#pragma mark -懒加载
- (SearchTextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField =[SearchTextField new];
        _searchTextField.widthHeight = XY(SCREEN_WIDTH - W(30)-W(30)-W(15), W(30));
        _searchTextField.placeholder =@"搜索";
        if ([_searchTextField valueForKeyPath:@"_placeholderLabel.textColor"]) {
            [_searchTextField setValue:[UIColor colorWithHexString:@"#afafaf"] forKeyPath:@"_placeholderLabel.textColor"];
        }
        UIImageView * leftV=[UIImageView new];
        leftV.image = [UIImage imageNamed:@"xx_ss"];
        leftV.frame = CGRectMake(0, 0,W(16),W(15));
        _searchTextField.leftView = leftV;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.delegate = self;
        _searchTextField.backgroundColor = COLOR_BACKGROUND;
        _searchTextField.font = [UIFont systemFontOfSize:F(14)];
        _searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [GlobalMethod setRoundView:_searchTextField color:[UIColor clearColor] numRound:5 width:0];
        _searchTextField.keyboardType = UIKeyboardTypeWebSearch;
        [_searchTextField addTarget:self action:@selector(textFieldValueChange) forControlEvents:UIControlEventEditingChanged];
    }

    return _searchTextField;
}
-(UIButton *)rightView{
    if (_rightView == nil) {
        _rightView = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightView.tag = 1;
        [_rightView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightView.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_rightView setTitle:@"取消" forState:(UIControlStateNormal)];
        [_rightView setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _rightView.widthHeight = XY(W(30),W(40));
    }
    return _rightView;
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            self.searchTextField.text = @"";
            [GlobalMethod hideKeyboard];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -textFieldDelegat

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   [textField resignFirstResponder];
    if (self.blockSearch) {
        self.blockSearch(self.searchTextField.text);
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldValueChange{
  
}


@end
