//
//  MineSetVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/25.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "MineSetVC.h"
//baseImage;
#import "BaseImage.h"
//#import "AliClient.h"
#import "UIView+SelectImageView.h"
@interface MineSetVC ()
@property (nonatomic, strong) MineSetHeaderView * headerView;
@end

@implementation MineSetVC
- (MineSetHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [MineSetHeaderView new];
    }
    return  _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"" rightView:nil]];
    self.tableView.tableHeaderView = self.headerView;
}


@end





@implementation MineSetHeaderView
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(20) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        [GlobalMethod setLabel:_labelContent widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_DETAIL text:@""];
    }
    return _labelContent;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"12"];
        _iconImg.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
    }
    return _iconImg;
}
- (UIControl *)control{
    if (_control == nil) {
        _control = [UIControl new];
        _control.tag = 1;
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor = [UIColor clearColor];
    }
    return _control;
}
-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.tag = 2;
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.backgroundColor = [UIColor orangeColor];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:F(17)];
        [GlobalMethod setRoundView:_addBtn color:[UIColor clearColor] numRound:W(20) width:0];
        [_addBtn setTitle:@"添加设备" forState:(UIControlStateNormal)];
        _addBtn.widthHeight = XY(W(100),W(40));
    }
    return _addBtn;
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
    [self addSubview:self.labelContent];
    [self addSubview:self.iconImg];
    [self addSubview:self.control];
    [self addSubview:self.addBtn];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.labelName text:@"你" widthLimit:0];
    self.labelName.leftTop = XY(W(15),W(15));
    
    [GlobalMethod resetLabel:self.labelContent text:@"查看并编辑个人资料" widthLimit:0];
    self.labelContent.leftTop = XY(W(15),self.labelName.bottom+W(5));
    
    self.iconImg.rightTop = XY(SCREEN_WIDTH-W(15),W(15));
    self.control.widthHeight = XY(SCREEN_WIDTH, self.labelContent.bottom+W(20));
    self.control.leftTop = XY(0,0);
    
    self.addBtn.centerXTop = XY(SCREEN_WIDTH/2,self.control.bottom);
    
    self.height = [self addLineFrame:CGRectMake(0, self.addBtn.bottom+W(15), SCREEN_WIDTH, W(5)) color:COLOR_BACKGROUND];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav pushVCName:@"MineSetEditVC" animated:true];
        }
            break;
            
        default:
            break;
    }
}

@end








