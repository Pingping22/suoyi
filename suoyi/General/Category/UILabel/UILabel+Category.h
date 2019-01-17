//
//  UILabel+Category.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

@property (nonatomic, assign) CGFloat lineSpace;//行间距 只有扩展方法适配才能计算
@property (nonatomic, assign) CGFloat fontNum;//设置字号
@property (nonatomic, assign) int numLimit;//字符数限制

#pragma mark - 固定宽度
- (void)fitFixed:(CGFloat)width;
- (void)fitTitle:(NSString *)title fixed:(CGFloat)width;

#pragma mark - 可变宽度
- (void)fitVariable:(CGFloat)width;
- (void)fitTitle:(NSString *)title variable:(CGFloat)width;

@end
