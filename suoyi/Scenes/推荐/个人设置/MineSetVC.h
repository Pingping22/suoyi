//
//  MineSetVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/25.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineSetVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END





@interface MineSetHeaderView : UIView
//属性
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelContent;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UIControl *control;
@property (strong, nonatomic) UIButton *addBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end








