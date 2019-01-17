//
//  RecommendTabVC.m
//  lanberProject
//
//  Created by runda on 2018/9/27.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "RecommendTabVC.h"
#import "ProductCell.h" //cell
#import "RetailerCell.h" //cell
#import "SliderView.h" //自定义选择器

@interface RecommendTabVC ()<SliderViewDelegate>

@property (nonatomic, strong) ProductMarketNavView * navView;
@property (nonatomic, strong) ProductMarketHeaderView * sectionHeadView;
@property (nonatomic, strong) SliderView * sliderView;
@property (nonatomic, assign) NSInteger markTag;
@property (nonatomic, strong) NSMutableArray * productAry;
@property (nonatomic, strong) NSMutableArray * retailerAry;

@end

@implementation RecommendTabVC

@synthesize tableView = _tableView;

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

- (ProductMarketHeaderView *)sectionHeadView
{
    if (_sectionHeadView == nil) {
        _sectionHeadView = [ProductMarketHeaderView  new];
        _sectionHeadView.backgroundColor = [UIColor whiteColor];
        _sectionHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _sectionHeadView.height);
        [_sectionHeadView resetViewWithTitle:@"搜索技能"];
    }
    return  _sectionHeadView;
}
- (SliderView *)sliderView
{
    if (_sliderView == nil)
    {
        _sliderView = [SliderView new];
        _sliderView.widthHeight = XY(SCREEN_WIDTH, W(40));
        _sliderView.isHasSlider = true;
        _sliderView.delegate = self;
        _sliderView.isLineVerticalHide = YES;
        _sliderView.viewSlidColor = COLOR_GREEN;
        _sliderView.viewSlidWidth = W(35);
        _sliderView.viewSlidHeight = W(3);
        NSArray * btNameArray = @[@"农资产品",@"农资店铺"];
        NSMutableArray * btnArray = [[NSMutableArray alloc]init];
        for ( int i = 0 ; i < btNameArray.count ; i ++ ){
            [btnArray addObject:[ModelBtn modelWithTitle:btNameArray[i] imageName:nil highImageName:nil tag:i color:COLOR_LABEL selectColor:COLOR_GREEN]];
        }
        //刷新-重置 控件
        [_sliderView resetWithAry:btnArray];
    }
    return _sliderView;
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
    //table
    [self.tableView registerClass:[ProductCell class] forCellReuseIdentifier:NSStringFromClass([ProductCell class])];
    [self.tableView registerClass:[RetailerCell class] forCellReuseIdentifier:NSStringFromClass([RetailerCell class])];
    self.tableView.backgroundColor = [UIColor whiteColor];
    //request
    [self requestList];
}

#pragma mark - 按钮切换
- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control
{
    self.markTag = tag;
    [self.aryDatas removeAllObjects];
    self.aryDatas = [NSMutableArray arrayWithArray:tag==0?self.productAry:self.retailerAry];
    [self.tableView reloadData];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.aryDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.markTag==0) {
        return [ProductCell fetchHeight:self.aryDatas[indexPath.row] className:nil selectorName:@"resetCellWithModel:"];
    }else{
        return [RetailerCell fetchHeight:self.aryDatas[indexPath.row] className:nil selectorName:@"resetCellWithModel:"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.markTag==0) {
        ProductCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProductCell class]) forIndexPath:indexPath];
        [cell resetCellWithModel:self.aryDatas[indexPath.row]];
        return cell;
    }else{
        RetailerCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RetailerCell class]) forIndexPath:indexPath];
        [cell resetCellWithModel:self.aryDatas[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.markTag==0) {
        [GB_Nav pushVCName:@"ProductDetailTabVC" animated:YES];
    }else{
        [GB_Nav pushVCName:@"StoreDetailTabVC" animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.sectionHeadView.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionHeadView;
}

#pragma mark - request
- (void)requestList{
    [RequestApi requestLocalDataKey:@"LocalData_ProductList" delegate:self success:^(NSDictionary *response, id mark) {
        NSArray *datas = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelProductItem"];
        [self.productAry addObjectsFromArray:datas];
        self.aryDatas = [NSMutableArray arrayWithArray:self.productAry];
        [self.tableView reloadData];
    } failure:^(NSString *errorStr, id mark) {
        
    }];
}

#pragma mark - 改变statusbar颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end






#pragma mark - 导航栏View
@implementation ProductMarketNavView
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"icon-sy-gray"];
        _iconImg.widthHeight = XY(W(20),W(20));
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
        _imgView.widthHeight = XY(W(20),W(20));
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
        _lineView.widthHeight = XY(SCREEN_WIDTH, 0.5);
    }
    return  _lineView;
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

    //初始化页面
    [self resetViewWithTitle:nil];
}

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)searchTitle{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(searchTitle) widthLimit:0];
    self.labelName.centerXCenterY = XY(SCREEN_WIDTH/2,NAVIGATIONBAR_HEIGHT/2);
    
    self.iconImg.rightCenterY = XY(self.labelName.left-W(5),NAVIGATIONBAR_HEIGHT/2);

    self.imgView.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelName.centerY);
    
    [GlobalMethod resetLabel:self.labelRed text:@"" widthLimit:0];
    self.labelRed.rightTop = XY(W(2)+self.imgView.right,self.imgView.top);
    
    self.lineView.leftBottom = XY(0, NAVIGATIONBAR_HEIGHT);
    self.height = self.lineView.bottom;
}

@end




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
    [self addSubview:self.lineView];
}

#pragma mark - 懒加载
- (UIButton *)searchBtn
{
    if (_searchBtn == nil) {
        _searchBtn = [UIButton  new];
        _searchBtn.backgroundColor = UIColorFromHexRGB(@"#F4F4F4");
        _searchBtn.tag = 3;
        [_searchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _searchBtn;
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

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [UIView  new];
        _lineView.backgroundColor = COLOR_LINE;
        _lineView.widthHeight = XY(SCREEN_WIDTH, 0.5);
    }
    return  _lineView;
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav popViewControllerAnimated:YES];
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
    self.searchBtn.widthHeight = XY(SCREEN_WIDTH-W(15), W(30));
    self.searchBtn.leftCenterY = XY(W(15), NAVIGATIONBAR_HEIGHT/2);
    self.searchBtn.layer.cornerRadius = self.searchBtn.height/2;
    self.searchBtn.layer.masksToBounds = YES;
    
    self.searchImg.centerXCenterY = XY(SCREEN_WIDTH/2, self.searchBtn.height/2);
    [self.searchTitle fitTitle:searchTitle fixed:(self.searchBtn.width-self.searchImg.right-W(20))];
    self.searchTitle.leftCenterY = XY(self.searchImg.right+W(8), self.searchImg.centerY);
    
    self.lineView.leftBottom = XY(0, NAVIGATIONBAR_HEIGHT);
    self.height = self.lineView.bottom;
}

@end
