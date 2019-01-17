//
//  ModelBtn.m
//  乐销
//
//  Created by 隋林栋 on 2016/12/20.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "ModelBtn.h"

NSString *const kModelBtnIDProperty = @"ID";
NSString *const kModelBtnSubTitle = @"subTitle";
NSString *const kModelBtnWidth = @"width";
NSString *const kModelBtnIsHide = @"isHide";
NSString *const kModelBtnTitle = @"ClassName";
NSString *const kModelBtnVcName = @"vcName";
NSString *const kModelBtnHighImageName = @"highImageName";
NSString *const kModelBtnTag = @"tag";
NSString *const kModelBtnNum = @"num";
NSString *const kModelBtnIsSelected = @"isSelected";
NSString *const kModelBtnImageName = @"imageName";
NSString *const kModelBtnIsNotShowAnimated = @"isNotShowAnimated";
NSString *const kModelBtnNumP = @"numP";

@implementation ModelBtn


+ (instancetype)modelWithTitle:(NSString *)title{
    return [ModelBtn modelWithTitle:title  tag:0];
}
+ (instancetype)modelWithTitle:(NSString *)title
                           tag:(int)tag{
    return [ModelBtn modelWithTitle:title imageName:nil tag:tag];
}
+ (instancetype)modelWithTitle:(NSString *)title
                           imageName:(NSString *)imageName
                                 tag:(int)tag{
    return [ModelBtn modelWithTitle:title imageName:imageName highImageName:nil tag:tag];
}
+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag{
    return [ModelBtn modelWithTitle:title imageName:imageName highImageName:highImageName tag:tag color:nil];
}

+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag
                         color:(UIColor *)color{
    return [ModelBtn modelWithTitle:title imageName:imageName highImageName:highImageName tag:tag color:color selectColor:nil];
}

+ (instancetype)modelWithTitle:(NSString *)title
                     imageName:(NSString *)imageName
                 highImageName:(NSString *)highImageName
                           tag:(int)tag
                         color:(UIColor *)color
                   selectColor:(UIColor *)colorSelect
{
    ModelBtn * model = [ModelBtn new];
    model.title = title;
    model.imageName = imageName;
    model.highImageName = highImageName;
    model.tag = tag;
    model.color = color;
    model.colorSelect = colorSelect;
    return model;
}
//将字符串数组转换成modelbtn 数组
+ (NSArray *)exchangeStrAry:(NSArray *)aryStr{
    NSMutableArray * aryMu = [NSMutableArray array];
    for (NSString * str in aryStr) {
        ModelBtn * modelBtn = [ModelBtn modelWithTitle:str];
        [aryMu addObject:modelBtn];
    }
    return aryMu;
}

#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.number = [[self objectOrNilForKey:kModelBtnIDProperty fromDictionary:dict] doubleValue];
        self.subTitle = [self objectOrNilForKey:kModelBtnSubTitle fromDictionary:dict];
        self.width = [[self objectOrNilForKey:kModelBtnWidth fromDictionary:dict] doubleValue];
        self.isHide = [[self objectOrNilForKey:kModelBtnIsHide fromDictionary:dict] boolValue];
        self.title = [self objectOrNilForKey:kModelBtnTitle fromDictionary:dict];
        self.vcName = [self objectOrNilForKey:kModelBtnVcName fromDictionary:dict];
        self.highImageName = [self objectOrNilForKey:kModelBtnHighImageName fromDictionary:dict];
        self.tag = [[self objectOrNilForKey:kModelBtnTag fromDictionary:dict] doubleValue];
        self.num = [[self objectOrNilForKey:kModelBtnNum fromDictionary:dict] doubleValue];
        self.isSelected = [[self objectOrNilForKey:kModelBtnIsSelected fromDictionary:dict] boolValue];
        self.imageName = [self objectOrNilForKey:kModelBtnImageName fromDictionary:dict];
        self.isNotShowAnimated = [[self objectOrNilForKey:kModelBtnIsNotShowAnimated fromDictionary:dict] boolValue];
        self.numP = [[self objectOrNilForKey:kModelBtnNumP fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.number] forKey:kModelBtnIDProperty];
    [mutableDict setValue:self.subTitle forKey:kModelBtnSubTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kModelBtnWidth];
    [mutableDict setValue:[NSNumber numberWithBool:self.isHide] forKey:kModelBtnIsHide];
    [mutableDict setValue:self.title forKey:kModelBtnTitle];
    [mutableDict setValue:self.vcName forKey:kModelBtnVcName];
    [mutableDict setValue:self.highImageName forKey:kModelBtnHighImageName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tag] forKey:kModelBtnTag];
    [mutableDict setValue:[NSNumber numberWithDouble:self.num] forKey:kModelBtnNum];
    [mutableDict setValue:[NSNumber numberWithBool:self.isSelected] forKey:kModelBtnIsSelected];
    [mutableDict setValue:self.imageName forKey:kModelBtnImageName];
    [mutableDict setValue:[NSNumber numberWithBool:self.isNotShowAnimated] forKey:kModelBtnIsNotShowAnimated];
    [mutableDict setValue:[NSNumber numberWithDouble:self.numP] forKey:kModelBtnNumP];
    
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
