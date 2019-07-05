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
//按手机号搜索好友
+ (void)requestFriendSearchByPhoneWithPhone:(NSString *)phone
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"phone":UnPackStr(phone)
                          };
    [self getUrl:@"/mobile/friend/searchbyphone" delegate:delegate parameters:dic success:success failure:failure];
}
//按手机号搜索好友
+ (void)requestFriendSearchByIdWithUserId:(NSString *)user_id
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"user_id":UnPackStr(user_id)
                          };
    [self getUrl:@"/mobile/friend/searchbyid" delegate:delegate parameters:dic success:success failure:failure];
}
//创建一个群
+ (void)requestUserGroupCreateGroupWithGname:(NSString *)gname
                                     gnotice:(NSString *)gnotice
                                     invites:(NSString *)invites
                                    delegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"gname":UnPackStr(gname),
                          @"gnotice":UnPackStr(gnotice),
                          @"invites":UnPackStr(invites)
                          };
    [self postUrl:@"/mobile/userGroup/creategroup" delegate:delegate parameters:dic success:success failure:failure];
}
//返回用户涉及的群
+ (void)requestUserGroupFetchGroupWithDelegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure{
    [self postUrl:@"/mobile/userGroup/fetchgroup" delegate:delegate parameters:nil success:success failure:failure];
}
///创建家庭组
+ (void)requestUserGroupCreateFamilyGroupWithFname:(NSString *)fname
                                           invites:(NSString *)invites
                                          delegate:(id <RequestDelegate>)delegate
                                           success:(void (^)(NSDictionary * response, id mark))success
                                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"fname":UnPackStr(fname),
                          @"invites":UnPackStr(invites)
                          };
    [self postUrl:@"/mobile/userGroup/createfamilygroup" delegate:delegate parameters:dic success:success failure:failure];
}
///查询家庭组
+ (void)requestUserGroupFetchFamilyGroupWithDelegate:(id <RequestDelegate>)delegate
                                             success:(void (^)(NSDictionary * response, id mark))success
                                             failure:(void (^)(NSString * errorStr, id mark))failure{
    [self postUrl:@"/mobile/userGroup/fetchFamilyGroup" delegate:delegate parameters:nil success:success failure:failure];
}
///申请加好友
+ (void)requestFriendApplyWithFuid:(double)fuid
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"fuid":NSNumber.dou(fuid)
                          };
    [self postUrl:@"/mobile/friend/apply" delegate:delegate parameters:dic success:success failure:failure];
}
///查看好友（type 为0则是好友，为1则是待添加）
+ (void)requestFriendListWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    [self getUrl:@"/mobile/friend/list" delegate:delegate parameters:nil success:success failure:failure];
}
///同意添加好友
+ (void)requestFriendAgreeWithFuid:(double)fuid
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"fuid":NSNumber.dou(fuid)
                          };
    [self postUrl:@"/mobile/friend/agree" delegate:delegate parameters:dic success:success failure:failure];
}
///获得当前用户使用IM服务的认证令牌，第三方融云
+ (void)requestUserImtokenWithDelegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    [self getUrl:@"/mobile/user/imtoken" delegate:delegate parameters:nil success:success failure:failure];
}






@end
