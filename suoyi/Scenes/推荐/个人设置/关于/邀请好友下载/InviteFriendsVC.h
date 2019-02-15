//
//  InviteFriendsVC.h
//  suoyi
//
//  Created by 王伟 on 2019/2/15.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface InviteFriendsVC : BaseVC

@end

NS_ASSUME_NONNULL_END





@interface InviteFriendsView : UIView
//属性
@property (strong, nonatomic) UIImageView *wechatImg;
@property (strong, nonatomic) UILabel *wechatLabel;
@property (strong, nonatomic) UIControl *controlWechat;
@property (strong, nonatomic) UIImageView *personImg;
@property (strong, nonatomic) UILabel *personLabel;
@property (strong, nonatomic) UIControl *personControl;
@property (strong, nonatomic) UIImageView *smsImg;
@property (strong, nonatomic) UILabel *labelSms;
@property (strong, nonatomic) UIControl *smsControl;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *codeImg;
@property (strong, nonatomic) UILabel *labelTitle;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end
