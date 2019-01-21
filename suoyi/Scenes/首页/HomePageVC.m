//
//  HomePageVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "HomePageVC.h"
#import "RecommendTabVC.h"
@interface HomePageVC ()
@property (nonatomic, strong) ProductMarketNavView * navView;
@property (nonatomic, strong) HomePageHeaderView * headerView;
@property (nonatomic, strong) HomePageSecHeaderView * secHeadView;
@end

@implementation HomePageVC
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
- (HomePageHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [HomePageHeaderView new];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _headerView.height);
    }
    return  _headerView;
}
- (HomePageSecHeaderView *)secHeadView
{
    if (_secHeadView == nil) {
        _secHeadView = [HomePageSecHeaderView  new];
        _secHeadView.backgroundColor = [UIColor whiteColor];
        _secHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _secHeadView.height);
        _secHeadView.topToUpView = W(5);
    }
    return  _secHeadView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    self.viewBG.backgroundColor = COLOR_NAV_COLOR;
    self.tableView.tableHeaderViews = @[self.headerView,self.secHeadView];
}




#pragma mark - 改变statusbar颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end





@implementation HomePageHeaderView
#pragma mark 懒加载
- (UIImageView *)backView{
    if (_backView == nil) {
        _backView = [UIImageView new];
        _backView.image = [UIImage imageNamed:@"12"];
        _backView.widthHeight = XY(SCREEN_WIDTH,W(250));
    }
    return _backView;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor whiteColor] text:@""];
    }
    return _labelTitle;
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
    [self addSubview:self.backView];
    [self addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.backView.leftTop = XY(0,0);
    
    [GlobalMethod resetLabel:self.labelTitle text:@"滑动按钮，开始视频通话" widthLimit:0];
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH/2,W(50));
    
    self.height = self.backView.bottom;
}

@end




@implementation HomePageSecHeaderView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.backgroundColor = COLOR_LINE;
        _imgView.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_imgView color:[UIColor clearColor] numRound:_imgView.width/2 width:0];
    }
    return _imgView;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UIControl *)control{
    if (_control == nil) {
        _control = [UIControl new];
        _control.tag = 1;
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor = [UIColor clearColor];
        _control.widthHeight = XY(W(55),W(70));
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
    [self addSubview:self.labelTitle];
    [self addSubview:self.imgView];
    [self addSubview:self.labelName];
    [self addSubview:self.control];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.labelTitle text:@"留言" widthLimit:0];
    self.labelTitle.leftTop = XY(W(15),W(15));
    
    self.imgView.leftTop = XY(W(15),self.labelTitle.bottom+W(15));
    
    [GlobalMethod resetLabel:self.labelName text:@"家庭通讯录" widthLimit:0];
    self.labelName.centerXTop = XY(self.imgView.centerX,self.imgView.bottom+W(8));
    
    self.control.leftTop = XY(W(0),self.labelTitle.bottom+W(15));
    
    self.height = [self addLineFrame:CGRectMake(0, self.labelName.bottom+W(15), SCREEN_WIDTH, 1)];
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






