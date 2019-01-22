//
//  ToolsTabVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "ToolsTabVC.h"
#import "RecommendTabVC.h"

@interface ToolsTabVC ()
@property (nonatomic, strong) ProductMarketNavView * navView;
@property (nonatomic, strong) ToolsTabHeaderView * headerView;
@end

@implementation ToolsTabVC

#pragma mark - lazy
- (ProductMarketNavView *)navView
{
    if (_navView == nil) {
        _navView = [ProductMarketNavView  new];
        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        [_navView resetViewWithTitle:@"你好的家"];
    }
    return  _navView;
}
- (ToolsTabHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [ToolsTabHeaderView new];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _headerView.height);
    }
    return  _headerView;
}


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.navView];
}



@end






@implementation ToolsTabHeaderView
#pragma mark 懒加载
- (UIImageView *)conImg{
    if (_conImg == nil) {
        _conImg = [UIImageView new];
        _conImg.image = [UIImage imageNamed:@"12"];
        _conImg.widthHeight = XY(W(30),W(30));
    }
    return _conImg;
}
- (UILabel *)labelCon{
    if (_labelCon == nil) {
        _labelCon = [UILabel new];
        [GlobalMethod setLabel:_labelCon widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_LABEL text:@""];
    }
    return _labelCon;
}
- (UIControl *)control{
    if (_control == nil) {
        _control = [UIControl new];
        _control.tag = 1;
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor = [UIColor clearColor];
        _control.widthHeight = XY(SCREEN_WIDTH,W(0));
    }
    return _control;
}
- (UIImageView *)setImg{
    if (_setImg == nil) {
        _setImg = [UIImageView new];
        _setImg.image = [UIImage imageNamed:@"22"];
        _setImg.widthHeight = XY(W(30),W(30));
    }
    return _setImg;
}
- (UILabel *)labelSet{
    if (_labelSet == nil) {
        _labelSet = [UILabel new];
        [GlobalMethod setLabel:_labelSet widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_LABEL text:@""];
    }
    return _labelSet;
}
- (UIControl *)setControl{
    if (_setControl == nil) {
        _setControl = [UIControl new];
        _setControl.tag = 2;
        [_setControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _setControl.backgroundColor = [UIColor clearColor];
    }
    return _setControl;
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
    [self addSubview:self.conImg];
    [self addSubview:self.labelCon];
    [self addSubview:self.control];
    [self addSubview:self.setImg];
    [self addSubview:self.labelSet];
    [self addSubview:self.setControl];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.conImg.centerXTop = XY(SCREEN_WIDTH/4,W(20));
    
    [GlobalMethod resetLabel:self.labelCon text:@"开始远程控制" widthLimit:0];
    self.labelCon.centerXTop = XY(self.conImg.centerX,self.conImg.bottom+W(8));
    
    self.control.widthHeight = XY(W(60), W(60));
    self.control.centerXTop = XY(SCREEN_WIDTH/4,W(20));
    
    self.setImg.centerXTop = XY(SCREEN_WIDTH/4*3,W(20));
    
    [GlobalMethod resetLabel:self.labelSet text:@"设置" widthLimit:0];
    self.labelSet.centerXTop = XY(self.setImg.centerX,self.setImg.bottom+W(8));
    
    self.setControl.widthHeight = XY(W(60), W(60));
    self.setControl.centerXTop = XY(SCREEN_WIDTH/4*3,W(20));
    
    self.height = W(200);
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            
        }
            break;
        case 2://设置
        {
            [GB_Nav pushVCName:@"SetVC" animated:true];
        }
            break;
        default:
            break;
    }
}
@end





