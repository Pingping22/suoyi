//
//  RequestApi+LHP.h
//  suoyi
//
//  Created by 王伟 on 2019/7/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (LHP)
///用户注册
+ (void)requestUserRegisterWithPhone:(NSString *)phone
                            password:(NSString *)password
                                nick:(NSString *)nick
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
///获取验证码
+ (void)requestUserSmcodeWithPhone:(NSString *)phone
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
///验证验证码
+ (void)requestUserVerfiySmcodeWithPhone:(NSString *)phone
                                  smCode:(NSString *)smCode
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
///用户登录
+ (void)requestUserLoginWithPhone:(NSString *)phone
                         password:(NSString *)password
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
///修改密码
+ (void)requestUserUpdatepwWithPhone:(NSString *)phone
                                 opw:(NSString *)opw
                                 npw:(NSString *)npw
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
///按手机号搜索好友
+ (void)requestFriendSearchByPhoneWithPhone:(NSString *)phone
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
///按手机号搜索好友
+ (void)requestFriendSearchByIdWithUserId:(NSString *)user_id
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
///创建一个群
+ (void)requestUserGroupCreateGroupWithGname:(NSString *)gname
                                     gnotice:(NSString *)gnotice
                                     invites:(NSString *)invites
                                    delegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
///返回用户涉及的群
+ (void)requestUserGroupFetchGroupWithDelegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;
///创建家庭组
+ (void)requestUserGroupCreateFamilyGroupWithFname:(NSString *)fname
                                     invites:(NSString *)invites
                                    delegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
///查询家庭组
+ (void)requestUserGroupFetchFamilyGroupWithDelegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;





@end

NS_ASSUME_NONNULL_END
