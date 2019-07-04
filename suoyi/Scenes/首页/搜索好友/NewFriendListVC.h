//
//  NewFriendListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/7/4.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewFriendListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END





@interface NewFriendListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) UILabel *nameLable;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIButton *addBtn;
@property (nonatomic, strong) ModelNewFriendList * model;
@property (nonatomic, strong) void (^blockClick)(ModelNewFriendList *model);
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNewFriendList *)model;

@end
