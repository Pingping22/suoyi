//
//  GroupChatListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/7/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupChatListVC : BaseTableVC
- (void)requestData;
@end

NS_ASSUME_NONNULL_END



@interface GroupChatListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelContent;
@property (strong, nonatomic) UIButton *telBtn;
@property (nonatomic, strong) ModelUserGroupOwner * model;
@property (nonatomic, strong) ModelUserGroup * modelGroup;
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;
@end
