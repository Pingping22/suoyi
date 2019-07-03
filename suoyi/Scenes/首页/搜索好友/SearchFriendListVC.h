//
//  SearchFriendListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/7/3.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchFriendListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END





@interface SearchFriendListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (nonatomic, strong) ModelFriend * model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFriend *)model;
@end
