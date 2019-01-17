//
//  BaseNavView.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BASENAVVIEW_LEFT_TITLE_FONT_NUM F(15)

@interface BaseNavView : UIView

@property (nonatomic, strong) UILabel * labelTitle;
@property (nonatomic, strong) UIControl * backBtn;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) void (^leftBlock)();
@property (nonatomic, strong) void (^rightBlock)();
@property (nonatomic, strong) void (^blockBack)();
@property (nonatomic, assign) BOOL isNotShowEditAlert;

#pragma mark - 刷新页面
+ (instancetype)initNavTitle:(NSString *)title
                    leftView:(UIView *)leftView
                   rightView:(UIView *)rigthView;
- (void)resetNavTitle:(NSString *)title
             leftView:(UIView *)leftView
            rightView:(UIView *)rightView;

#pragma mark - 左返回 右view
+ (instancetype)initNavBackTitle:(NSString *)title
                       rightView:(UIView *)rigthView;


#pragma mark - 左图片 右图片
+ (instancetype)initNavTitle:(NSString *)title
               leftImageName:(NSString *)leftImageName
                   leftBlock:(void (^)())leftBlock
              rightImageName:(NSString *)rightImageName
                   righBlock:(void (^)())rightBlock;

#pragma mark - 返回 右图片
+ (instancetype)initNavBackWithTitle:(NSString *)title
                      rightImageName:(NSString *)rightImageName
                           righBlock:(void (^)())rightBlock;
#pragma mark - 返回 右文字
+ (instancetype)initNavBackTitle:(NSString *)title
                      rightTitle:(NSString *)rightTitle
                      rightBlock:(void (^)())rightBlock;

#pragma mark - 更改title
- (void)changeTitle:(NSString *)title;

#pragma mark - 更改nav right title
- (void)changeRightTitle:(NSString *)title;
#pragma mark - 更改nav right image
- (void)changeRightImage:(NSString *)imageName;



#pragma mark - 设置图片
+ (void)resetControl:(UIView*) control
           imageName:(NSString *) imageName
              isLeft:(BOOL)isLeft;
+ (void)resetControl:(UIView*) control
               title:(NSString *) title
              isLeft:(BOOL)isLeft;

#pragma mark - 设置蓝色模式
- (void)restBlueStyle;

#pragma mark - 点击事件
- (void)btnBackClick;

@end
