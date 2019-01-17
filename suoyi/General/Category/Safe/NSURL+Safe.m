//
//  NSURL+Safe.m
//  lanberProject
//
//  Created by lirenbo on 2018/7/25.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "NSURL+Safe.h"

@implementation NSURL (Safe)

//运行时 安全
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getClassMethod(self, @selector(URLWithString:)), class_getClassMethod(self, @selector(safeURLWithString:)));
    });
}

+ (NSURL *)safeURLWithString:(NSString *)string{
    if (isStr(string)) {
        return [self safeURLWithString:string];
    }else{
        return [self safeURLWithString:@""];
    }
}

@end
