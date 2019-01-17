//
//  RequestApi+RequestMicroService.m
//  乐销
//
//  Created by 隋林栋 on 2018/3/6.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "RequestApi+RequestMicroService.h"
//请求单例
#import "RequestInstance.h"
#import "AFHTTPSessionManager.h"



typedef NS_ENUM(NSUInteger, ENUM_REQUEST_TYPE) {
    ENUM_REQUEST_TYPE_GET,
    ENUM_REQUEST_TYPE_POST,
    ENUM_REQUEST_TYPE_PUT,
    ENUM_REQUEST_TYPE_DELETE,
    ENUM_REQUEST_TYPE_PATCH
};

@implementation RequestApi (RequestMicroService)

NSString * kResponseData = @"data";
NSString * kResponseMessage = @"msg";
NSString * kResponseCode = @"code";
double kResponseCodeSuccess = 0;

//get
+ (void)get:(NSString *)URL
   delegate:(id <RequestDelegate>)delegate
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSDictionary * response, id mark))success
    failure:(void (^)(NSString * errorStr, id mark))failure{
    [self requestURL:URL delegate:delegate parameters:parameters returnAll:[parameters doubleValueForKey:KEY_REQUEST_RETURN_ALL] type:ENUM_REQUEST_TYPE_GET constructingBodyWithBlock:nil success:success failure:failure];
}
// post
+ (void)post:(NSString *)URL
    delegate:(id <RequestDelegate>)delegate
  parameters:(NSDictionary *)parameters
     success:(void (^)(NSDictionary * response, id mark))success
     failure:(void (^)(NSString * errorStr, id mark))failure{
    [self requestURL:URL delegate:delegate parameters:parameters returnAll:[parameters doubleValueForKey:KEY_REQUEST_RETURN_ALL] type:ENUM_REQUEST_TYPE_POST constructingBodyWithBlock:nil success:success failure:failure];
    
}
// post file
+ (void)post:(NSString *)URL
    delegate:(id <RequestDelegate>)delegate
  parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
     success:(void (^)(NSDictionary * response, id mark))success
     failure:(void (^)(NSString * errorStr, id mark))failure{
    [self requestURL:URL delegate:delegate parameters:parameters returnAll:[parameters doubleValueForKey:KEY_REQUEST_RETURN_ALL] type:ENUM_REQUEST_TYPE_POST constructingBodyWithBlock:block success:success failure:failure];

}

// put
+ (void)put:(NSString *)URL
   delegate:(id <RequestDelegate>)delegate
 parameters:(NSDictionary *)parameters
    success:(void (^)(NSDictionary * response, id mark))success
    failure:(void (^)(NSString * errorStr, id mark))failure{
    [self requestURL:URL delegate:delegate parameters:parameters returnAll:[parameters doubleValueForKey:KEY_REQUEST_RETURN_ALL] type:ENUM_REQUEST_TYPE_PUT constructingBodyWithBlock:nil success:success failure:failure];
    
}

//delete
+ (void)delete:(NSString *)URL
      delegate:(id <RequestDelegate>)delegate
    parameters:(NSDictionary *)parameters
       success:(void (^)(NSDictionary * response, id mark))success
       failure:(void (^)(NSString * errorStr, id mark))failure{
    [self requestURL:URL delegate:delegate parameters:parameters returnAll:[parameters doubleValueForKey:KEY_REQUEST_RETURN_ALL] type:ENUM_REQUEST_TYPE_DELETE constructingBodyWithBlock:nil success:success failure:failure];
    
}

//patch
+ (void)patch:(NSString *)URL
     delegate:(id <RequestDelegate>)delegate
   parameters:(NSDictionary *)parameters
      success:(void (^)(NSDictionary * response, id mark))success
      failure:(void (^)(NSString * errorStr, id mark))failure{
    [self requestURL:URL delegate:delegate parameters:parameters returnAll:[parameters doubleValueForKey:KEY_REQUEST_RETURN_ALL] type:ENUM_REQUEST_TYPE_PATCH constructingBodyWithBlock:nil success:success failure:failure];
    
}


+ (void)requestURL:(NSString *)URL
          delegate:(id <RequestDelegate>)delegate
        parameters:(NSDictionary *)parameters
         returnAll:(BOOL)returnAll
              type:(ENUM_REQUEST_TYPE)requestType
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
           success:(void (^)(NSDictionary * response, id mark))success
           failure:(void (^)(NSString * errorStr, id mark))failure
{
    //设置请求头
    parameters = [self setInitHead:parameters];
    
    //拼接参数
    NSString * urlNew =[URL hasPrefix:@"http"]?URL:[NSString stringWithFormat:@"%@%@",URL_HEAD,URL];
    
    NSString * url = [self setUrl:urlNew];
    //走回调 隐藏progress
    [GlobalMethod performSelector:@"protocolWillRequest" delegate:delegate];
    
    //选择请求方式
    [self request:url parameters:parameters type:requestType constructingBodyWithBlock:block   success:^(NSURLSessionDataTask *task, id responseObject) {
        //上拉 下拉 刷新
        [self endRefresh:delegate];
        //返回数据
        NSDictionary * dicResponse =  [GlobalMethod exchangeDataToDic:responseObject];
        if (dicResponse == nil ) {
            //走回调 隐藏progress
            [self requestFailDelegate:delegate errorStr:@"数据请求失败" errorCode:@"0" failure:failure];
            return ;
        }
        //判断请求状态
        if([dicResponse doubleValueForKey:kResponseCode] == kResponseCodeSuccess){
            [self requestSuccessDelegate:delegate responseDic:returnAll?dicResponse:dicResponse[kResponseData] success:success];
            return;
        }
        if([dicResponse[kResponseCode] isEqualToNumber:RESPONSE_CODE_NEGATIVE100]){
            //重新登陆
            [GlobalMethod relogin];
            return;
        }
        {
            //走回调 请求失败
            [self requestFailDelegate:delegate errorStr:dicResponse[kResponseMessage] errorCode:isNum(dicResponse[kResponseCode])?[NSString stringWithFormat:@"%@",dicResponse[kResponseCode]]:@"0"  failure:failure];
            return;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        //上拉 下拉 刷新
        [self endRefresh:delegate];
        NSLog(@"%@",error.userInfo);
        //走回调 网络连接失败
        [self requestFailDelegate:delegate errorStr:@"网络连接失败" errorCode:@"0" failure:failure];
    }];
}

#pragma mark 选择请求
+ (void)request:(NSString *)URLString
     parameters:(id)parameters
           type:(ENUM_REQUEST_TYPE)type
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSURLSessionDataTask * task;
    switch (type) {
        case ENUM_REQUEST_TYPE_GET:
        {
            
            task = [[RequestInstance sharedInstance] GET:URLString parameters:parameters progress:nil  success:success failure:failure];
        }
            break;
        case ENUM_REQUEST_TYPE_POST:
        {
            task = [[RequestInstance sharedInstance] POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil  success:success failure:failure];
        }
            break;
        case ENUM_REQUEST_TYPE_PATCH:
        {
            task = [[RequestInstance sharedInstance] PATCH:URLString  parameters:parameters   success:success failure:failure];
        }
            break;
        case ENUM_REQUEST_TYPE_DELETE:
        {
            task = [[RequestInstance sharedInstance] DELETE:URLString parameters:parameters   success:success failure:failure];
            
        }
            break;
        case ENUM_REQUEST_TYPE_PUT:
        {
            task = [[RequestInstance sharedInstance] PUT:URLString parameters:parameters   success:success failure:failure];
        }
            break;
        default:
            break;
    }
}

#pragma mark 拼接基础头字符串
+ (NSString *)setUrl:(NSString *)url{
    
    NSString *token =[GlobalData sharedInstance].GB_Key;
    
    if ([url rangeOfString:@"token"].location != NSNotFound) {
        return url;
    }
    if (!isStr(token)){
        return [NSString stringWithFormat:@"%@?token=0",url];
    }
    if ([url rangeOfString:@"?"].location != NSNotFound) {
        url = [url hasSuffix:@"?"]?[NSString stringWithFormat:@"%@token=%@",url,token]:[NSString stringWithFormat:@"%@&token=%@",url,token];
    }else{
        url = [NSString stringWithFormat:@"%@?token=%@",url,token];
    }
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
