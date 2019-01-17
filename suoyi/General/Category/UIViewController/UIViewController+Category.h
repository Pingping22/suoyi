//
//  UIViewController+Category.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)

@property (nonatomic, strong) void (^blockBack)(UIViewController *);//返回之后调用
@property (nonatomic, strong) void (^blockWillBack)(UIViewController *);//返回之前调用
@property (nonatomic, assign) int requestState;//请求结果，默认0，其余标示成功

#pragma mark - 删除子VC
- (void)removeAllChildVC;

@end
