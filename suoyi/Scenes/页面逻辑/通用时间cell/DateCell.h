//
//  DateCell.h
//  乐销
//
//  Created by 刘惠萍 on 2017/8/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

//show date string in tableView list
@interface DateCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelDate;//date
@property (nonatomic, assign) CGFloat heightLabelToBottom;//label to bottom view height (default to 0)
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;

@end
