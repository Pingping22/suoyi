//
//  ModelProductItem.m
//
//  Created by runda  on 2018/9/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "ModelProductItem.h"


NSString *const kModelProductItemPayment = @"payment";
NSString *const kModelProductItemPrice = @"price";
NSString *const kModelProductItemImageUrl = @"imageUrl";
NSString *const kModelProductItemSpecifications = @"specifications";
NSString *const kModelProductItemIntro = @"intro";
NSString *const kModelProductItemName = @"name";
NSString *const kModelProductItemStore = @"store";


@interface ModelProductItem ()
@end

@implementation ModelProductItem

@synthesize payment = _payment;
@synthesize price = _price;
@synthesize imageUrl = _imageUrl;
@synthesize specifications = _specifications;
@synthesize intro = _intro;
@synthesize name = _name;
@synthesize store = _store;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.payment = [dict doubleValueForKey:kModelProductItemPayment];
            self.price = [dict doubleValueForKey:kModelProductItemPrice];
            self.imageUrl = [dict stringValueForKey:kModelProductItemImageUrl];
            self.specifications = [dict stringValueForKey:kModelProductItemSpecifications];
            self.intro = [dict stringValueForKey:kModelProductItemIntro];
            self.name = [dict stringValueForKey:kModelProductItemName];
            self.store = [dict stringValueForKey:kModelProductItemStore];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payment] forKey:kModelProductItemPayment];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelProductItemPrice];
    [mutableDict setValue:self.imageUrl forKey:kModelProductItemImageUrl];
    [mutableDict setValue:self.specifications forKey:kModelProductItemSpecifications];
    [mutableDict setValue:self.intro forKey:kModelProductItemIntro];
    [mutableDict setValue:self.name forKey:kModelProductItemName];
    [mutableDict setValue:self.store forKey:kModelProductItemStore];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
