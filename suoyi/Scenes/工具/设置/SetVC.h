//
//  SetVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/21.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SetVC : BaseTableVC

@end




@interface SetView : UIView
//属性
@property (strong, nonatomic) UIImageView *backView;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIView *nameView;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelNa;
@property (strong, nonatomic) UIButton *btn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end
