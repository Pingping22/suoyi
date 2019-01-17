//
//  OpenMoreChooseBtnView.h
//  ngj
//
//  Created by lirenbo on 2017/10/13.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenMoreChooseBtnView : UIView

@property (nonatomic, strong) UIImageView * markImage;
@property (nonatomic, strong) UIView      * backView;
@property (nonatomic, assign) BOOL          isBlack;

//初始化
+ (instancetype)initWithFrame:(CGRect)frame;

//按钮点击Block
@property (nonatomic,copy)void(^myBtnClickBlock)(NSInteger tag);

//刷新位置
- (void)resetViewWithFrame:(CGRect)frame withArray:(NSArray *)nameArray withOnTheUp:(BOOL)onTheUp isBlack:(BOOL)isBlack;
//刷新按钮
- (void)resetViewBtnWithAry:(NSArray *)dataArray;

@end
