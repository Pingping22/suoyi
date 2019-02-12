//
//  HomePageVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "HomePageVC.h"
#import "ProductMarketNavView.h"

@interface HomePageVC ()
@property (nonatomic, strong) ProductMarketNavView * navView;
@property (nonatomic, strong) HomePageHeaderView * headerView;
@property (nonatomic, strong) HomePageSecHeaderView * secHeadView;
@property (nonatomic, strong) HomePageThirHeaderView * thirView;
@end

@implementation HomePageVC
@synthesize tableView = _tableView;

#pragma mark - lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navView.bottom-TABBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.strCellName != nil) {
            [_tableView registerClass:NSClassFromString(self.strCellName) forCellReuseIdentifier:self.strCellName];
        }
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tableView;
}
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
    }
    return  _secHeadView;
}
- (HomePageThirHeaderView *)thirView
{
    if (_thirView == nil) {
        _thirView = [HomePageThirHeaderView new];
        _thirView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _thirView.height);
        NSMutableArray *arr = @[^(){
            ModelImage * model = [ModelImage new];
            model.url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548138517507&di=78799c29d427b33735de2756e1a89a2d&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201701%2F2017022305.jpg";
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.url = @"22";
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548139295838&di=77757991a6ffe2652e4e7589f5d7dd68&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201508%2F03%2F20150803090619_sYGZM.thumb.700_0.jpeg";
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548138934438&di=382a1d65280c7b7544c9b4515b0f39c3&imgtype=0&src=http%3A%2F%2Fs1.sinaimg.cn%2Fmw690%2F001KcHF3zy75TWW2s7ud0%26690";
            return model;
        }()].mutableCopy;
        ModelImage * model = [ModelImage new];
        model.url = @"22";
        [arr addObject:model];
        [_thirView resetWithAry:arr];
    }
    return  _thirView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    self.viewBG.backgroundColor = COLOR_BACKGROUND;
    self.tableView.tableHeaderViews = @[self.headerView,self.secHeadView,self.thirView];
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
- (SPMultipleSwitch *)switch3
{
    if (_switch3 == nil) {
        _switch3 = [[SPMultipleSwitch alloc] initWithItems:@[@"",@"视频通话"]];
        _switch3.widthHeight = XY(SCREEN_WIDTH-W(180),W(40));
        _switch3.backgroundColor = COLOR_GREEN;
        _switch3.selectedTitleColor = [UIColor clearColor];
        _switch3.titleColor = [UIColor whiteColor];
        _switch3.trackerColor = [UIColor whiteColor];
        _switch3.contentInset = 5;
        _switch3.spacing = 10;
        _switch3.titleFont = [UIFont systemFontOfSize:F(12)];
        _switch3.trackerImage = [UIImage imageNamed:@"tracker"];
        [_switch3 addTarget:self action:@selector(switchAction3:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _switch3;
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
    [self addSubview:self.switch3];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.backView.leftTop = XY(0,0);
    
    [GlobalMethod resetLabel:self.labelTitle text:@"滑动按钮，开始视频通话" widthLimit:0];
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH/2,W(80));
    
    self.switch3.leftTop = XY(W(90),W(50)+self.labelTitle.bottom);

    self.backView.height = self.switch3.bottom+W(10);
    self.height = self.backView.bottom;
}
- (void)switchAction3:(SPMultipleSwitch *)multipleSwitch {
    NSLog(@"点击了第%zd个",multipleSwitch.selectedSegmentIndex);
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
            [GB_Nav pushVCName:@"HomeAddressBookListVC" animated:true];
        }
            break;
            
        default:
            break;
    }
}
@end




@implementation HomePageThirHeaderView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.tag = 1;
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:F(12)];
        [_addBtn setTitle:@"添加照片" forState:(UIControlStateNormal)];
        [_addBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        _addBtn.widthHeight = XY(W(100),W(20));
    }
    return _addBtn;
}
- (MineListMindImgView *)upImageInfoView{
    if (!_upImageInfoView) {
        _upImageInfoView = [MineListMindImgView new];
        _upImageInfoView.topInteral = W(2);
        _upImageInfoView.numLimit = 3;
    }
    return _upImageInfoView;
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
    [self addSubview:self.addBtn];
    [self addSubview:self.upImageInfoView];

    //初始化页面
    [self resetWithAry:nil];
}

#pragma mark 刷新view
- (void)resetWithAry:(NSArray *)aryImage{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.labelTitle text:@"家庭相册" widthLimit:0];
    self.labelTitle.leftTop = XY(W(15),W(15));
    
    self.addBtn.rightCenterY = XY(SCREEN_WIDTH,self.labelTitle.centerY);
    
    self.upImageInfoView.top = self.labelTitle.bottom+W(15);

    [self.upImageInfoView resetViewWithArray:aryImage];

    self.height = self.upImageInfoView.bottom+W(15);

}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav pushVCName:@"CustomPhotoAlbumViewController" animated:true];
        }
            break;
            
        default:
            break;
    }
}




@end





