//
//  DynamicCell.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "DynamicCell.h"

@interface DynamicCell ()

@end

@implementation DynamicCell

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.contentView.backgroundColor = [UIColor orangeColor];
    //设置总高度
    self.height = W(100);
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];//背景颜色
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//样式
    }
    return self;
}

@end
