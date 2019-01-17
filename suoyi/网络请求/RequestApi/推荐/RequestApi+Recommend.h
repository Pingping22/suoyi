//
//  RequestApi+Recommend.h
//  lanberProject
//
//  Created by runda on 2018/9/27.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Recommend)

//获取本地数据
+ (void)requestLocalDataKey:(NSString *)key
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure;

+ (NSDictionary *)readLocalRequestData:(NSString *)key;

//请求农产品列表
+ (void)requestAgriculturalProductsListWithPageNum:(double)pageNum
                                          delegate:(id <RequestDelegate>)delegate
                                           success:(void (^)(NSDictionary * response, id mark))success
                                           failure:(void (^)(NSString * errorStr, id mark))failure;


@end

NS_ASSUME_NONNULL_END
