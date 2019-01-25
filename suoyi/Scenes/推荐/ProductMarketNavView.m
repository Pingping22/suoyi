//
//  ProductMarketNavView.m
//  suoyi
//
//  Created by 王伟 on 2019/1/23.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "ProductMarketNavView.h"

@implementation ProductMarketNavView

#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"icon-sy-gray"];
        _iconImg.widthHeight = XY(W(15),W(15));
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
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"icon-my-gray"];
        _imgView.widthHeight = XY(W(15),W(15));
    }
    return _imgView;
}
- (UILabel *)labelRed{
    if (_labelRed == nil) {
        _labelRed = [UILabel new];
        [GlobalMethod setLabel:_labelRed widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelRed;
}
- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [UIView  new];
        _lineView.backgroundColor = COLOR_LINE;
        _lineView.widthHeight = XY(SCREEN_WIDTH, 1);
    }
    return  _lineView;
}
- (UIControl *)control{
    if (_control == nil) {
        _control = [UIControl new];
        _control.tag = 1;
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor = [UIColor clearColor];
        _control.widthHeight = XY(W(50),W(50));
    }
    return _control;
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
    [self addSubview:self.iconImg];
    [self addSubview:self.labelName];
    [self addSubview:self.imgView];
    [self addSubview:self.labelRed];
    [self addSubview:self.lineView];
    [self addSubview:self.control];

    //初始化页面
    [self resetViewWithTitle:nil];
}

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)searchTitle{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(searchTitle) widthLimit:0];
    self.labelName.centerXCenterY = XY(SCREEN_WIDTH/2,(NAVIGATIONBAR_HEIGHT+STATUSBAR_HEIGHT)/2);
    
    self.iconImg.rightCenterY = XY(self.labelName.left-W(5),self.labelName.centerY);
    
    self.imgView.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelName.centerY);
    
    self.control.rightTop = XY(SCREEN_WIDTH,0);

    [GlobalMethod resetLabel:self.labelRed text:@"" widthLimit:0];
    self.labelRed.rightTop = XY(W(2)+self.imgView.right,self.imgView.top);
    
    self.lineView.leftBottom = XY(0, NAVIGATIONBAR_HEIGHT);
    self.height = self.lineView.bottom;
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav pushVCName:@"MineSetVC" animated:true];
        }
            break;
            
        default:
            break;
    }
}
@end
