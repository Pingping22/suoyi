//
//  ShareAlertView.h
//  suoyi
//
//  Created by 王伟 on 2019/1/23.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareAlertView : UIControl
//属性
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *wechatImg;
@property (strong, nonatomic) UILabel *labelWechat;
@property (strong, nonatomic) UIControl *wechatControl;
@property (strong, nonatomic) UIImageView *personImg;
@property (strong, nonatomic) UILabel *labelPerson;
@property (strong, nonatomic) UIControl *personControl;
@property (strong, nonatomic) UIImageView *weiboImg;
@property (strong, nonatomic) UILabel *labelWeibo;
@property (strong, nonatomic) UIControl *weiboControl;
@property (strong, nonatomic) UIImageView *downImg;
@property (strong, nonatomic) UILabel *labelDown;
@property (strong, nonatomic) UIControl *downControl;
@property (strong, nonatomic) UIImageView *deleteImg;
@property (strong, nonatomic) UILabel *labelDelete;
@property (strong, nonatomic) UIControl *deleteControl;
@property (strong, nonatomic) UIButton *conBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
