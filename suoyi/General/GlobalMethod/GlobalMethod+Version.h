//
//  GlobalMethod+Version.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "GlobalMethod.h"

@interface GlobalMethod (Version)

#pragma mark - 创建rootNav
+ (void)createRootNav;

#pragma mark - 注销
//清除全局数据
+ (void)clearUserInfo;

//重新登陆
+ (void)relogin;

#pragma mark - 是否可以侧滑
+ (BOOL)canLeftSlide;
    
#pragma mark - 异步执行
+ (void)asynthicBlock:(void (^)(void))block;
+ (void)mainQueueBlock:(void (^)(void))block;

@end
