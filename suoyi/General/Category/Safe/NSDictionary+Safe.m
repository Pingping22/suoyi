//
//  NSDictionary+Safe.m
//  lanberProject
//
//  Created by lirenbo on 2018/7/25.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Catrgory.h"

@implementation NSDictionary (Safe)

//运行时安全
+ (void)load{
    [self SwizzlingMethod:@"initWithObjects:forKeys:count:" systemClassString:@"__NSPlaceholderDictionary" toSafeMethodString:@"initWithObjects_st:forKeys:count:" targetClassString:@"NSDictionary"];
}

-(instancetype)initWithObjects_st:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }else{
            rightCount++;
        }
    }
    self = [self initWithObjects_st:objects forKeys:keys count:rightCount];
    return self;
}

@end
