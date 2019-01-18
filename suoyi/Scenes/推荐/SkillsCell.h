//
//  SkillsCell.h
//  suoyi
//
//  Created by 王伟 on 2019/1/18.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendSkillsView.h"
@interface SkillsCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelContent;
@property (strong, nonatomic) UIButton *sureBtn;
@property (nonatomic, strong) ModelSkills * model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelSkills *)model;
@end
