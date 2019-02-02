//
//  HomeAddressBookDetailVC.h
//  suoyi
//
//  Created by 王伟 on 2019/2/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeAddressBookDetailVC : BaseVC

@end

NS_ASSUME_NONNULL_END






@interface HomeAddressBookDetailHeaderView : UIView
//属性
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIImageView *backView;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelNum;
@property (strong, nonatomic) UILabel *labelMana;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end





@interface HomeAddressBookDetailFooterView : UIView
//属性
@property (strong, nonatomic) UIImageView *phoneImg;
@property (strong, nonatomic) UILabel *labelPhone;
@property (strong, nonatomic) UIControl *phoneControl;
@property (strong, nonatomic) UIImageView *liuImg;
@property (strong, nonatomic) UILabel *labelLiu;
@property (strong, nonatomic) UIControl *liuControl;
@property (strong, nonatomic) UIImageView *spImg;
@property (strong, nonatomic) UILabel *labelSp;
@property (strong, nonatomic) UIControl *controlSp;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
