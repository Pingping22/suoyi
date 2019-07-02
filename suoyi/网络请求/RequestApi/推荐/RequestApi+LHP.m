//
//  RequestApi+LHP.m
//  suoyi
//
//  Created by 王伟 on 2019/7/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "RequestApi+LHP.h"

@implementation RequestApi (LHP)
//用户注册
+ (void)requestUserRegisterWithPhone:(NSString *)phone
                            password:(NSString *)password
                                nick:(NSString *)nick
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"phone":UnPackStr(phone),
                          @"password":UnPackStr(password),
                          @"nick":UnPackStr(nick)};
    [self postUrl:@"/mobile/user/register" delegate:delegate parameters:dic success:success failure:failure];
}
//获取验证码
+ (void)requestUserSmcodeWithPhone:(NSString *)phone
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"phone":UnPackStr(phone)};
    [self postUrl:@"/mobile/user/smcode" delegate:delegate parameters:dic success:success failure:failure];
}
//验证验证码
+ (void)requestUserVerfiySmcodeWithPhone:(NSString *)phone
                                  smCode:(NSString *)smCode
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"phone":UnPackStr(phone),
                          @"smCode":UnPackStr(smCode)};
    [self postUrl:@"/mobile/user/verfiysmcode" delegate:delegate parameters:dic success:success failure:failure];
}
//用户登录
+ (void)requestUserLoginWithPhone:(NSString *)phone
                         password:(NSString *)password
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"phone":UnPackStr(phone),
                          @"password":UnPackStr(password)};
    [self postUrl:@"/mobile/user/login" delegate:delegate parameters:dic success:success failure:failure];
}
//修改密码
+ (void)requestUserUpdatepwWithPhone:(NSString *)phone
                                 opw:(NSString *)opw
                                 npw:(NSString *)npw
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"phone":UnPackStr(phone),
                          @"opw":UnPackStr(opw),
                          @"npw":UnPackStr(npw)
                          };
    [self postUrl:@"/mobile/user/updatepw" delegate:delegate parameters:dic success:success failure:failure];
}
@end
