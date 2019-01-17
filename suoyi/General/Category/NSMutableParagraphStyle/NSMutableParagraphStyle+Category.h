//
//  NSMutableParagraphStyle+Category.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableParagraphStyle (Category)

/**
 初始化
 
 @param lineSpace 行高
 @return 行高属性
 */
+ (instancetype)initWithLineSpace:(CGFloat)lineSpace;

@end
