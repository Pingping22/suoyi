//
//  ModelProductItem.h
//
//  Created by runda  on 2018/9/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelProductItem : NSObject

@property (nonatomic, assign) double payment;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *specifications;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *store;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
