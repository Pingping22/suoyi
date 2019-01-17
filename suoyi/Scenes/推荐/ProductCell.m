//
//  ProductCell.m
//  ngj
//
//  Created by lirenbo on 2017/12/19.
//  Copyright © 2017年 lanber. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

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
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.specifsicaLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.shopName];
    [self.contentView addSubview:self.intoStore];
    [self.contentView addSubview:self.moreBtn];
    [self.contentView addSubview:self.lineView];
}

#pragma marl - 懒加载
- (UIImageView *)bigImage
{
    if (_bigImage == nil) {
        _bigImage = [UIImageView  new];
        _bigImage.widthHeight = XY(W(107), W(107));
        _bigImage.layer.borderWidth = 0.6;
        _bigImage.layer.borderColor = COLOR_LINE.CGColor;
        _bigImage.layer.cornerRadius = W(6);
        _bigImage.layer.masksToBounds = YES;
        _bigImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return  _bigImage;
}

- (UILabel *)markLabel
{
    if (_markLabel == nil) {
        _markLabel = [UILabel  new];
        _markLabel.textColor = [UIColor whiteColor];
        _markLabel.fontNum = F(9);
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.layer.cornerRadius = W(6);
        _markLabel.layer.masksToBounds = YES;
    }
    return  _markLabel;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel  new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:F(16)];
    }
    return  _nameLabel;
}

- (UILabel *)specifsicaLabel
{
    if (_specifsicaLabel == nil) {
        _specifsicaLabel = [UILabel  new];
        _specifsicaLabel.fontNum = F(12);
        _specifsicaLabel.textColor = UIColorFromHexRGB(@"#9E9E9E");;
    }
    return  _specifsicaLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel  new];
        _contentLabel.fontNum = F(12);
        _contentLabel.textColor = UIColorFromHexRGB(@"#9E9E9E");;
    }
    return  _contentLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel  new];
        _priceLabel.textColor = [UIColor orangeColor];
    }
    return  _priceLabel;
}

- (UILabel *)numLabel
{
    if (_numLabel == nil) {
        _numLabel = [UILabel  new];
        _numLabel.fontNum = F(11);
        _numLabel.textColor = UIColorFromHexRGB(@"#9E9E9E");
    }
    return  _numLabel;
}

- (UILabel *)shopName
{
    if (_shopName == nil) {
        _shopName = [UILabel  new];
        _shopName.fontNum = F(12);
        _shopName.textColor = UIColorFromHexRGB(@"#9E9E9E");;
    }
    return  _shopName;
}

- (UIButton *)intoStore
{
    if (_intoStore == nil) {
        _intoStore = [UIButton  new];
        _intoStore.titleLabel.textColor = UIColorFromHexRGB(@"#1B1B1B");
        _intoStore.titleLabel.fontNum = F(12);
        NSString * str = @"进店 ";
        [_intoStore setAttributedTitle:[str setAttributeImageName:@"右箭头-黑" imageRect:CGRectMake(0, -0.4, 5, 9) withIndex:str.length] forState:UIControlStateNormal];
        [_intoStore addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _intoStore;
}

- (UIButton *)moreBtn
{
    if (_moreBtn == nil) {
        _moreBtn = [UIButton  new];
        [_moreBtn setImage:[UIImage imageNamed:@"首页-更多"] forState:UIControlStateNormal];
    }
    return  _moreBtn;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [UIView  new];
        _lineView.backgroundColor = COLOR_LINE;
    }
    return  _lineView;
}

#pragma mark - 懒加载
- (void)btnClick:(UIButton *)sender
{
    NSLog(@"---进店---");
}

#pragma mark - 刷新cell
- (void)resetCellWithModel:(ModelProductItem *)model
{
    self.bigImage.leftTop = XY(W(10), W(12));
    [self.bigImage sd_setImageWithUrlStr:UnPackStr(model.imageUrl) placeholderImage:IMAGE_HEAD_DEFAULT withWidth:0 withHeight:0];
    
    [self.markLabel fitTitle:@"新品" variable:0];
    self.markLabel.backgroundColor = [UIColor orangeColor];
    self.markLabel.widthHeight = XY(ceilf(self.markLabel.width+W(6)) , ceilf(self.markLabel.height+W(3)));
    self.markLabel.rightTop = XY(self.bigImage.width, 0);
    
    [self.nameLabel fitTitle:UnPackStr(model.name) fixed:(SCREEN_WIDTH-self.bigImage.left-self.bigImage.right-W(10))];
    self.nameLabel.leftTop = XY(self.bigImage.right+W(10), self.bigImage.top+W(2));
    
    [self.specifsicaLabel fitTitle:UnPackStr(model.specifications) fixed:(SCREEN_WIDTH-self.bigImage.left-self.nameLabel.left)];
    self.specifsicaLabel.leftTop = XY(self.nameLabel.left, self.nameLabel.bottom+W(4));
    
    [self.contentLabel fitTitle:UnPackStr(model.intro) fixed:(SCREEN_WIDTH-self.bigImage.left-self.nameLabel.left)];
    self.contentLabel.leftTop = XY(self.nameLabel.left, self.specifsicaLabel.bottom+W(4));
    
    //价格
    NSString * pricrStr = [NSString stringWithFormat:@"¥%@",strDot2F(model.price)];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:pricrStr];
    UIFont * font = [UIFont boldSystemFontOfSize:F(20)];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(1,pricrStr.length-1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:F(10)] range:NSMakeRange(0, 1)];
    [self.priceLabel setAttributedText:attrString];
    [self.priceLabel sizeToFit];
    self.priceLabel.leftTop = XY(self.nameLabel.left, self.contentLabel.bottom+W(6));
    
    [self.numLabel fitTitle:[NSString stringWithFormat:@"%@人付款",strDotF(model.payment)] variable:0];
    self.numLabel.leftBottom = XY(self.priceLabel.right+W(5), self.priceLabel.bottom-W(3));
    
    [self.shopName fitTitle:UnPackStr(model.store) variable:(SCREEN_WIDTH-(10+2*self.bigImage.left)-W(45)-self.nameLabel.left)];
    self.shopName.leftTop = XY(self.nameLabel.left, self.priceLabel.bottom+W(3));
    
    self.intoStore.widthHeight = XY(W(45), W(30));
    self.intoStore.leftCenterY = XY(self.shopName.right, self.shopName.centerY);
    
    self.moreBtn.widthHeight = XY(10+2*self.bigImage.left, W(30));
    self.moreBtn.rightCenterY = XY(SCREEN_WIDTH, self.shopName.centerY);
    
    self.lineView.widthHeight = XY(SCREEN_WIDTH-2*W(10), 0.6);
    self.lineView.leftTop = XY(W(10), self.bigImage.bottom+self.bigImage.top);
    self.height = self.lineView.bottom;
}

@end
