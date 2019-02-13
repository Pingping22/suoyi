//
//  SkillsCell.m
//  suoyi
//
//  Created by 王伟 on 2019/1/18.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "SkillsCell.h"

@implementation SkillsCell
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.widthHeight = XY(W(40),W(40));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:5 width:0];
    }
    return _iconImg;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(9) textColor:COLOR_DETAIL text:@""];
    }
    return _labelTitle;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        [GlobalMethod setLabel:_labelContent widthLimit:0 numLines:0 fontNum:F(11) textColor:COLOR_DETAIL text:@""];
    }
    return _labelContent;
}

-(UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.tag = 1;
        [_sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.backgroundColor = UIColorFromHexRGB(@"#F4F4F4");
        [_sureBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:F(14)];
        [GlobalMethod setRoundView:_sureBtn color:[UIColor clearColor] numRound:3 width:0];
        [_sureBtn setTitle:@"启用" forState:(UIControlStateNormal)];
        _sureBtn.widthHeight = XY(W(50),W(30));
    }
    return _sureBtn;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelContent];
        [self.contentView addSubview:self.sureBtn];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelSkills *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    _iconImg.image = [UIImage imageNamed:UnPackStr(model.iconStr)];
    self.iconImg.leftTop = XY(W(25),W(15));
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.nameStr) widthLimit:0];
    self.labelName.leftTop = XY(W(15)+self.iconImg.right,self.iconImg.top+W(3));
    
    [GlobalMethod resetLabel:self.labelTitle text:UnPackStr(model.titleStr) widthLimit:0];
    [self addLineFrame:CGRectMake(self.labelName.right+W(5), W(5)+self.labelName.top, 1, W(10))];
    self.labelTitle.leftCenterY = XY(self.labelName.right+W(10),self.labelName.centerY);
    
    [GlobalMethod resetLabel:self.labelContent text:UnPackStr(model.contentStr) widthLimit:0];
    self.labelContent.leftTop = XY(self.labelName.left,self.labelName.bottom+W(3));
    
    self.sureBtn.rightCenterY = XY(SCREEN_WIDTH-W(15),self.iconImg.centerY);
    
    self.height = self.iconImg.bottom + W(15);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
