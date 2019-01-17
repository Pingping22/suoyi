//
//  UINavigationController+EndEditing.h
//  lanberProject
//
//  Created by lirenbo on 2018/7/21.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (EndEditing)

#pragma mark - 属性
@property (nonatomic,readonly) UIViewController * lastVC;
@property (nonatomic,readonly) UIViewController * lastSecondVC;

//根据名称跳转
- (void)pushVCName:(NSString *)strClassName animated:(BOOL)animated;

//根据名称pop
- (void)popToClass:(NSString *)className;

//根据个数pop
- (void)popMultiVC:(NSInteger)num;

@end
