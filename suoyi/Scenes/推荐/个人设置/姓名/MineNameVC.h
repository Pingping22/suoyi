//
//  MineNameVC.h
//  乐销
//
//  Created by liuhuiping on 2017/9/23.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface MineNameVC : BaseTableVC

@end





@interface MineNameView : UITableViewCell<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UITextField *textField;
@property (nonatomic, strong) ModelBaseData *modelData;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end





@interface MineNameCell : UITableViewCell
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelDetail;
@property (strong, nonatomic) UIImageView *rightImg;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIView *lineView;
@property (nonatomic, strong) ModelBaseData *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;
@end
