//
//  ModelFamilyGroupFamilyDevice.m
//
//  Created by 伟 王 on 2019/7/4
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelFamilyGroupFamilyDevice.h"


NSString *const kFamilyDeviceUserId = @"user_id";
NSString *const kFamilyDeviceDeviceId = @"device_id";
NSString *const kFamilyDeviceType = @"type";
NSString *const kFamilyDeviceUserName = @"user_name";


@interface ModelFamilyGroupFamilyDevice ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelFamilyGroupFamilyDevice

@synthesize userId = _userId;
@synthesize deviceId = _deviceId;
@synthesize type = _type;
@synthesize userName = _userName;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userId = [[self objectOrNilForKey:kFamilyDeviceUserId fromDictionary:dict] doubleValue];
            self.deviceId = [[self objectOrNilForKey:kFamilyDeviceDeviceId fromDictionary:dict] doubleValue];
            self.type = [[self objectOrNilForKey:kFamilyDeviceType fromDictionary:dict] doubleValue];
            self.userName = [self objectOrNilForKey:kFamilyDeviceUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kFamilyDeviceUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deviceId] forKey:kFamilyDeviceDeviceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kFamilyDeviceType];
    [mutableDict setValue:self.userName forKey:kFamilyDeviceUserName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}




@end
