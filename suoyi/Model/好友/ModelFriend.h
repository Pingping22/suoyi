//
//  ModelFriend.h
//
//  Created by 伟 王 on 2019/7/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFriend : NSObject

@property (nonatomic, assign) double isFriend;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *avtar;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
