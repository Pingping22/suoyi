//
//  RequestApi.h
//  yiliantiPersonal
//
//  Created by lirenbo on 2016/12/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFURLRequestSerialization.h>
@protocol RequestDelegate <NSObject>

@optional

@property (nonatomic, assign) BOOL isNotShowNoticeView;

- (void)protocolWillRequest;
- (void)protocolDidRequestSuccess;
- (void)protocolDidRequestFailure:(NSString *) errorStr;

@end


@interface RequestApi : NSObject

#pragma mark - 网络请求
// post
+ (void)postUrl:(NSString *)URL
       delegate:(id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure;

//get
+ (void)getUrl:(NSString *)URL
      delegate:(id <RequestDelegate>)delegate
    parameters:(NSDictionary *)parameters
       success:(void (^)(NSDictionary * response, id mark))success
       failure:(void (^)(NSString * errorStr, id mark))failure;

//上传图片
+ (void)postUrl:(NSString *)URL
       delegate:(id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure;

#pragma mark - 网络请求 返回全部
// post
+ (void)postUrl:(NSString *)URL
       delegate:(id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
      returnALL:(BOOL)returnAll
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure;

//get
+ (void)getUrl:(NSString *)URL
      delegate:(id <RequestDelegate>)delegate
    parameters:(NSDictionary *)parameters
     returnALL:(BOOL)returnAll
       success:(void (^)(NSDictionary * response, id mark))success
       failure:(void (^)(NSString * errorStr, id mark))failure;

//上传图片
+ (void)postUrl:(NSString *)URL
       delegate:(id <RequestDelegate>)delegate
     parameters:(NSDictionary *)parameters
      returnALL:(BOOL)returnAll
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSDictionary * response, id mark))success
        failure:(void (^)(NSString * errorStr, id mark))failure;

#pragma mark - 拼接基础头字符串
+ (NSMutableDictionary *)setInitHead:(NSDictionary *)dicParameters;


#pragma mark - success
+ (void)requestSuccessDelegate:(id<RequestDelegate>)delegate responseDic:(NSDictionary *)responseDic success:(void (^)(NSDictionary * response, id mark))success;

#pragma mark - fail
+ (void)requestFailDelegate:(id<RequestDelegate>)delegate errorStr:(NSString *)strError errorCode:(NSString *)errorCode failure:(void (^)(NSString * errorStr, id mark))failure;

#pragma mark - 上拉 下拉刷新
+ (void)endRefresh:(id)delegate;

#pragma mark - 展示无数据
+ (void)showNoResult:(id)delegate;

@end

