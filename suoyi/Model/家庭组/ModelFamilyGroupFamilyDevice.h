//
//  ModelFamilyGroupFamilyDevice.h
//
//  Created by 伟 王 on 2019/7/4
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFamilyGroupFamilyDevice : NSObject

@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double deviceId;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
