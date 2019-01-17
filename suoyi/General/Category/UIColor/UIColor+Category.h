//
//  UIColor+Category.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

+(UIColor *)colorWithHexString:(NSString *)str;
+(UIColor *)colorWithHexString:(NSString *)str alpha:(double)alpha;

@end
