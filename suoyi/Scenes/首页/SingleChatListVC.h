//
//  SingleChatListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/7/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SingleChatListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END




@interface SingleChatListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelContent;
@property (strong, nonatomic) UIButton *telBtn;
@property (nonatomic, strong) UILabel * labelCount;
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;
@end



@interface SingleChatFriendCell : SingleChatListCell
@property (nonatomic, strong) ModelNewFriendList * model;
#pragma mark 刷新cell
- (void)resetCellWithArr:(NSMutableArray *)arr;
@end
