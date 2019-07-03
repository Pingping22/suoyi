//
//  ModelUserGroup.m
//
//  Created by 伟 王 on 2019/7/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelUserGroup.h"
#import "ModelUserGroupOwner.h"
#import "ModelUserGroupAdmin.h"
#import "ModelUserGroupMember.h"


NSString *const kModelUserGroupOwner = @"owner";
NSString *const kModelUserGroupAdmin = @"admin";
NSString *const kModelUserGroupMember = @"member";


@interface ModelUserGroup ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ModelUserGroup

@synthesize owner = _owner;
@synthesize admin = _admin;
@synthesize member = _member;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedOwner = [dict objectForKey:kModelUserGroupOwner];
    NSMutableArray *parsedOwner = [NSMutableArray array];
    
    if ([receivedOwner isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOwner) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOwner addObject:[ModelUserGroupOwner modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOwner isKindOfClass:[NSDictionary class]]) {
       [parsedOwner addObject:[ModelUserGroupOwner modelObjectWithDictionary:(NSDictionary *)receivedOwner]];
    }

    self.owner = [NSArray arrayWithArray:parsedOwner];
    NSObject *receivedAdmin = [dict objectForKey:kModelUserGroupAdmin];
    NSMutableArray *parsedAdmin = [NSMutableArray array];
    
    if ([receivedAdmin isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAdmin) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAdmin addObject:[ModelUserGroupAdmin modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAdmin isKindOfClass:[NSDictionary class]]) {
       [parsedAdmin addObject:[ModelUserGroupAdmin modelObjectWithDictionary:(NSDictionary *)receivedAdmin]];
    }

    self.admin = [NSArray arrayWithArray:parsedAdmin];
    NSObject *receivedMember = [dict objectForKey:kModelUserGroupMember];
    NSMutableArray *parsedMember = [NSMutableArray array];
    
    if ([receivedMember isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMember) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMember addObject:[ModelUserGroupMember modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMember isKindOfClass:[NSDictionary class]]) {
       [parsedMember addObject:[ModelUserGroupMember modelObjectWithDictionary:(NSDictionary *)receivedMember]];
    }

    self.member = [NSArray arrayWithArray:parsedMember];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForOwner = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.owner) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOwner addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOwner addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOwner] forKey:kModelUserGroupOwner];
    NSMutableArray *tempArrayForAdmin = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.admin) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAdmin addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAdmin addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAdmin] forKey:kModelUserGroupAdmin];
    NSMutableArray *tempArrayForMember = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.member) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMember addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMember addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMember] forKey:kModelUserGroupMember];

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
