//
//  RecommendTabVC.m
//  lanberProject
//
//  Created by runda on 2018/9/27.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "RecommendTabVC.h"
//view
#import "RecommendSkillsView.h"
#import "ResourcesView.h"
//cell
#import "SkillsCell.h"
//nav
#import "ProductMarketNavView.h"

@interface RecommendTabVC ()

@property (nonatomic, strong) ProductMarketNavView * navView;
@property (nonatomic, strong) ProductMarketHeaderView * sectionHeadView;
@property (nonatomic, assign) NSInteger markTag;
@property (nonatomic, strong) NSMutableArray * productAry;
@property (nonatomic, strong) NSMutableArray * retailerAry;
@property (nonatomic, strong) ProductMarketSecHeaderView * secHeadView;
@property (nonatomic, strong) RecommendSkillsView * thirView;
@property (nonatomic, strong) TrySkillsView * fourView;
@property (nonatomic, strong) ResourcesView * videoView;
@property (nonatomic, strong) ResourcesView * audioView;
@property (nonatomic, strong) ResourcesView * musicView;
@property (nonatomic, strong) ResourcesView * childView;

@end

@implementation RecommendTabVC
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
- (ProductMarketHeaderView *)sectionHeadView
{
    if (_sectionHeadView == nil) {
        _sectionHeadView = [ProductMarketHeaderView  new];
        _sectionHeadView.backgroundColor = [UIColor whiteColor];
        _sectionHeadView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT+1, SCREEN_WIDTH, _sectionHeadView.height);
        [_sectionHeadView resetViewWithTitle:@"搜索技能"];
    }
    return  _sectionHeadView;
}
- (ProductMarketSecHeaderView *)secHeadView
{
    if (_secHeadView == nil) {
        _secHeadView = [ProductMarketSecHeaderView  new];
        _secHeadView.backgroundColor = [UIColor whiteColor];
        _secHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _secHeadView.height);
        [_secHeadView resetViewWithArray:@[@"内容资源",@"教育教学",@"益智游戏",@"休闲娱乐",@"生活服务",@"小度训练师",@"技能分类",@"个人中心"] imgArr:@[@"icon-wd-gray",@"icon-wd-green",@"icon-sy-gray",@"icon-sy-green",@"icon-wd-gray",@"icon-wd-green",@"icon-sy-gray",@"icon-sy-green"]];
        _secHeadView.topToUpView = W(5);
    }
    return  _secHeadView;
}
- (RecommendSkillsView *)thirView
{
    if (_thirView == nil) {
        _thirView = [RecommendSkillsView  new];
        _thirView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W(280));
        NSMutableArray *ary = [NSMutableArray array];
        [ary addObjectsFromArray:@[^(){
            ModelSkills * model = [ModelSkills new];
            model.imgStr = @"zy_1";
            model.iconStr = @"zy_1";
            model.nameStr = @"斗兽棋";
            model.titleStr = @"益智游戏";
            model.contentStr = @"胜负对决，你能否站在食物链的顶端";
            return model;
        }(),^(){
            ModelSkills * model = [ModelSkills new];
            model.imgStr = @"zy_1";
            model.iconStr = @"zy_1";
            model.nameStr = @"冲鸭";
            model.titleStr = @"益智游戏";
            model.contentStr = @"酷跑冲冲冲，冲鸭赢大奖";
            return model;
        }(),^(){
            ModelSkills * model = [ModelSkills new];
            model.imgStr = @"zy_1";
            model.iconStr = @"zy_1";
            model.nameStr = @"尖叫鸡";
            model.titleStr = @"休闲娱乐";
            model.contentStr = @"疯狂咯咯咯，狂捏赢大奖";
            return model;
        }(),^(){
            ModelSkills * model = [ModelSkills new];
            model.imgStr = @"zy_1";
            model.iconStr = @"zy_1";
            model.nameStr = @"最新影讯";
            model.titleStr = @"工具效率";
            model.contentStr = @"查最新影讯，看精彩影片";
            return model;
        }(),^(){
            ModelSkills * model = [ModelSkills new];
            model.imgStr = @"zy_1";
            model.iconStr = @"zy_1";
            model.nameStr = @"数学游戏";
            model.titleStr = @"益智游戏";
            model.contentStr = @"在应用题的海洋里遨游吧";
            return model;
        }(),^(){
            ModelSkills * model = [ModelSkills new];
            model.imgStr = @"zy_1";
            model.iconStr = @"zy_1";
            model.nameStr = @"我的手机在哪";
            model.titleStr = @"工具效率";
            model.contentStr = @"呼唤我，找手机不费力";
            return model;
        }()]];
        [_thirView resetWithImageAry:ary];
        _thirView.topToUpView = W(5);

    }
    return  _thirView;
}
- (TrySkillsView *)fourView
{
    if (_fourView == nil) {
        _fourView = [TrySkillsView new];
        _fourView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _fourView.height);
        _fourView.topToUpView = W(5);
        [_fourView resetViewWithStr:@"技能尝鲜"];
    }
    return  _fourView;
}
- (ResourcesView *)videoView
{
    if (_videoView == nil) {
        _videoView = [ResourcesView new];
        _videoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _videoView.height);
        _videoView.topToUpView = W(5);
        ModelResources *model = [ModelResources new];
        model.nameStr = @"视频资源";
        model.backStr = @"22";
        model.topStr = @"12";
        model.firStr = @"zy_3";
        model.firLabelStr = @"归去来";
        model.secStr = @"zy_4";
        model.secLabelStr = @"极限挑战第4季";
        [_videoView resetViewWithModel:model];
    }
    return  _videoView;
}
- (ResourcesView *)audioView
{
    if (_audioView == nil) {
        _audioView = [ResourcesView new];
        _audioView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _audioView.height);
        _audioView.topToUpView = W(5);
        ModelResources *model = [ModelResources new];
        model.nameStr = @"有声资源";
        model.backStr = @"22";
        model.topStr = @"12";
        model.firStr = @"zy_3";
        model.firLabelStr = @"心理罪";
        model.secStr = @"zy_4";
        model.secLabelStr = @"郭德纲相声";
        [_audioView resetViewWithModel:model];
    }
    return  _audioView;
}
- (ResourcesView *)musicView
{
    if (_musicView == nil) {
        _musicView = [ResourcesView new];
        _musicView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _musicView.height);
        _musicView.topToUpView = W(5);
        ModelResources *model = [ModelResources new];
        model.nameStr = @"QQ音乐";
        model.backStr = @"22";
        model.topStr = @"12";
        model.firStr = @"zy_3";
        model.firLabelStr = @"陈奕迅热门歌曲";
        model.secStr = @"zy_4";
        model.secLabelStr = @"王菲热门歌曲";
        [_musicView resetViewWithModel:model];
    }
    return  _musicView;
}
- (ResourcesView *)childView
{
    if (_childView == nil) {
        _childView = [ResourcesView new];
        _childView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _childView.height);
        _childView.topToUpView = W(5);
        ModelResources *model = [ModelResources new];
        model.nameStr = @"儿童资源";
        model.backStr = @"22";
        model.topStr = @"12";
        model.firStr = @"zy_3";
        model.firLabelStr = @"黑猫警长";
        model.secStr = @"zy_4";
        model.secLabelStr = @"小蓓蕾儿歌";
        [_childView resetViewWithModel:model];
    }
    return  _childView;
}
- (NSMutableArray *)productAry
{
    if (_productAry == nil) {
        _productAry = [NSMutableArray  new];
    }
    return  _productAry;
}

- (NSMutableArray *)retailerAry
{
    if (_retailerAry == nil) {
        _retailerAry = [NSMutableArray  new];
    }
    return  _retailerAry;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    UIButton *noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noticeBtn.tag = 1;
    [noticeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    noticeBtn.widthHeight = XY(W(40),W(40));
    noticeBtn.leftTop = XY(W(15), NAVIGATIONBAR_HEIGHT+W(15));
    [noticeBtn setImage:[UIImage imageNamed:@"xiaoxi"] forState:(UIControlStateNormal)];
    [self.view addSubview:noticeBtn];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderViews = @[self.sectionHeadView,self.secHeadView,self.thirView,self.fourView,self.videoView,self.audioView,self.musicView,self.childView];
    //cell
     [self.tableView registerClass:[SkillsCell class] forCellReuseIdentifier:@"SkillsCell"];
    //request
    [self requestList];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav pushVCName:@"MessageListVC" animated:true];
        }
            break;
            
        default:
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SkillsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkillsCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SkillsCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    [view removeSubViewWithTag:TAG_LINE];//移除线
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, W(100));
    view.backgroundColor = [UIColor whiteColor];
    UILabel*labelName = [UILabel new];
    [GlobalMethod setLabel:labelName widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_LABEL text:@""];
    switch (section) {
        case 0:
        {
            [GlobalMethod resetLabel:labelName text:@"小依小依，最新技能" widthLimit:0];
        }
            break;
        case 1:
        {
            [GlobalMethod resetLabel:labelName text:@"小依小依，热门技能" widthLimit:0];
        }
            break;
        case 2:
        {
            [GlobalMethod resetLabel:labelName text:@"实用贴心" widthLimit:0];
        }
            break;
        case 3:
        {
            [GlobalMethod resetLabel:labelName text:@"趣味游戏" widthLimit:0];
        }
            break;
        case 4:
        {
            [GlobalMethod resetLabel:labelName text:@"教育培养" widthLimit:0];
        }
            break;
        case 5:
        {
            [GlobalMethod resetLabel:labelName text:@"陪伴声音" widthLimit:0];
        }
            break;
        case 6:
        {
            [GlobalMethod resetLabel:labelName text:@"全部技能" widthLimit:0];
        }
            break;
        default:
            break;
    }
    labelName.leftTop = XY(W(25),W(15)+[view addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(5)) color:COLOR_BACKGROUND]);
    [view addSubview:labelName];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return W(40);
}
#pragma mark - request
- (void)requestList{
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelSkills * model = [ModelSkills new];
        model.iconStr = @"22";
        model.nameStr = @"斗兽棋";
        model.titleStr = @"益智游戏";
        model.contentStr = @"胜负对决，你能否站在食物链的顶端";
        return model;
    }(),^(){
        ModelSkills * model = [ModelSkills new];
        model.iconStr = @"12";
        model.nameStr = @"冲鸭";
        model.titleStr = @"益智游戏";
        model.contentStr = @"酷跑冲冲冲，冲鸭赢大奖";
        return model;
    }(),^(){
        ModelSkills * model = [ModelSkills new];
        model.iconStr = @"22";
        model.nameStr = @"尖叫鸡";
        model.titleStr = @"休闲娱乐";
        model.contentStr = @"疯狂咯咯咯，狂捏赢大奖";
        return model;
    }(),^(){
        ModelSkills * model = [ModelSkills new];
        model.iconStr = @"12";
        model.nameStr = @"最新影讯";
        model.titleStr = @"工具效率";
        model.contentStr = @"查最新影讯，看精彩影片";
        return model;
    }(),^(){
        ModelSkills * model = [ModelSkills new];
        model.iconStr = @"22";
        model.nameStr = @"数学游戏";
        model.titleStr = @"益智游戏";
        model.contentStr = @"在应用题的海洋里遨游吧";
        return model;
    }(),^(){
        ModelSkills * model = [ModelSkills new];
        model.iconStr = @"12";
        model.nameStr = @"我的手机在哪";
        model.titleStr = @"工具效率";
        model.contentStr = @"呼唤我，找手机不费力";
        return model;
    }()]];
}


@end




//auto sc
#import "AutoScView.h"
@implementation ProductMarketHeaderView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)addSubView
{
    [self addSubview:self.searchBtn];
    [self.searchBtn addSubview:self.searchImg];
    [self.searchBtn addSubview:self.searchTitle];
    [self addSubview:self.backView];
}

#pragma mark - 懒加载
- (UIButton *)searchBtn
{
    if (_searchBtn == nil) {
        _searchBtn = [UIButton  new];
        _searchBtn.backgroundColor = COLOR_LINE;
        _searchBtn.tag = 3;
        [_searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_searchBtn color:[UIColor clearColor] numRound:5 width:0];
    }
    return  _searchBtn;
}
- (AutoScView *)backView{
    if (_backView == nil) {
        _backView = [AutoScView new];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.frame =CGRectMake(0, 0, SCREEN_WIDTH, W(200));
        _backView.isClickValid = false;
        [_backView timerStart];
    }
    return _backView;
}
- (UIImageView *)searchImg
{
    if (_searchImg == nil) {
        _searchImg = [UIImageView  new];
        _searchImg.widthHeight = XY(W(14), W(14));
        _searchImg.image = [UIImage imageNamed:@"搜索-放大镜"];
    }
    return  _searchImg;
}

- (UILabel *)searchTitle
{
    if (_searchTitle == nil) {
        _searchTitle = [UILabel  new];
        _searchTitle.textColor = UIColorFromHexRGB(@"#707070");
        _searchTitle.fontNum = F(14);
    }
    return  _searchTitle;
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 3:
        {
            [GB_Nav pushVCName:@"SearchSkillsVC" animated:true];
        }
            break;
            break;
        default:
            break;
    }
}

#pragma mark - 刷新View
- (void)resetViewWithTitle:(NSString *)searchTitle
{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.searchBtn.widthHeight = XY(SCREEN_WIDTH-W(30), W(30));
    self.searchBtn.leftTop = XY(W(15), W(10));
    
    [GlobalMethod resetLabel:self.searchTitle text:UnPackStr(searchTitle) widthLimit:0];
    self.searchTitle.centerXCenterY = XY(self.searchBtn.width/2, self.searchBtn.height/2);
    
    self.searchImg.rightCenterY = XY(self.searchTitle.left-W(8), self.searchTitle.centerY);

    [self.backView resetWithImageAry:@[@"zy_1",@"zy_2",@"zy_3",@"zy_4"]];
    self.backView.leftTop = XY(0,W(10)+self.searchBtn.bottom);
    
    self.height = self.backView.bottom+W(15);
}
#pragma mark 销毁
- (void)dealloc{
    [self.backView timerStop];
}
@end







#import "LHPBtn.h"
@implementation ProductMarketSecHeaderView

#pragma mark 刷新view
- (void)resetViewWithArray:(NSArray *)array imgArr:(NSArray *)imgArr{
    [self removeAllSubViews];
    CGFloat left = W(15);
    CGFloat top = 0;
    CGFloat w = W(70);
    CGFloat h = W(60);
    for (int i = 0; i <  array.count; i++) {
        LHPBtn *btn = [LHPBtn buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(left, top, w, h);
        [btn setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:(UIControlStateNormal)];
        [btn setTitleColor:COLOR_LABEL forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(10);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArr[i]]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
        left = btn.right + W(20);
        if (i == 3) {
                left = W(15);
                top = btn.bottom + W(5);
            }
        self.height = btn.bottom;
    }
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
            [GB_Nav pushVCName:@"ContentResourcesListVC" animated:true];
        }
            break;
            
        default:
            break;
    }
}
@end







