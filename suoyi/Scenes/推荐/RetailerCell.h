//
//  RetailerCell.h
//  ngj
//
//  Created by lirenbo on 2017/12/19.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelBtn.h"
@interface RetailerCell : UITableViewCell

@property (nonatomic, strong) UIImageView * bigImage;
@property (nonatomic, strong) UILabel     * markLabel;
@property (nonatomic, strong) UILabel     * distanceLabel;
@property (nonatomic, strong) UILabel     * nameLabel;
@property (nonatomic, strong) UILabel     * busineLabel;
@property (nonatomic, strong) UIImageView * lightStar;
@property (nonatomic, strong) UIImageView * darkStar;
@property (nonatomic, strong) UILabel     * saleNum;
@property (nonatomic, strong) UIButton    * deleteBtn;
@property (nonatomic, strong) UIView      * labelBackView;
@property (nonatomic, strong) UIView      * discountBackView;
@property (nonatomic, strong) UIView      * lineView;

//刷新cell
- (void)resetCellWithModel:(ModelBtn *)mdoel;

@end
