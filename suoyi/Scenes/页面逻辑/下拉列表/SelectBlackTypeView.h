//
//  SelectBlackTypeView.h
//  乐销
//
//  Created by liuhuiping on 2018/5/11.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBlackTypeView : UIControl<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIImageView *imgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *imageViewBg;
@property (nonatomic, strong) NSArray *aryDatas;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
- (void)showWithFrame:(CGRect)rect ary:(NSArray *)array;//刷新页面

@end





@interface SelectBlackTypeCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIView *lineView;

@property (nonatomic, strong) ModelBtn *model;
@property (nonatomic, strong) void (^blockCellClick)(SelectBlackTypeCell *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model ;
@end
