//
//  ModelUserGroup.h
//
//  Created by 伟 王 on 2019/7/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ModelFamilyGroupFamilyDevice;



@interface ModelUserGroup : NSObject

@property (nonatomic, strong) NSArray *owner;
@property (nonatomic, strong) NSArray *admin;
@property (nonatomic, strong) NSArray *member;
//家庭组
@property (nonatomic, assign) double fid;
@property (nonatomic, strong) NSString *fname;
@property (nonatomic, strong) ModelFamilyGroupFamilyDevice *familyDevice;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
