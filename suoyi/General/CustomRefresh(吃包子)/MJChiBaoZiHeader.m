//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiHeader.h"

@implementation MJChiBaoZiHeader

#pragma mark - 重写方法
//- (void)prepare
//{
//    [super prepare];
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    self.automaticallyChangeAlpha = YES;
//    
//    // 隐藏时间
//    self.lastUpdatedTimeLabel.hidden = YES;
//    
//    // 隐藏状态
//    self.stateLabel.hidden = NO;
//}

- (void)prepare
{
    [super prepare];
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        NSString * strTmp = [NSString stringWithFormat:@"dropdown_anim__000%zd", i];
        UIImage *image = [UIImage imageNamed:strTmp];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
