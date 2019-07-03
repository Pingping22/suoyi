//
//  ModelUserGroupOwner.m
//
//  Created by 伟 王 on 2019/7/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelUserGroupOwner.h"


NSString *const kOwnerGcUserId = @"gc_user_id";
NSString *const kOwnerGNotice = @"g_notice";
NSString *const kOwnerGAvatar = @"g_avatar";
NSString *const kOwnerGroupName = @"group_name";
NSString *const kOwnerGroupId = @"group_id";


@interface ModelUserGroupOwner ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelUserGroupOwner

@synthesize gcUserId = _gcUserId;
@synthesize gNotice = _gNotice;
@synthesize gAvatar = _gAvatar;
@synthesize groupName = _groupName;
@synthesize groupId = _groupId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.gcUserId = [[self objectOrNilForKey:kOwnerGcUserId fromDictionary:dict] doubleValue];
            self.gNotice = [self objectOrNilForKey:kOwnerGNotice fromDictionary:dict];
            self.gAvatar = [self objectOrNilForKey:kOwnerGAvatar fromDictionary:dict];
            self.groupName = [self objectOrNilForKey:kOwnerGroupName fromDictionary:dict];
            self.groupId = [[self objectOrNilForKey:kOwnerGroupId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gcUserId] forKey:kOwnerGcUserId];
    [mutableDict setValue:self.gNotice forKey:kOwnerGNotice];
    [mutableDict setValue:self.gAvatar forKey:kOwnerGAvatar];
    [mutableDict setValue:self.groupName forKey:kOwnerGroupName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.groupId] forKey:kOwnerGroupId];

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
