//
//  ModelUserGroupOwner.h
//
//  Created by 伟 王 on 2019/7/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelUserGroupOwner : NSObject

@property (nonatomic, assign) double gcUserId;
@property (nonatomic, strong) NSString *gNotice;
@property (nonatomic, strong) NSString *gAvatar;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, assign) double groupId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
