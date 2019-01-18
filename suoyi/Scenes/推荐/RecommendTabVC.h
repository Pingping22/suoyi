//
//  RecommendTabVC.h
//  lanberProject
//
//  Created by runda on 2018/9/27.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "BaseTableVC.h"

@interface RecommendTabVC : BaseTableVC

@end






#pragma mark - 导航栏View

@interface ProductMarketNavView : UIView
//属性
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelRed;
@property (nonatomic, strong) UIView      * lineView;

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)searchTitle;

@end


@class AutoScView;
@interface ProductMarketHeaderView : UIView
@property (nonatomic, strong) UIButton    * searchBtn;
@property (nonatomic, strong) UIImageView * searchImg;
@property (nonatomic, strong) UILabel     * searchTitle;
@property (strong, nonatomic) AutoScView *backView;

//刷新View
- (void)resetViewWithTitle:(NSString *)searchTitle;

@end


@interface ProductMarketSecHeaderView : UIControl
@property (nonatomic, strong) NSArray *aryModels;
#pragma mark 刷新view
- (void)resetViewWithArray:(NSArray *)array imgArr:(NSArray *)imgArr;


@end




