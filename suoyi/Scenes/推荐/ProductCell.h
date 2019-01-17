//
//  ProductCell.h
//  ngj
//
//  Created by lirenbo on 2017/12/19.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

@property (nonatomic, strong) UIImageView * bigImage;
@property (nonatomic, strong) UILabel     * markLabel;
@property (nonatomic, strong) UILabel     * nameLabel;
@property (nonatomic, strong) UILabel     * specifsicaLabel;
@property (nonatomic, strong) UILabel     * contentLabel;
@property (nonatomic, strong) UILabel     * priceLabel;
@property (nonatomic, strong) UILabel     * numLabel;
@property (nonatomic, strong) UILabel     * shopName;
@property (nonatomic, strong) UIButton    * intoStore;
@property (nonatomic, strong) UIButton    * moreBtn;
@property (nonatomic, strong) UIView      * lineView;


//刷新cell
- (void)resetCellWithModel:(ModelProductItem *)model;

@end
