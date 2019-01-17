//
//  UIView+Coordeinate.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Coordeinate)

//扩展
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

@end
