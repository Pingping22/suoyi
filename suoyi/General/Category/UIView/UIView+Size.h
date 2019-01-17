//
//  UIView+Size.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Size)

//添加属性
@property (nonatomic, assign) CGFloat topToUpView; //默认为0,如果view的height为0,topToUpView不计算
@property (nonatomic, strong) UIColor *topToUpViewBGColor;
@property (nonatomic, assign) CGFloat bottomToDownView;

//组合
@property (nonatomic,assign) STRUCT_XY leftCenterY;
@property (nonatomic,assign) STRUCT_XY leftTop;
@property (nonatomic,assign) STRUCT_XY leftBottom;
@property (nonatomic,assign) STRUCT_XY centerXTop;
@property (nonatomic,assign) STRUCT_XY centerXCenterY;
@property (nonatomic,assign) STRUCT_XY centerXBottom;
@property (nonatomic,assign) STRUCT_XY rightTop;
@property (nonatomic,assign) STRUCT_XY rightCenterY;
@property (nonatomic,assign) STRUCT_XY rightBottom;
@property (nonatomic,assign) STRUCT_XY widthHeight;

#pragma mark - 获取高度
+ (CGFloat)fetchHeight:(id)model;
+ (CGFloat)fetchHeight:(id)model selectorName:(NSString *)strSelectorName;
+ (CGFloat)fetchHeight:(id)model par:(id)par className:(NSString *)strClassName selectorName:(NSString *)strSelectorName;
+ (CGFloat)fetchHeight:(id)model className:(NSString *)strClassName selectorName:(NSString *)strSelectorName;

#pragma mark - 判断是否显示在屏幕上
- (BOOL)isShowInScreen;

#pragma mark - views 组合
+ (instancetype)initWithViews:(NSArray *)ary;

#pragma mark - 灰色背景
+ (instancetype)initGrayBgWithViews:(NSArray *)ary;

@end
