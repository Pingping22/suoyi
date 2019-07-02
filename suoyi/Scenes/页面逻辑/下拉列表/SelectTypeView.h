//
//  SelectTypeView.h
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/11/20.
//Copyright © 2017年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectTypeCell;
@interface SelectTypeView : UIControl<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIImageView *imgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *imageViewBg;
@property (nonatomic, strong) NSArray *aryDatas;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
- (void)showWithFrame:(CGRect)rect ary:(NSArray *)array;//刷新页面
@end


@interface SelectTypeCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIView *lineView;

@property (nonatomic, strong) ModelBtn *model;
@property (nonatomic, strong) void (^blockCellClick)(SelectTypeCell *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model ;
@end
