//
//  ModelFriend.m
//
//  Created by 伟 王 on 2019/7/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelFriend.h"


NSString *const kModelFriendIsFriend = @"isFriend";
NSString *const kModelFriendNick = @"nick";
NSString *const kModelFriendUserId = @"userId";
NSString *const kModelFriendMsg = @"msg";
NSString *const kModelFriendAvtar = @"avatar";


@interface ModelFriend ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelFriend

@synthesize isFriend = _isFriend;
@synthesize nick = _nick;
@synthesize userId = _userId;
@synthesize msg = _msg;
@synthesize avtar = _avtar;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isFriend = [[self objectOrNilForKey:kModelFriendIsFriend fromDictionary:dict] doubleValue];
            self.nick = [self objectOrNilForKey:kModelFriendNick fromDictionary:dict];
            self.userId = [[self objectOrNilForKey:kModelFriendUserId fromDictionary:dict] doubleValue];
            self.msg = [self objectOrNilForKey:kModelFriendMsg fromDictionary:dict];
            self.avtar = [self objectOrNilForKey:kModelFriendAvtar fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isFriend] forKey:kModelFriendIsFriend];
    [mutableDict setValue:self.nick forKey:kModelFriendNick];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelFriendUserId];
    [mutableDict setValue:self.msg forKey:kModelFriendMsg];
    [mutableDict setValue:self.avtar forKey:kModelFriendAvtar];

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
