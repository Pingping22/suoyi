//
//  NSMutableParagraphStyle+Category.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "NSMutableParagraphStyle+Category.h"

@implementation NSMutableParagraphStyle (Category)

/**
 初始化
 
 @param lineSpace 行高
 @return 行高属性
 */
+ (instancetype)initWithLineSpace:(CGFloat)lineSpace{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = lineSpace;//行距
    return paragraphStyle;
    
}

@end
