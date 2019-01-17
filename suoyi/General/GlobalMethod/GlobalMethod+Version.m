//
//  GlobalMethod+Version.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "GlobalMethod+Version.h"
#import "AppDelegate.h"
#import "BaseNavController.h" //baseNav
#import "CustomTabBarController.h" //tabvc
#import "LoginViewController.h" //登录

@implementation GlobalMethod (Version)

#pragma mark - 创建rootNav
+ (void)createRootNav{
    BaseNavController * navMain = [[BaseNavController alloc]initWithRootViewController:[CustomTabBarController new]];
    navMain.navigationBarHidden = YES;
    GB_Nav = navMain;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    window.rootViewController = GB_Nav;
    [window setBackgroundColor:[UIColor clearColor]];
    [window makeKeyAndVisible];
    
    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    delegate.window = window;
//    //判断是否需要登陆
//    if (![self isLoginSuccess]) {
//        [GB_Nav pushViewController:[LoginViewController new] animated:false];
//    }else if(![GlobalMethod isCompanyCreated]){
//        [GB_Nav jumpToAry:@[[LoginViewController new],[JoinedTheCompanyVC new]] animate:false];
//    }else if(![GlobalMethod isComanyValid]){
//        [GB_Nav pushViewController:[LoginViewController new] animated:false];
//    }
//    //请求版本
//    [GlobalMethod requestVersion];
//    //sld_test
//#ifdef SLD_TEST
//    [GB_Nav pushVCName:@"TestVC" animated:false];
//#endif
}

#pragma mark - 注销
//清除全局数据
+ (void)clearUserInfo{
    //clear  user global data
    GlobalData * gbData = [GlobalData sharedInstance];
    gbData.GB_UserModel = nil;
    gbData.GB_Key = nil;
    //clear user default
    [self clearUserDefault];
}

//重新登陆
+ (void)relogin{
    [GlobalMethod clearUserInfo];
    if (![GB_Nav.lastVC isKindOfClass:[LoginViewController class]]) {
        [GlobalMethod showAlert:@"登陆已过期，请重新登陆"];
        [GlobalMethod createRootNav];
    }
}

#pragma mark - 是否可以侧滑
+ (BOOL)canLeftSlide{
    if (GB_Nav.viewControllers.count <=1) {
        return false;
    }
    for (UIViewController * vc in GB_Nav.viewControllers) {
        if ([vc isKindOfClass:[LoginViewController class]]) {
            return false;
        }
    }
    return true;
}
    
#pragma mark - 异步执行
+ (void)asynthicBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
// 异步执行
+ (void)mainQueueBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
