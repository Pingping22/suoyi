//
//  ContentResourcesListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/2/20.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentResourcesListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END




@interface ContentResourcesCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelContent;
@property (strong, nonatomic) UIButton *addBtn;
@property (nonatomic, strong) ModelBaseData * model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;
@end
