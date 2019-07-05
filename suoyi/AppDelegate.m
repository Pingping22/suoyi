//
//  AppDelegate.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/10.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalMethod+Version.h" //全局方法
//微信
#import "WXApi.h"
//微博
#import "WeiboSDK.h"
//Wechat
#import "WXApiManager.h"
//融云
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate,WeiboSDKDelegate,RequestDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //createRootNav
    [GlobalMethod createRootNav];
    //网易云信
//    [self configNIMSDKWithApplication:application launchOptions:launchOptions];
    //配置 app id
    [self configureAPIKey];
    return YES;
}
#pragma mark 配置appid
- (void)configureAPIKey
{
   
    //注册微信ID
    [WXApiManager registerApp];
    //微博
    [WeiboSDK registerApp:WEIBOAPPID];
    [[RCIM sharedRCIM] initWithAppKey:@"c9kqb3rdc4w6j"];
    [self getIMToken];
    
}
// 获取token
- (void)getIMToken {
    [RequestApi requestUserImtokenWithDelegate:self success:^(NSDictionary *  response, id   mark) {
        [[RCIM sharedRCIM] connectWithToken:[response valueForKey:@"imtoken"] success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //登陆成功后把用户名存储到UserDefault
            [userDefaults setObject:[response valueForKey:@"imtoken"] forKey:@"imKey"];
            [userDefaults synchronize];
            
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    } failure:^(NSString *  errorStr, id   mark) {
        
    }];
    
}

#pragma mark 微信
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"weixin"]||[url.host isEqualToString:@"wechat"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"weixin"]||[url.host isEqualToString:@"wechat"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return [WeiboSDK handleOpenURL:url delegate:self];
}
#pragma mark -- WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博分享失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博授权成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博授权失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
