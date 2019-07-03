//
//  ModelUser.h
//
//  Created by 京涛 刘 on 2018/3/30
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelAddress;
@interface ModelUser : NSObject

@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double ethnicGroup;
@property (nonatomic, strong) NSString *sina;
@property (nonatomic, assign) double marriageStatus;
@property (nonatomic, strong) NSString *weChat;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSArray *contactPhone;
@property (nonatomic, assign) double bloodGroup;
@property (nonatomic, strong) NSString *chinaBirthday;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double constellation;
@property (nonatomic, strong) NSString *emergencyTel;
@property (nonatomic, strong) NSString *idCardBackUrl;
@property (nonatomic, strong) NSString *emergencyName;
@property (nonatomic, assign) double gender;
@property (nonatomic, strong) ModelAddress *home;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *idCard;
@property (nonatomic, strong) NSString *accountPhone;
@property (nonatomic, strong) NSString *idCardFrontUrl;
@property (nonatomic, assign) double number;
@property (nonatomic, strong) NSString *ali;
@property (nonatomic, assign) double chinaZodiacs;
@property (nonatomic, assign) double idCardAuth;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *accountIcon;
@property (nonatomic, strong) ModelAddress *nativePlace;
@property (nonatomic, assign) double politicsStatus;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, assign) double realNameAuth;
@property (nonatomic, strong) ModelAddress *hometown;
@property (nonatomic, assign) double birthdayDefault;
#pragma mark -需要修改
@property (nonatomic, assign) double departmentNumber;//部门id 考勤、获取部门信息使用
@property (nonatomic, strong) NSString *departName;//部门名称
@property (nonatomic, strong) NSString *pname;//职位名称
@property (nonatomic, assign) double btypes;//缺阴历阳历字段
@property (nonatomic, assign) double isAdm;//在公司中身份
@property (nonatomic, assign) double potId;//职位ID 转正
@property (nonatomic, strong) NSMutableArray *ctags;//个人标签数组
@property (nonatomic, strong) NSString *positionName;//职位名称
@property (nonatomic, strong) NSString *ecName;//环信用户名
@property (nonatomic, strong) NSString *ecPwd;//环信密码
//lhp_change
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) double uid;
@property (nonatomic, assign) double code;
@property (nonatomic, strong) NSString *fname;
@property (nonatomic, strong) NSString *avtar;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) double fid;
@property (nonatomic, strong) NSString *imtoken;
@property (nonatomic, strong) NSString *phone;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
