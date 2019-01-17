//
//  GlobalMethod+UI.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "GlobalMethod+UI.h"

@implementation GlobalMethod (UI)

#pragma mark - 计算高度 宽度
+ (CGFloat)fetchHeightFromLabel:(UILabel *)label{
    return [self fetchHeightFromLabel:label heightLimit:10000];
}
+ (CGFloat)fetchHeightFromLabel:(UILabel *)label heightLimit:(CGFloat )height{
    if (label == nil) {
        return 0;
    }
    NSAttributedString * attributeString = [[NSAttributedString alloc]initWithString:!isStr(label.text)? @"A":label.text attributes:@{NSFontAttributeName: label.font}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(label.width, height)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat num_height_return = rect.size.height+1;
    //限制行数
    if (label.numberOfLines != 0) {
        attributeString = [[NSAttributedString alloc]initWithString:@"A" attributes:@{NSFontAttributeName: label.font}];
        rect =[attributeString boundingRectWithSize:CGSizeMake(label.width, height)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        num_height_return = num_height_return >label.numberOfLines*rect.size.height?label.numberOfLines*rect.size.height:num_height_return;
    }
    return ceil(num_height_return);
}
+ (CGFloat)fetchWidthFromLabel:(UILabel *)label{
    NSString * strContent = label.text == nil ? @"":label.text;
    
    UIFont * font = label.font;
    NSAttributedString * attributeString = [[NSAttributedString alloc]initWithString:strContent attributes:@{NSFontAttributeName: font}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(1000, 1000)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    //    NSLog(@"ceil Before: %lf",rect.size.width);
    return ceil(rect.size.width);
}
+ (CGFloat)fetchWidthFromButton:(UIButton *)btn{
    UILabel * label = [UILabel new];
    label.font = btn.titleLabel.font;
    label.text = btn.titleLabel.text;
    return [self fetchWidthFromLabel:label];
}
+ (CGFloat)fetchHeightFromFont:(NSInteger)fontNum{
    NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:@"A" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontNum]}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(INTMAX_MAX, INTMAX_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return  rect.size.height;
}

#pragma mark - 设置label
+ (void)setLabel:(UILabel *)label
      widthLimit:(CGFloat )widthLimit
        numLines:(NSInteger)numLines
         fontNum:(CGFloat)fontNum
       textColor:(UIColor *)textColor
         aligent:(NSTextAlignment )aligent
            text:(NSString *)text
         bgColor:(UIColor *)color{
    label.numberOfLines = numLines;
    label.font = [UIFont systemFontOfSize:fontNum];
    label.textColor = textColor == nil? COLOR_LABEL : textColor;
    label.textAlignment = aligent;
    label.backgroundColor = color == nil?[UIColor clearColor]:color;
    label.text = UnPackStr(text);
    CGFloat widthMAX= [self fetchWidthFromLabel:label];
    //NSLog(@"widthMAX : %lf",widthMAX);
    if (widthLimit != 0 ) {
        if (widthMAX < widthLimit) {
            label.width = widthMAX;
        }else {
            label.width = widthLimit;
        }
    }else {
        label.width = widthMAX;
    }
    label.height = [self fetchHeightFromLabel:label];
}

+ (void)setLabel:(UILabel *)label
      widthLimit:(CGFloat )widthLimit
        numLines:(NSInteger)numLines
         fontNum:(CGFloat)fontNum
       textColor:(UIColor *)textColor
            text:(NSString *)text{
    [self setLabel:label widthLimit:widthLimit numLines:numLines fontNum:fontNum textColor:textColor aligent:label.textAlignment text:text bgColor:[UIColor clearColor]];
}
+ (void)resetLabel:(UILabel *)label
              text:(NSString *)text
      isWidthLimit:(BOOL )isWidthLimit
{
    if (isWidthLimit) {
        [self resetLabel:label text:text widthLimit:label.width];
    }else {
        [self resetLabel:label text:text widthLimit:0];
    }
}

+ (void)resetLabel:(UILabel *)label
              text:(NSString *)text
        widthLimit:(CGFloat )widthLimit
{
    [self setLabel:label widthLimit:widthLimit numLines:label.numberOfLines fontNum:label.font.pointSize textColor:label.textColor aligent:label.textAlignment text:text bgColor:label.backgroundColor];
}

+ (void)resetLabel:(UILabel *)label
   attributeString:(NSAttributedString *)text
        widthLimit:(CGFloat )widthLimit{
    label.attributedText = text;
    CGRect rect =[text boundingRectWithSize:CGSizeMake(widthLimit, 1000)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    label.width = MIN(CGRectGetWidth(rect), widthLimit?:CGFLOAT_MAX);
    //限制行数
    label.height = [self fetchHeightFromLabel:label heightLimit:CGFLOAT_MAX];
    //label.height = rect.size.height+1;
}

#pragma mark - 设置圆角
+ (void)setRoundView:(UIView *)iv color:(UIColor *)color
{
    [self setRoundView:iv color:color numRound:4 width:4];
}

+ (void)setRoundView:(UIView *)iv color:(UIColor *)color numRound:(CGFloat)numRound width:(CGFloat)width
{
    iv.layer.cornerRadius = numRound;//圆角设置
    iv.layer.masksToBounds = YES;
    [iv.layer setBorderWidth:width];
    iv.layer.borderColor = color.CGColor;
}

#pragma mark - 改变状态栏
// exhcnage status bar
+ (void)exchangeStatusBar:(UIStatusBarStyle) statusBarStyle{
    [GlobalData sharedInstance].statusBarStyle = statusBarStyle;
    UIViewController * lastVC = GB_Nav.lastVC;
    [lastVC setNeedsStatusBarAppearanceUpdate];
}
+ (void)exchangeStatusBarHidden:(BOOL)hidden{
    [GlobalData sharedInstance].statusHidden = hidden;
    UIViewController * lastVC = GB_Nav.lastVC;
    [lastVC setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 收键盘
+ (void)endEditing{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:true];
}

@end
