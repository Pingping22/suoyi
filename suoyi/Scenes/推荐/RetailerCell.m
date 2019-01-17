//
//  RetailerCell.m
//  ngj
//
//  Created by lirenbo on 2017/12/19.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import "RetailerCell.h"
#import "MacroLocalKey.h"
#import "Macro.h"
#import "UILabel+Category.h"
#import <UIKit/UIKit.h>
@implementation RetailerCell

#pragma mark - 创建cell
//代码 创建cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.bigImage];
    [self.bigImage addSubview:self.markLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.busineLabel];
    [self.contentView addSubview:self.darkStar];
    [self.contentView addSubview:self.lightStar];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.saleNum];
    [self.contentView addSubview:self.labelBackView];
    [self.contentView addSubview:self.discountBackView];
    [self.contentView addSubview:self.lineView];
}


@end
