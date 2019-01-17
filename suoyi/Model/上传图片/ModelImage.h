//
//  ModelImage.h
//
//  Created by   on 2018/3/28
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//base image
#import "BaseImage.h"


@interface ModelImage : NSObject

@property (nonatomic, assign) double width;
@property (nonatomic, assign) double number;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) double sort;
@property (nonatomic, assign) double size;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbUrl;
@property (nonatomic, strong) BaseImage *image;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
