//
//  OpenMoreLevelBtnView.h
//  ngj
//
//  Created by Mac on 2017/8/10.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenMoreLevelBtnView : UIView

@property (nonatomic, strong) UIView * backView;

#pragma mark - 创建
+ (instancetype)initWithFrame:(CGRect)frame;

#pragma mark - 刷新位置
- (void)resetViewWithFrame:(CGRect)frame withArray:(NSArray *)nameArray;

//按钮点击block
@property (nonatomic,copy)void(^myBtnClickBlock)( NSInteger btnTag);

@end
