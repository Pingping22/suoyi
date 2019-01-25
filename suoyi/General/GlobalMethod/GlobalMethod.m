//
//  GlobalMethod.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "GlobalMethod.h"
#import <sys/utsname.h>

@implementation GlobalMethod

#pragma mark - delegate执行selector
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate{
    return [self performSelector:selectorName delegate:delegate object:nil isHasReturn:false];
}
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object isHasReturn:(BOOL)isHasReturn{
    SEL selector = NSSelectorFromString(selectorName);
    if (delegate != nil && [delegate respondsToSelector:selector]) {
        if (isHasReturn) {
            id result;
            SuppressPerformSelectorLeakWarning(result = [delegate performSelector:selector withObject:object]);
            return result;
        }else{
            SuppressPerformSelectorLeakWarning([delegate performSelector:selector withObject:object]);
            return nil;
        }
    }
    return nil;
}
+ (id)performSelector:(NSString *)selectorName delegate:(id)delegate object:(id)object object:(id)object2 isHasReturn:(BOOL)isHasReturn{
    SEL selector = NSSelectorFromString(selectorName);
    if (delegate != nil && [delegate respondsToSelector:selector]) {
        if (isHasReturn) {
            id result;
            SuppressPerformSelectorLeakWarning(result = [delegate performSelector:selector withObject:object withObject:object2]);
            return result;
        }else{
            SuppressPerformSelectorLeakWarning([delegate performSelector:selector withObject:object withObject:object2]);
            return nil;
        }
    }
    return nil;
}

#pragma mark - 转换
//转换String to dic
+ (NSDictionary *)exchangeStringToDic:(NSString *)str{
    if (!isStr(str)) {
        return [NSDictionary dictionary];
    }
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dicReturn = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dicReturn;
}
//转换String to ary
+ (NSArray *)exchangeStringToAry:(NSString *)str{
    if (!isStr(str)) {
        return [NSArray array];
    }
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * aryReturn = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return aryReturn;
}
//转换data to dic
+ (NSDictionary *)exchangeDataToDic:(NSData *)data{
    //NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (data == nil || ![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}
//转换 dic to model
+ (id)exchangeDicToModel:(NSDictionary *)dic modelName:(NSString *)strName{
    if (!isStr(strName)) {
        return nil;
    }
    Class class = NSClassFromString(strName);
    if (class == nil) {
        return nil;
    }
    if ([dic isKindOfClass:[NSArray class]]) {
        return [self performSelector:@"modelObjectWithDictionary:" delegate:class object:[(NSArray *)dic lastObject] isHasReturn:true];
    }
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return [[class alloc]init];
    }
    return [self performSelector:@"modelObjectWithDictionary:" delegate:class object:dic isHasReturn:true];
}
//转换dic to ary
+ (NSMutableArray *)exchangeDic:(id)response toAryWithModelName:(NSString *)modelName{
    if (response == nil || !isStr(modelName)) {
        return [NSMutableArray array];
    }
    id class = NSClassFromString(modelName);
    if (class == nil) {
        return [NSMutableArray array];
    }
    if (response && [response isKindOfClass:[NSDictionary class]]) {
        if ([class respondsToSelector:@selector(modelObjectWithDictionary:)]) {
            id model = [class performSelector:@selector(modelObjectWithDictionary:) withObject:response];
            return [NSMutableArray arrayWithObject:model];
        }
    }
    if (response && [response isKindOfClass:[NSArray class]]) {
        NSMutableArray * aryReturn = [NSMutableArray array];
        for (NSDictionary * dic in (NSArray *)response) {
            if ([class respondsToSelector:@selector(modelObjectWithDictionary:)]) {
                id model = [class performSelector:@selector(modelObjectWithDictionary:) withObject:dic];
                [aryReturn addObject:model];
            }
        }
        return aryReturn;
    }
    return [NSMutableArray array];
}
+ (NSMutableArray *)exchangeAryModelToAryDic:(NSArray *)response{
    if (!isAry(response)) {
        return [NSMutableArray array];
    }
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (NSObject *subArrayObject in response) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [aryReturn addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [aryReturn addObject:subArrayObject];
        }
    }
    return aryReturn;
}

#pragma mark - 转换json
//字典或者数组转Json
+ (NSString *)exchangeDicToJson:(id)object{
    if (object == nil) {
        NSLog(@"error json转换错误");
        return @"";
    }
    if ([object isKindOfClass:[NSDictionary class]]||[object isKindOfClass:[NSArray class]]) {
        NSData * dataJson = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
        NSString * strJson = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];
        return strJson;
    }
    return @"";
}
//Model数组转换为jsong
+ (NSString *)exchangeModelsToJson:(NSArray *)object{
    if (object == nil) {
        NSLog(@"error json转换错误");
        return @"";
    }
    NSMutableArray * aryMu = [NSMutableArray new];
    if ([object isKindOfClass:[NSArray class]]) {
        for (id model in object) {
            NSDictionary * dic = [GlobalMethod performSelector:@"dictionaryRepresentation" delegate:model object:nil isHasReturn:true];
            if (dic != nil) {
                [aryMu addObject:dic];
            }
        }
    }
    return [self exchangeDicToJson:aryMu];
}
//model转换json
+ (NSString *)exchangeModelToJson:(id)model{
    if (!model) return @"";
    if (![model respondsToSelector:@selector(dictionaryRepresentation)]) return @"";
    NSDictionary * dicJson = [model dictionaryRepresentation];
    NSData * dataJson = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];
    NSString * strJson = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];
    return strJson!=nil?strJson:@"";
}




#pragma mark - 获取版本号
+ (NSString *)getVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

#pragma mark - 获取APP名字
+ (NSString *)getAppName{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    return appName;
}

#pragma mark - 获取设备型号
+ (NSString *)LookDeviceName{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    return  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

#pragma mark - 显示提示
+ (void)showAlert:(NSString *)strAlert{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:true];
    [[GlobalData sharedInstance].GB_NoticeView showNotice:strAlert time:1 frame:[UIScreen mainScreen].bounds viewShow:window ];
}
#pragma mark 收键盘
+ (void)hideKeyboard{
    UIViewController * vc = GB_Nav.lastVC;
    [vc.view endEditing:true];
}

@end
