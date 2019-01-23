//
//  ModelBaseData.h
//  乐销
//
//  Created by 隋林栋 on 2017/6/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <Foundation/Foundation.h>
//alert: disable have dictionary method
@interface ModelBaseData : NSObject

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *subString;
@property (nonatomic, strong) NSString *placeHolder;//placeHold String
@property (nonatomic, strong) NSString *alertString;//string alert
@property (nonatomic, assign) double number;//id
@property (nonatomic, assign) double num;//num
@property (nonatomic, strong) NSMutableArray *aryDatas;//dataAry
@property (nonatomic, assign) NSInteger enumType;//enum
@property (nonatomic, strong) NSString *imageName;//image name cell name
@property (nonatomic, strong) UIImage *image;//image
@property (nonatomic, strong) NSString *cellName;//cell name
@property (nonatomic, assign) BOOL hideState;//hide default NO
@property (nonatomic, assign) BOOL hideSubState;//hide default NO


@property (nonatomic, strong) void (^blockValueChange)(ModelBaseData *);//block value change
@property (nonatomic, strong) void (^blocClick)(ModelBaseData *);//block value change

@end