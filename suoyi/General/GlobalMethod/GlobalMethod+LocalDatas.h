//
//  GlobalMethod+LocalDatas.h
//  乐销
//
//  Created by 隋林栋 on 2017/1/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod.h"

@interface GlobalMethod (LocalDatas)

//模块数据读存
+ (void)writeAry:(NSArray *)aryModels key:(NSString *)localKey;
//model数据读存
+ (void)writeModel:(id)model key:(NSString *)localKey;
+ (id)readModelForKey:(NSString *)localKey modelName:(NSString *)modelName;
+ (NSMutableArray *)readAry:(NSString *)localKey modelName:(NSString *)modelName;
+ (NSMutableArray *)readAry:(NSString *)localKey modelName:(NSString *)modelName exchangeToModel:(NSString *)returnModelName;
+ (NSString *)writeToLocalFile:(id)response;
//清空本地数据
+ (void)clearUserDefault;

#pragma mark - 存储本地数据
+ (void)writeStr:(NSString *)strValue forKey:(NSString *)strKey;
+ (NSString *)readStrFromUser:(NSString *)strKey;
+ (void)writeDate:(NSDate *)date  forKey:(NSString *)strKey;
+ (void)writeBool:(BOOL)bol local:(NSString *)noti;
+ (BOOL)readBoolLocal:(NSString *)noti;
+ (NSDate *)readDateFromUser:(NSString *)strKey;
+ (void)writeDataToUser:(NSData *)data forKey:(NSString *)strKey;
+ (NSData *)readDataFromUser:(NSString *)strKey;

@end
