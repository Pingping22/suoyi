//
//  ToolsTabVC.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "BaseTableVC.h"
#import "LHPBtn.h"
@interface ToolsTabVC : BaseTableVC

@end


@interface ToolsTabHeaderView : UIView
//属性
@property (strong, nonatomic) UIImageView *conImg;
@property (strong, nonatomic) UILabel *labelCon;
@property (strong, nonatomic) UIControl *control;
@property (strong, nonatomic) UIImageView *setImg;
@property (strong, nonatomic) UILabel *labelSet;
@property (strong, nonatomic) UIControl *setControl;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end
