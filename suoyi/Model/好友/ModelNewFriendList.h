//
//  ModelNewFriendList.h
//
//  Created by 伟 王 on 2019/7/4
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelNewFriendList : NSObject

@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) double uid;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *avatar;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
