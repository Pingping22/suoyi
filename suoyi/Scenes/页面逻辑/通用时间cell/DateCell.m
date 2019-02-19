//
//  DateCell.m
//  乐销
//
//  Created by 刘惠萍 on 2017/8/3.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "DateCell.h"

@interface DateCell ()

@end

@implementation DateCell


#pragma mark lazy init
- (UILabel *)labelDate{
    if (!_labelDate) {
        _labelDate = [UILabel new];
        _labelDate.textColor = COLOR_LABEL;
        _labelDate.fontNum = F(12);
        _labelDate.backgroundColor = [UIColor whiteColor];
    }
    return _labelDate;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelDate fitTitle:model.string variable:0];
    self.labelDate.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
    //设置总高度
    self.height = self.labelDate.bottom + self.heightLabelToBottom;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];//背景颜色
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//样式
        //default
        [self.contentView addSubview:self.labelDate];
        self.heightLabelToBottom = 0;
    }
    return self;
}

@end
