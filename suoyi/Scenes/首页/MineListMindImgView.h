//
//  MineListMindImgView.h
//  乐销
//
//  Created by 隋林栋 on 2017/10/23.
//Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineListMindImgView : UIView
@property (nonatomic, strong) NSArray *aryModels;
@property (nonatomic, strong) NSMutableDictionary *dicImages;

@property (nonatomic, assign) CGFloat imgSpace;//default 6
@property (nonatomic, assign) CGFloat leftInteral;//default 15
@property (nonatomic, assign) CGFloat topInteral;//default 0
@property (nonatomic, assign) CGFloat bottomInterval;//default 0
@property (nonatomic, assign) NSInteger numLimit;//limit image num default6 

#pragma mark 刷新view
- (void)resetViewWithArray:(NSArray *)array;
- (void)resetViewWithArray:(NSArray *)array totalNum:(double)totalNum;
@end
