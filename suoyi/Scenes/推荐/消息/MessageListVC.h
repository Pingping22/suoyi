//
//  MessageListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/2/19.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END







typedef NS_ENUM(NSUInteger, ENUM_MESSAGE_TYPE) {
    ENUM_MESSAGE_JOIN,
    ENUM_MESSAGE_IMAGE,
    ENUM_MESSAGE_NOTICE,
};
@interface MessageListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *noticeImg;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *detailImg;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelDetail;
@property (nonatomic, strong) ModelBtn * model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model;
@end
