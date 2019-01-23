//
//  UIView+Category.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@property (nonatomic, assign, readonly) BOOL isEdited;

//获取第一响应者
- (UIView *)fetchFirstResponder;

//获取所在vc
- (UIViewController *)fetchVC;

//移除全部视图
- (void)removeAllSubViews;

//增加顶部高度
- (void)addSubViewsTopHeight:(CGFloat)height;

// 移除视图 根据tag
- (void)removeSubViewWithTag:(NSInteger)tag;

//获取子视图  根据tag
- (NSArray *)fetchSubViewsWithTag:(NSInteger)tag;

//添加线
- (CGFloat)addLineFrame:(CGRect)rect;
- (CGFloat)addLineFrame:(CGRect)rect tag:(NSInteger)tag;
- (CGFloat)addLineFrame:(CGRect)rect color:(UIColor *)color;
- (CGFloat)addLineWithHeight:(CGFloat)height;

//获取线视图
+ (UIView *)lineWithFrame:(CGRect)rect color:(UIColor *)color;
+ (UIView *)lineWithHeight:(CGFloat)height;
+ (UIView *)lineWithHeight:(CGFloat)height backGroundColor:(UIColor *)color;

//增加点击事件
- (void)addTarget:(id)target action:(SEL)action;

@end