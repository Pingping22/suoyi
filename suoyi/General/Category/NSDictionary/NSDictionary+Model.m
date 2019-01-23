//
//  NSDictionary+Model.m
//  乐销
//
//  Created by liuhuiping on 2017/11/29.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NSDictionary+Model.h"

@implementation NSDictionary (Model)

- (double)doubleValueForKey:(NSString *)key{
    //判断key类型
    if (key && [key isKindOfClass:[NSString class]]) {
         id value = [self objectForKey:key];
        //判断value类型
        if (value&&([value isKindOfClass:[NSString class]]||[value isKindOfClass:[NSNumber class]])) {
            return [value doubleValue];
        }
    }
    return 0;
}
- (int)intValueForKey:(NSString *)key{
    //判断key类型
    if (key && [key isKindOfClass:[NSString class]]) {
        id value = [self objectForKey:key];
        //判断value类型
        if (value&&([value isKindOfClass:[NSString class]]||[value isKindOfClass:[NSNumber class]])) {
            return [value intValue];
        }
    }
    return 0;
}
- (BOOL)boolValueForKey:(NSString *)key{
    //判断key类型
    if (key && [key isKindOfClass:[NSString class]]) {
        id value = [self objectForKey:key];
        //判断value类型
        if (value&&([value isKindOfClass:[NSString class]]||[value isKindOfClass:[NSNumber class]])) {
            return [value boolValue];
        }
    }
    return 0;
}
- (NSNumber *)numberValueForKey:(NSString *)key{
    //判断key类型
    if (key && [key isKindOfClass:[NSString class]]) {
        NSNumber *value = [self objectForKey:key];
        //判断value类型
        if (value && [value isKindOfClass:[NSNumber class]]) {
            return value;
        }
    }
    return 0;
}
- (NSString *)stringValueForKey:(NSString *)key{
    //判断key类型
    if (key && [key isKindOfClass:[NSString class]]) {
        NSString *value = [self objectForKey:key];
        //判断value类型
        if (value && [value isKindOfClass:[NSString class]]) {
            return value;
        }
    }
    return @"";
}
- (NSArray *)arrayValueForKey:(NSString *)key{
    //判断key类型
    if (key && [key isKindOfClass:[NSString class]]) {
        NSArray *value = [self objectForKey:key];
        //判断value类型
        if (value && [value isKindOfClass:[NSArray class]]) {
            return value;
        }
    }
    return @[];
}
- (NSDictionary *)dictionaryValueForKey:(NSString *)key{
    //判断key类型
    if (key && [key isKindOfClass:[NSString class]]) {
        NSDictionary *value = [self objectForKey:key];
        //判断value类型
        if (value && [value isKindOfClass:[NSDictionary class]]) {
            return value;
        }
    }
    return @{};
}

@end