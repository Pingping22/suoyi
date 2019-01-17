//
//  RequestApi+RequestMicroService.h
//  乐销
//
//  Created by 隋林栋 on 2018/3/6.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "RequestApi.h"
#define KEY_REQUEST_RETURN_ALL @"KEY_REQUEST_RETURN_ALL"

@interface RequestApi (RequestMicroService)

#pragma mark - 网络请求
//get
+ (void)get:(NSString *)URL
   delegate:(id <RequestDelegate>)delegate
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSDictionary * response, id mark))success
    failure:(void (^)(NSString * errorStr, id mark))failure;

// post
+ (void)post:(NSString *)URL
       delegate:(id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure;
// post file
+ (void)post:(NSString *)URL
    delegate:(id <RequestDelegate>)delegate
  parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
     success:(void (^)(NSDictionary * response, id mark))success
     failure:(void (^)(NSString * errorStr, id mark))failure;

// put
+ (void)put:(NSString *)URL
    delegate:(id <RequestDelegate>)delegate
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSDictionary * response, id mark))success
     failure:(void (^)(NSString * errorStr, id mark))failure;

//delete
+ (void)delete:(NSString *)URL
   delegate:(id <RequestDelegate>)delegate
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSDictionary * response, id mark))success
    failure:(void (^)(NSString * errorStr, id mark))failure;

//patch
+ (void)patch:(NSString *)URL
     delegate:(id <RequestDelegate>)delegate
   parameters:(NSDictionary *)parameters
      success:(void (^)(NSDictionary * response, id mark))success
      failure:(void (^)(NSString * errorStr, id mark))failure;
@end
