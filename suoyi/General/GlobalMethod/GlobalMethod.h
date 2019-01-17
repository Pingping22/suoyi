//
//  GlobalMethod.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalMethod : NSObject

#pragma mark - delegate执行selector
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate;
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object isHasReturn:(BOOL)isHasReturn;
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object object:(id)object2 isHasReturn:(BOOL)isHasReturn;

#pragma mark - 转换
//转换String to dic
+ (NSDictionary *)exchangeStringToDic:(NSString *)str;
//转换String to ary
+ (NSArray *)exchangeStringToAry:(NSString *)str;
//转换data to dic
+ (NSDictionary *)exchangeDataToDic:(NSData *)data;
//转换 dic to model
+ (id)exchangeDicToModel:(id)dic modelName:(NSString *)strName;
//转换dic to ary
+ (NSMutableArray *)exchangeDic:(id)response toAryWithModelName:(NSString *)modelName;
+ (NSMutableArray *)exchangeAryModelToAryDic:(NSArray *)response;

#pragma mark - 转换json
+ (NSString *)exchangeDicToJson:(id)object;
+ (NSString *)exchangeModelsToJson:(NSArray *)object;
+ (NSString *)exchangeModelToJson:(id)model;



#pragma mark - 获取版本号
+ (NSString *)getVersion;

#pragma mark - 获取APP名字
+ (NSString *)getAppName;

#pragma mark - 获取设备型号
+ (NSString *)LookDeviceName;

#pragma mark - 显示提示
+ (void)showAlert:(NSString *)strAlert;

@end
