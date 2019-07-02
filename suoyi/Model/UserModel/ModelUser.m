//
//  ModelUser.m
//
//  Created by 京涛 刘 on 2018/3/30
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "ModelUser.h"

NSString *const kModelUserBirthday = @"birthday";
NSString *const kModelUserStatus = @"status";
NSString *const kModelUserEthnicGroup = @"ethnicGroup";
NSString *const kModelUserSina = @"sina";
NSString *const kModelUserMarriageStatus = @"marriageStatus";
NSString *const kModelUserWeChat = @"weChat";
NSString *const kModelUserAccountName = @"accountName";
NSString *const kModelUserContactPhone = @"contactPhone";
NSString *const kModelUserBloodGroup = @"bloodGroup";
NSString *const kModelUserChinaBirthday = @"chinaBirthday";
NSString *const kModelUserRealName = @"realName";
NSString *const kModelUserConstellation = @"constellation";
NSString *const kModelUserEmergencyTel = @"emergencyTel";
NSString *const kModelUserIdCardBackUrl = @"idCardBackUrl";
NSString *const kModelUserEmergencyName = @"emergencyName";
NSString *const kModelUserGender = @"gender";
NSString *const kModelUserHome = @"home";
NSString *const kModelUserEmail = @"email";
NSString *const kModelUserIdCard = @"idCard";
NSString *const kModelUserAccountPhone = @"accountPhone";
NSString *const kModelUserIdCardFrontUrl = @"idCardFrontUrl";
NSString *const kModelUserNumber = @"number";
NSString *const kModelUserAli = @"ali";
NSString *const kModelUserChinaZodiacs = @"chinaZodiacs";
NSString *const kModelUserIdCardAuth = @"idCardAuth";
NSString *const kModelUserIntroduction = @"introduction";
NSString *const kModelUserAccountIcon = @"accountIcon";
NSString *const kModelUserNativePlace = @"nativePlace";
NSString *const kModelUserPoliticsStatus = @"politicsStatus";
NSString *const kModelUserQq = @"qq";
NSString *const kModelUserRealNameAuth = @"realNameAuth";
NSString *const kModelUserHometown = @"hometown";
NSString *const kModelUserBirthdayDefault =@"birthdayDefault";
//lhp
NSString *const kModelUserNick = @"nick";
NSString *const kModelUserUid = @"uid";
NSString *const kModelUserCode = @"code";
NSString *const kModelUserFname = @"fname";
NSString *const kModelUserAvtar = @"avtar";
NSString *const kModelUserMsg = @"msg";
NSString *const kModelUserFid = @"fid";
NSString *const kModelUserImtoken = @"imtoken";

@interface ModelUser ()
@end

@implementation ModelUser

@synthesize birthday = _birthday;
@synthesize status = _status;
@synthesize ethnicGroup = _ethnicGroup;
@synthesize sina = _sina;
@synthesize marriageStatus = _marriageStatus;
@synthesize weChat = _weChat;
@synthesize accountName = _accountName;
@synthesize contactPhone = _contactPhone;
@synthesize bloodGroup = _bloodGroup;
@synthesize chinaBirthday = _chinaBirthday;
@synthesize realName = _realName;
@synthesize constellation = _constellation;
@synthesize emergencyTel = _emergencyTel;
@synthesize idCardBackUrl = _idCardBackUrl;
@synthesize emergencyName = _emergencyName;
@synthesize gender = _gender;
@synthesize home = _home;
@synthesize email = _email;
@synthesize idCard = _idCard;
@synthesize accountPhone = _accountPhone;
@synthesize idCardFrontUrl = _idCardFrontUrl;
@synthesize number = _number;
@synthesize ali = _ali;
@synthesize chinaZodiacs = _chinaZodiacs;
@synthesize idCardAuth = _idCardAuth;
@synthesize introduction = _introduction;
@synthesize accountIcon = _accountIcon;
@synthesize nativePlace = _nativePlace;
@synthesize politicsStatus = _politicsStatus;
@synthesize qq = _qq;
@synthesize realNameAuth = _realNameAuth;
@synthesize hometown = _hometown;
@synthesize birthdayDefault = _birthdayDefault;

#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.birthday = [dict stringValueForKey:kModelUserBirthday];
            self.status = [dict doubleValueForKey:kModelUserStatus];
            self.ethnicGroup = [dict doubleValueForKey:kModelUserEthnicGroup];
            self.sina = [dict stringValueForKey:kModelUserSina];
            self.marriageStatus = [dict doubleValueForKey:kModelUserMarriageStatus];
            self.weChat = [dict stringValueForKey:kModelUserWeChat];
            self.accountName = [dict stringValueForKey:kModelUserAccountName];
            self.contactPhone = [GlobalMethod exchangeDic:dict toAryWithModelName:@"ModelCustomerPhoneInfo"];
            self.bloodGroup = [dict doubleValueForKey:kModelUserBloodGroup];
            self.chinaBirthday = [dict stringValueForKey:kModelUserChinaBirthday];
            self.realName = [dict stringValueForKey:kModelUserRealName];
            self.constellation = [dict doubleValueForKey:kModelUserConstellation];
            self.emergencyTel = [dict stringValueForKey:kModelUserEmergencyTel];
            self.idCardBackUrl = [dict stringValueForKey:kModelUserIdCardBackUrl];
            self.emergencyName = [dict stringValueForKey:kModelUserEmergencyName];
            self.gender = [dict doubleValueForKey:kModelUserGender];
            self.email = [dict stringValueForKey:kModelUserEmail];
            self.idCard = [dict stringValueForKey:kModelUserIdCard];
            self.accountPhone = [dict stringValueForKey:kModelUserAccountPhone];
            self.idCardFrontUrl = [dict stringValueForKey:kModelUserIdCardFrontUrl];
            self.number = [dict doubleValueForKey:kModelUserNumber];
            self.ali = [dict stringValueForKey:kModelUserAli];
            self.chinaZodiacs = [dict doubleValueForKey:kModelUserChinaZodiacs];
            self.idCardAuth = [dict doubleValueForKey:kModelUserIdCardAuth];
            self.introduction = [dict stringValueForKey:kModelUserIntroduction];
            self.accountIcon = [dict stringValueForKey:kModelUserAccountIcon];
            self.politicsStatus = [dict doubleValueForKey:kModelUserPoliticsStatus];
            self.qq = [dict stringValueForKey:kModelUserQq];
            self.realNameAuth = [dict doubleValueForKey:kModelUserRealNameAuth];
        self.birthdayDefault = [dict doubleValueForKey:kModelUserBirthdayDefault];
        //lhp
        self.nick = [dict stringValueForKey:kModelUserNick];
        self.uid = [dict doubleValueForKey:kModelUserUid];
        self.code = [dict doubleValueForKey:kModelUserCode];
        self.fname = [dict stringValueForKey:kModelUserFname];
        self.avtar = [dict stringValueForKey:kModelUserAvtar];
        self.msg = [dict stringValueForKey:kModelUserMsg];
        self.fid = [dict doubleValueForKey:kModelUserFid];
        self.imtoken = [dict stringValueForKey:kModelUserImtoken];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.birthday forKey:kModelUserBirthday];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelUserStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ethnicGroup] forKey:kModelUserEthnicGroup];
    [mutableDict setValue:self.sina forKey:kModelUserSina];
    [mutableDict setValue:[NSNumber numberWithDouble:self.marriageStatus] forKey:kModelUserMarriageStatus];
    [mutableDict setValue:self.weChat forKey:kModelUserWeChat];
    [mutableDict setValue:self.accountName forKey:kModelUserAccountName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.contactPhone] forKey:kModelUserContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bloodGroup] forKey:kModelUserBloodGroup];
    [mutableDict setValue:self.chinaBirthday forKey:kModelUserChinaBirthday];
    [mutableDict setValue:self.realName forKey:kModelUserRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.constellation] forKey:kModelUserConstellation];
    [mutableDict setValue:self.emergencyTel forKey:kModelUserEmergencyTel];
    [mutableDict setValue:self.idCardBackUrl forKey:kModelUserIdCardBackUrl];
    [mutableDict setValue:self.emergencyName forKey:kModelUserEmergencyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gender] forKey:kModelUserGender];
    [mutableDict setValue:self.email forKey:kModelUserEmail];
    [mutableDict setValue:self.idCard forKey:kModelUserIdCard];
    [mutableDict setValue:self.accountPhone forKey:kModelUserAccountPhone];
    [mutableDict setValue:self.idCardFrontUrl forKey:kModelUserIdCardFrontUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.number] forKey:kModelUserNumber];
    [mutableDict setValue:self.ali forKey:kModelUserAli];
    [mutableDict setValue:[NSNumber numberWithDouble:self.chinaZodiacs] forKey:kModelUserChinaZodiacs];
    [mutableDict setValue:[NSNumber numberWithDouble:self.idCardAuth] forKey:kModelUserIdCardAuth];
    [mutableDict setValue:self.introduction forKey:kModelUserIntroduction];
    [mutableDict setValue:self.accountIcon forKey:kModelUserAccountIcon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.politicsStatus] forKey:kModelUserPoliticsStatus];
    [mutableDict setValue:self.qq forKey:kModelUserQq];
    [mutableDict setValue:[NSNumber numberWithDouble:self.realNameAuth] forKey:kModelUserRealNameAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.birthdayDefault] forKey:kModelUserBirthdayDefault];
    //lhp
    [mutableDict setValue:self.nick forKey:kModelUserNick];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uid] forKey:kModelUserUid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kModelUserCode];
    [mutableDict setValue:self.fname forKey:kModelUserFname];
    [mutableDict setValue:self.avtar forKey:kModelUserAvtar];
    [mutableDict setValue:self.msg forKey:kModelUserMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fid] forKey:kModelUserFid];
    [mutableDict setValue:self.imtoken forKey:kModelUserImtoken];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
