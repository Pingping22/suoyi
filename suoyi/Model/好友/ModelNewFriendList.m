//
//  ModelNewFriendList.m
//
//  Created by 伟 王 on 2019/7/4
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelNewFriendList.h"


NSString *const kModelNewFriendListNick = @"nick";
NSString *const kModelNewFriendListUid = @"uid";
NSString *const kModelNewFriendListType = @"type";
NSString *const kModelNewFriendListAvatar = @"avatar";


@interface ModelNewFriendList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelNewFriendList

@synthesize nick = _nick;
@synthesize uid = _uid;
@synthesize type = _type;
@synthesize avatar = _avatar;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.nick = [self objectOrNilForKey:kModelNewFriendListNick fromDictionary:dict];
            self.uid = [[self objectOrNilForKey:kModelNewFriendListUid fromDictionary:dict] doubleValue];
            self.type = [[self objectOrNilForKey:kModelNewFriendListType fromDictionary:dict] doubleValue];
            self.avatar = [self objectOrNilForKey:kModelNewFriendListAvatar fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nick forKey:kModelNewFriendListNick];
    [mutableDict setValue:[NSNumber numberWithDouble:self.uid] forKey:kModelNewFriendListUid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelNewFriendListType];
    [mutableDict setValue:self.avatar forKey:kModelNewFriendListAvatar];

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
