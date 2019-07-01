//
//  CustomTabBar.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "CustomTabBar.h"

#define NUM_TAB 4.0
@implementation CustomTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (isIphoneXSERIES) {
        return;
    }
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    CGFloat buttonW = barWidth / NUM_TAB;// 每个的宽
    CGFloat buttonH = barHeight - 2.0;// 每个的高
    CGFloat buttonY = 1.0;// button的X坐标，因为设置距离上下各1厘米
    
    NSUInteger index = 0;// 定义下标
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 获取button的x
            CGFloat buttonX = index * buttonW;
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
        }
    }
    // 添加小红点（消息）
//    for (UIView * view in self.subviews) {
//        if (view.tag >= 888) {
//            [self addSubview:view];
//            return;
//        }
//    }
}

@end
