//
//  NSString+Category.h
//  乐销
//
//  Created by 刘惠萍 on 2017/3/25.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

@property (class, nonatomic, readonly) NSNumber * (^num)(NSString *);
@property (class, nonatomic, readonly) NSString * (^price)(double);
@property (class, nonatomic, readonly) NSString * (^dou)(double);
@property (class, nonatomic, readonly) NSString * (^str)(NSNumber *);
@property (nonatomic, readonly) NSString *smallImage;
@property (nonatomic, readonly) NSString *middleImage;
@property (nonatomic, readonly) NSString * (^smallImageCustomSize)(NSInteger);
//全部有效
+ (BOOL)isAllValid:(NSArray *)aryStrs;
//有一个有效
+ (BOOL)isHasOneValid:(NSArray *)aryStrs;
//截取字符串
+ (NSString *)subStr:(NSString *)string num:(NSInteger)num;
- (BOOL)hasString:(NSString *)str;//has string in self
//获取高度
- (CGFloat)fetchHeightWidthLimint:(CGFloat)width fontNum:(CGFloat)fontNum lineSpace:(CGFloat)lineSpace;

#pragma mark - Base64编码
- (NSString *)base64Encode;

#pragma mark - Base64解码
- (NSString *)base64Decode;

// safe separate string; if self.length is equal 0 return empty array
- (NSArray *)componentsValidSeparatedByString:(NSString *)strKey;

#pragma mark - 返回ReturnAttributeStr
- (NSMutableAttributedString *)setAttributeImageName:(NSString *)imageName imageRect:(CGRect)rect withIndex:(NSUInteger)index;

@end

