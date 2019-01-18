//
//  GuideView.h
//  乐销
//
//  Created by 隋林栋 on 2017/5/30.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//自动滑动
#import "AutoScView.h"

@interface GuideView : UIView
//属性
@property (strong, nonatomic) AutoScView *backView;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *signBtn;

@property (nonatomic, strong) void (^blockLogin)(void);
@property (nonatomic, strong) void (^blockRegiste)(void);

#pragma mark 刷新view
- (void)resetView;
@end
