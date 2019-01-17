//
//  RequestApi+Recommend.m
//  lanberProject
//
//  Created by runda on 2018/9/27.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "RequestApi+Recommend.h"
#import "NSNumber+Category.h"
@implementation RequestApi (Recommend)

///获取本地数据
+ (void)requestLocalDataKey:(NSString *)key
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    [RequestApi postUrl:@"https://ldngjapi.laodao.so/ASHX/ad/ad_class.ashx?action=myclass" delegate:delegate parameters:nil success:^(NSDictionary * response, id mark){
        NSDictionary * responseLocal = [self readLocalRequestData:key];
        if (success) {
            success(responseLocal,mark);
        }
    } failure:failure];
}

+ (NSDictionary *)readLocalRequestData:(NSString *)key
{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:key ofType:@".json"];
    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithContentsOfFile:strPath] options:NSJSONReadingMutableContainers error:nil];
}

//请求农产品列表
+ (void)requestAgriculturalProductsListWithPageNum:(double)pageNum
                                          delegate:(id <RequestDelegate>)delegate
                                           success:(void (^)(NSDictionary * response, id mark))success
                                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSString * url = [NSString stringWithFormat:@"http://nzscw.w.cxzg.com/ios2.php/Product/index.html?isajax=1&areaid=1&cateid=0&orderby=putong&key=&p=%@",NSNumber.dou(pageNum)];
    [RequestApi postUrl:url delegate:delegate parameters:nil returnALL:YES success:success failure:failure];
}

@end
