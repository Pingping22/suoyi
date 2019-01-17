//
//  GlobalData.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NoticeView.h" //提示View
#import "ModelUser.h" //用户model

//仅在AppDelegate里赋值，无需做成实例变量
extern UINavigationController * GB_Nav; //全局导航条

@interface GlobalData : NSObject

+ (GlobalData *)sharedInstance; //单例

@property (nonatomic, strong) ModelUser * GB_UserModel; //用户模型
@property (nonatomic, strong) NSString * GB_Key; //登陆成功key
@property (nonatomic, strong) NoticeView * GB_NoticeView; //global notice view
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle; //状态栏类型
@property (nonatomic, assign) BOOL statusHidden; //状态栏隐藏状态
@property (nonatomic, assign) BOOL isKeyboardShow; //键盘显示

+ (void)saveUserModel;

@end
