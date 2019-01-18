//
//  ResourcesView.m
//  suoyi
//
//  Created by 王伟 on 2019/1/18.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "ResourcesView.h"

@implementation ResourcesView
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UIImageView *)backImg{
    if (_backImg == nil) {
        _backImg = [UIImageView new];
        _backImg.widthHeight = XY(SCREEN_WIDTH-W(40),W(100));
        [GlobalMethod setRoundView:_backImg color:[UIColor clearColor] numRound:8 width:0];
    }
    return _backImg;
}
- (UIImageView *)topImg{
    if (_topImg == nil) {
        _topImg = [UIImageView new];
        _topImg.widthHeight = XY(W(90),W(90));
        [GlobalMethod setRoundView:_topImg color:[UIColor clearColor] numRound:8 width:0];
    }
    return _topImg;
}
- (UIImageView *)firImg{
    if (_firImg == nil) {
        _firImg = [UIImageView new];
        _firImg.widthHeight = XY(SCREEN_WIDTH/2-W(30),W(70));
        [GlobalMethod setRoundView:_firImg color:[UIColor clearColor] numRound:8 width:0];
    }
    return _firImg;
}
- (UILabel *)labelFir{
    if (_labelFir == nil) {
        _labelFir = [UILabel new];
        [GlobalMethod setLabel:_labelFir widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_LABEL text:@""];
    }
    return _labelFir;
}
- (UIImageView *)secImg{
    if (_secImg == nil) {
        _secImg = [UIImageView new];
        _secImg.widthHeight = XY(SCREEN_WIDTH/2-W(30),W(70));
        [GlobalMethod setRoundView:_secImg color:[UIColor clearColor] numRound:8 width:0];
    }
    return _secImg;
}
- (UILabel *)labelSec{
    if (_labelSec == nil) {
        _labelSec = [UILabel new];
        [GlobalMethod setLabel:_labelSec widthLimit:0 numLines:0 fontNum:F(14) textColor:COLOR_LABEL text:@""];
    }
    return _labelSec;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelName];
    [self addSubview:self.backImg];
    [self addSubview:self.topImg];
    [self addSubview:self.firImg];
    [self addSubview:self.labelFir];
    [self addSubview:self.secImg];
    [self addSubview:self.labelSec];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResources *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.nameStr) widthLimit:0];
    self.labelName.leftTop = XY(W(25),W(15)+[self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(5)) color:COLOR_BACKGROUND]);
    
    _backImg.image = [UIImage imageNamed:UnPackStr(model.backStr)];
    self.backImg.leftTop = XY(W(25),self.labelName.bottom+W(15));
    
    self.topImg.image = [UIImage imageNamed:UnPackStr(model.topStr)];
    self.topImg.rightTop = XY(SCREEN_WIDTH-W(25),self.backImg.top-W(15));
    
    self.firImg.image = [UIImage imageNamed:UnPackStr(model.firStr)];
    self.firImg.leftTop = XY(W(25),self.backImg.bottom+W(10));
    
    [GlobalMethod resetLabel:self.labelFir text:UnPackStr(model.firLabelStr) widthLimit:0];
    self.labelFir.leftTop = XY(self.firImg.left,self.firImg.bottom+W(8));
    
    self.secImg.image = [UIImage imageNamed:UnPackStr(model.secStr)];
    self.secImg.leftTop = XY(W(20)+self.firImg.right,self.firImg.top);
    
    [GlobalMethod resetLabel:self.labelSec text:UnPackStr(model.secLabelStr) widthLimit:0];
    self.labelSec.leftTop = XY(self.secImg.left,self.secImg.bottom+W(8));
    
    self.height = self.labelFir.bottom + W(15);
}

@end


@implementation ModelResources

@end
