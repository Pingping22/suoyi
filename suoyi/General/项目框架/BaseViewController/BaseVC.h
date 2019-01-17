//
//  BaseVC.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeView.h" //提示view
#import "LoadingView.h" //loading view
#import "NoResultView.h" //无数据提示View

@interface BaseVC : UIViewController<RequestDelegate,UITextFieldDelegate>

@property (nonatomic, assign) BOOL isNotShowNoticeView;//不显示notice
@property (nonatomic, assign) BOOL isNotShowLoadingView;//不显示loading
@property (nonatomic, assign) BOOL isShowNoResult;//显示无结果页 default false
@property (nonatomic, assign) BOOL isShowNoResultLoadingView;//显示loading无结果页 default false

@property (nonatomic, strong) UIView * viewBG; //背景颜色
@property (nonatomic, strong) LoadingView * loadingView;//loading动画
@property (nonatomic, strong) NoticeView * noticeView; //提示语

@property (nonatomic, strong) NoResultView *noResultView; //无结果页
@property (nonatomic, strong) NoResultView *noResultLoadingView; //无结果页

@property (nonatomic, strong) void (^blockBack)(void);   //返回时的block

//添加键盘监听
- (void)addObserveOfKeyboard;

@end
