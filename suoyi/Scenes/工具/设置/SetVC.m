//
//  SetVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/21.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "SetVC.h"
#import "RecommendTabVC.h"

@interface SetVC ()
@property (nonatomic, strong) SetView * headerView;
@end

@implementation SetVC
- (SetView *)headerView
{
    if (_headerView == nil) {
        _headerView = [SetView new];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _headerView.height);
    }
    return  _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"设置" rightView:nil]];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.tableHeaderView = self.headerView;

}



@end




@implementation SetView
#pragma mark 懒加载
- (UIImageView *)backView{
    if (_backView == nil) {
        _backView = [UIImageView new];
        _backView.image = [UIImage imageNamed:@"12"];
        _backView.widthHeight = XY(SCREEN_WIDTH,W(250));
    }
    return _backView;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"22"];
        _iconImg.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
    }
    return _iconImg;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor whiteColor] text:@""];
    }
    return _labelName;
}
- (UIView *)nameView{
    if (_nameView == nil) {
        _nameView = [UIView new];
        _nameView.backgroundColor = [UIColor whiteColor];
    }
    return _nameView;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (UILabel *)labelNa{
    if (_labelNa == nil) {
        _labelNa = [UILabel new];
        [GlobalMethod setLabel:_labelNa widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_DETAIL text:@""];
    }
    return _labelNa;
}
-(UIButton *)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.tag = 1;
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = [UIColor redColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [GlobalMethod setRoundView:_btn color:[UIColor clearColor] numRound:20 width:0];
        [_btn setTitle:@"删除设备" forState:(UIControlStateNormal)];
        _btn.widthHeight = XY(SCREEN_WIDTH - W(20),W(40));
    }
    return _btn;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.backView];
    [self addSubview:self.iconImg];
    [self addSubview:self.labelName];
    [self addSubview:self.nameView];
    [self.nameView addSubview:self.labelTitle];
    [self.nameView addSubview:self.labelNa];
    [self addSubview:self.btn];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.backView.leftTop = XY(0,0);
    
    self.iconImg.centerXTop = XY(SCREEN_WIDTH/2,W(20));
    
    [GlobalMethod resetLabel:self.labelName text:@"视频号码：606895" widthLimit:0];
    self.labelName.centerXTop = XY(SCREEN_WIDTH/2,self.iconImg.bottom+W(15));
    
    self.nameView.widthHeight = XY(SCREEN_WIDTH, W(50));
    self.nameView.leftTop = XY(0,self.backView.bottom);
    
    [GlobalMethod resetLabel:self.labelTitle text:@"名称" widthLimit:0];
    self.labelTitle.leftTop = XY(W(10),W(15));
    
    [GlobalMethod resetLabel:self.labelNa text:@"你好的家" widthLimit:0];
    self.labelNa.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelTitle.centerY);
    
    self.nameView.height = self.labelTitle.bottom+W(15);
    
    self.btn.leftTop = XY(W(10),self.nameView.bottom+W(15));
    
    self.height = self.btn.bottom;
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
