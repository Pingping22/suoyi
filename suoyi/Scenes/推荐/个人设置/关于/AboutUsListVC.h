//
//  AboutUsListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/2/13.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AboutUsListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END



@interface AboutUsListHeaderView : UIView
//属性
@property (strong, nonatomic) UIImageView *iconImg;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end





@interface AboutUsListCell : UITableViewCell
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelDetail;
@property (strong, nonatomic) UIImageView *rightImg;
@property (strong, nonatomic) UIView *lineView;
@property (nonatomic, strong) ModelBaseData *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;
@end






@interface AboutUsListFooterView : UIView
//属性
@property (strong, nonatomic) UIButton *webLabel;
@property (strong, nonatomic) UIButton *agreeLabel;
@property (strong, nonatomic) UIButton *personLabel;
@property (strong, nonatomic) UIButton *privacyLabel;
@property (strong, nonatomic) UILabel *labelCom;
@property (strong, nonatomic) UIView *lineView1;
@property (strong, nonatomic) UIView *lineView2;
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end





@interface ServiceTelAlertView : UIControl
//属性
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIButton *telBtn;
@property (strong, nonatomic) UIButton *cancelBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end
