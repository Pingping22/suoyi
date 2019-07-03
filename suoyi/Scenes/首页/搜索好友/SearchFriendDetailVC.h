//
//  SearchFriendDetailVC.h
//  suoyi
//
//  Created by 王伟 on 2019/7/3.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"
//底部green view
#import "BottomGreensView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchFriendDetailVC : BaseTableVC
@property (nonatomic, strong) ModelFriend * model;
@property (nonatomic, strong) BottomGreensView *bottomBtnView;//底部添加新按钮

@end

NS_ASSUME_NONNULL_END




@interface SearchFriendDetailHeaderView : UIView
//属性
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelDetail;
@property (strong, nonatomic) UIImageView *iconImg;
@property (nonatomic, strong) ModelFriend * model;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFriend *)model;
@end
