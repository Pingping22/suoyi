//
//  LdSearchView.h
//  天下农商渠道版
//
//  Created by 刘惠萍 on 2017/6/22.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTextField.h"

@interface LdSearchView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) SearchTextField *searchTextField;
@property (nonatomic, strong) UIButton  *rightView;
@property (nonatomic, strong) void (^blockDele)(void);
@property (nonatomic, copy)void(^blockSearch)(NSString *);

//刷新页面
- (void)resetView;
@end
