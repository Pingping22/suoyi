//
//  GlobalMethod+UI.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "GlobalMethod.h"

@interface GlobalMethod (UI)

#pragma mark - 计算高度 宽度
+ (CGFloat)fetchHeightFromLabel:(UILabel *)label;
+ (CGFloat)fetchHeightFromLabel:(UILabel *)label heightLimit:(CGFloat )height;
+ (CGFloat)fetchWidthFromLabel:(UILabel *)label;
+ (CGFloat)fetchWidthFromButton:(UIButton *)btn;
+ (CGFloat)fetchHeightFromFont:(NSInteger)fontNum;

#pragma mark - 设置label
+ (void)setLabel:(UILabel *)label widthLimit:(CGFloat )widthLimit numLines:(NSInteger)numLines fontNum:(CGFloat)fontNum textColor:(UIColor *)textColor aligent:(NSTextAlignment )aligent text:(NSString *)text bgColor:(UIColor *)color;
+ (void)setLabel:(UILabel *)label widthLimit:(CGFloat )widthLimit numLines:(NSInteger)numLines fontNum:(CGFloat)fontNum textColor:(UIColor *)textColor text:(NSString *)text;
+ (void)resetLabel:(UILabel *)label text:(NSString *)text isWidthLimit:(BOOL )isWidthLimit;
+ (void)resetLabel:(UILabel *)label text:(NSString *)text widthLimit:(CGFloat )widthLimit;
+ (void)resetLabel:(UILabel *)label attributeString:(NSAttributedString *)text widthLimit:(CGFloat )widthLimit;

#pragma mark - 设置圆角
+ (void)setRoundView:(UIView *)iv color:(UIColor *)color;
+ (void)setRoundView:(UIView *)iv color:(UIColor *)color numRound:(CGFloat)numRound width:(CGFloat)width;

#pragma mark - 收键盘
+ (void)endEditing;

@end
