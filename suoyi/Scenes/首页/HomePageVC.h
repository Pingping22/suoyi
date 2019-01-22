//
//  HomePageVC.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "BaseTableVC.h"

@interface HomePageVC : BaseTableVC

@end




@interface HomePageHeaderView : UIView
//属性
@property (strong, nonatomic) UIImageView *backView;
@property (strong, nonatomic) UILabel *labelTitle;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end



@interface HomePageSecHeaderView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIControl *control;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end


#import "MineListMindImgView.h"
@interface HomePageThirHeaderView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIButton *addBtn;
@property (nonatomic, strong) MineListMindImgView * upImageInfoView;
#pragma mark 刷新view
- (void)resetWithAry:(NSArray *)aryImage;
@end
