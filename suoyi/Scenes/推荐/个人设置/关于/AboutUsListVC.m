//
//  AboutUsListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/2/13.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "AboutUsListVC.h"

@interface AboutUsListVC ()
@property (nonatomic, strong) AboutUsListHeaderView * headerView;
@property (nonatomic, strong) AboutUsListFooterView * footerView;
@property (nonatomic, strong) ServiceTelAlertView * telAlertView;
@end

@implementation AboutUsListVC
- (AboutUsListHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [AboutUsListHeaderView new];
    }
    return  _headerView;
}
- (AboutUsListFooterView *)footerView
{
    if (_footerView == nil) {
        _footerView = [AboutUsListFooterView new];
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _footerView.height);
        _footerView.bottom = SCREEN_HEIGHT;
    }
    return  _footerView;
}
- (ServiceTelAlertView *)telAlertView
{
    if (_telAlertView == nil) {
        _telAlertView = [ServiceTelAlertView new];
        _telAlertView.frame = CGRectMake(W(0), W(0), SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return  _telAlertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:[BaseNavView initNavBackTitle:@"关于" rightView:nil]];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.footerView];
    //cell
     [self.tableView registerClass:[AboutUsListCell class] forCellReuseIdentifier:@"AboutUsListCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [self creatDataSource];

}
- (void)creatDataSource{
    [self.aryDatas removeAllObjects];
    WEAKSELF
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"版本号";
        model.subString = @"1.12.0.539";
        model.hideState = true;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"去评分";
        model.hideSubState = true;
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"常见问题";
        model.hideSubState = true;
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"客服电话";
        model.hideSubState = true;
        model.blocClick = ^(ModelBaseData *modelb) {
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.telAlertView];
        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = 2;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"邀请好友下载";
        model.hideSubState = true;
        model.blocClick = ^(ModelBaseData *modelb) {
            [GB_Nav pushVCName:@"InviteFriendsVC" animated:true];
        };
        return  model;
    }()]];
    
    [self.tableView reloadData];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBaseData *model =self.aryDatas[indexPath.row];
    if (model.enumType == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell.contentView removeAllSubViews];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = COLOR_BACKGROUND;
        return cell;
    }
    AboutUsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AboutUsListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBaseData *model =self.aryDatas[indexPath.row];
    if (model.enumType == 2) {
        return W(10);
    }
    static AboutUsListCell *cell = nil;
    if (!cell) {
        cell=[[AboutUsListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"AboutUsListCell"];
    }
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell.height;
}


@end





@implementation AboutUsListHeaderView
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"12"];
        _iconImg.widthHeight = XY(W(40),W(40));
    }
    return _iconImg;
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
    [self addSubview:self.iconImg];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.iconImg.centerXTop = XY(SCREEN_WIDTH/2,W(15));
    
    self.height = self.iconImg.bottom+W(20);
}

@end






@implementation AboutUsListCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_LABEL;
        _labelTitle.fontNum = F(15);
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UILabel *)labelDetail{
    if (_labelDetail == nil) {
        _labelDetail = [UILabel new];
        _labelDetail.textColor = COLOR_DETAIL;
        _labelDetail.fontNum = F(15);
        _labelDetail.numberOfLines = 1;
        _labelDetail.lineSpace = 0;
    }
    return _labelDetail;
}
- (UIImageView *)rightImg{
    if (_rightImg == nil) {
        _rightImg = [UIImageView new];
        _rightImg.image = [UIImage imageNamed:@"txl_jtr"];
        _rightImg.widthHeight = XY(W(7),W(12));
    }
    return _rightImg;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = COLOR_LINE;
    }
    return _lineView;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelDetail];
        [self.contentView addSubview:self.rightImg];
        [self.contentView addSubview:self.lineView];
        [self.contentView addTarget:self action:@selector(cellClick)];
        self.clipsToBounds = true;
        self.contentView.userInteractionEnabled = true;
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:UnPackStr(model.string) variable:0];
    self.labelTitle.leftTop = XY(W(15),W(15));
    
    self.rightImg.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelTitle.centerY);
    self.rightImg.hidden = model.hideState;
    
    [self.labelDetail fitTitle:UnPackStr(model.subString) variable:SCREEN_WIDTH - self.labelTitle.right - W(20)];
    self.labelDetail.rightCenterY = XY(SCREEN_WIDTH -W(15),self.labelTitle.centerY);
    self.labelDetail.hidden = model.hideSubState;

    //设置总高度
    self.height = self.labelTitle.bottom+W(15);
    
    //line
    self.lineView.widthHeight = XY(SCREEN_WIDTH-W(30), 1);
    self.lineView.leftBottom = XY(W(15),self.height - 1);
    self.lineView.hidden = model.hidelineState;
}

#pragma mark cell click
- (void)cellClick{
    if (self.model.blocClick) {
        self.model.blocClick(self.model);
    }
}

@end








@implementation AboutUsListFooterView
#pragma mark 懒加载
-(UIButton *)webLabel{
    if (_webLabel == nil) {
        _webLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        _webLabel.tag = 1;
        [_webLabel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _webLabel.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        [_webLabel setTitle:@"所依官方网站" forState:(UIControlStateNormal)];
        [_webLabel setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [_webLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _webLabel;
}
-(UIButton *)agreeLabel{
    if (_agreeLabel == nil) {
        _agreeLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeLabel.tag = 2;
        [_agreeLabel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _agreeLabel.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        [_agreeLabel setTitle:@"所依隐私协议" forState:(UIControlStateNormal)];
        [_agreeLabel setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [_agreeLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    return _agreeLabel;
}
-(UIButton *)personLabel{
    if (_personLabel == nil) {
        _personLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        _personLabel.tag = 3;
        [_personLabel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _personLabel.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        [_personLabel setTitle:@"所依用户协议" forState:(UIControlStateNormal)];
        [_personLabel setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [_personLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _personLabel;
}
-(UIButton *)privacyLabel{
    if (_privacyLabel == nil) {
        _privacyLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        _privacyLabel.tag = 4;
        [_privacyLabel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _privacyLabel.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        [_privacyLabel setTitle:@"所依隐私政策" forState:(UIControlStateNormal)];
        [_privacyLabel setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [_privacyLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    return _privacyLabel;
}
- (UILabel *)labelCom{
    if (_labelCom == nil) {
        _labelCom = [UILabel new];
        [GlobalMethod setLabel:_labelCom widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_DETAIL text:@""];
        _labelCom.textAlignment = NSTextAlignmentCenter;
    }
    return _labelCom;
}
- (UIView *)lineView1{
    if (_lineView1 == nil) {
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = [UIColor orangeColor];
    }
    return _lineView1;
}
- (UIView *)lineView2{
    if (_lineView2 == nil) {
        _lineView2 = [UIView new];
        _lineView2.backgroundColor = [UIColor orangeColor];
    }
    return _lineView2;
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
    [self addSubview:self.webLabel];
    [self addSubview:self.agreeLabel];
    [self addSubview:self.personLabel];
    [self addSubview:self.privacyLabel];
    [self addSubview:self.labelCom];
    [self addSubview:self.lineView1];
    [self addSubview:self.lineView2];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.lineView1.widthHeight = XY(1, W(15));
    self.lineView1.centerXTop = XY(SCREEN_WIDTH/2,W(18));
    
    self.webLabel.widthHeight = XY(W(200), W(20));
    self.webLabel.rightTop = XY(self.lineView1.left-W(15),W(15));
    
    self.agreeLabel.widthHeight = XY(W(200), W(20));
    self.agreeLabel.leftTop = XY(self.lineView1.right+W(15),W(15));
    
    self.lineView2.widthHeight = XY(1, W(15));
    self.lineView2.centerXTop = XY(SCREEN_WIDTH/2,W(13)+self.lineView1.bottom);

    self.personLabel.widthHeight = XY(W(200), W(20));
    self.personLabel.rightTop = XY(self.lineView2.left-W(15),W(10)+self.lineView1.bottom);
    
    self.privacyLabel.widthHeight = XY(W(200), W(20));
    self.privacyLabel.leftTop = XY(W(15)+self.lineView2.right,self.personLabel.top);
    
    [GlobalMethod resetLabel:self.labelCom text:@"Copyright ©2108 山东蓝创科技有限公司\nALL rights reserved" widthLimit:0];
    self.labelCom.centerXTop = XY(SCREEN_WIDTH/2,self.lineView2.bottom+W(10));
    
    self.height = self.labelCom.bottom+W(5);
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







@implementation ServiceTelAlertView
#pragma mark 懒加载
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_backView color:[UIColor whiteColor] numRound:5 width:0];
    }
    return _backView;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_DETAIL text:@""];
    }
    return _labelTitle;
}
-(UIButton *)telBtn{
    if (_telBtn == nil) {
        _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _telBtn.tag = 1;
        [_telBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _telBtn.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_telBtn setTitle:@"呼叫400-808-1111" forState:(UIControlStateNormal)];
        [_telBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        _telBtn.widthHeight = XY(SCREEN_WIDTH - W(10),W(40));
    }
    return _telBtn;
}
-(UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.tag = 2;
        [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [GlobalMethod setRoundView:_cancelBtn color:[UIColor clearColor] numRound:5 width:0];
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        _cancelBtn.widthHeight = XY(SCREEN_WIDTH - W(10),W(40));
        _cancelBtn.backgroundColor = [UIColor whiteColor];
    }
    return _cancelBtn;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.backView];
    [self.backView addSubview:self.labelTitle];
    [self.backView addSubview:self.telBtn];
    [self addSubview:self.cancelBtn];
    [self addTarget:self action:@selector(viewClick:) forControlEvents:(UIControlEventTouchUpInside)];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self.backView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.backView.frame = CGRectMake(W(5), SCREEN_HEIGHT / 2, SCREEN_WIDTH-W(10), self.backView.height);

    [GlobalMethod resetLabel:self.labelTitle text:@"周一至周日：9:00-18:00 仅限中国地区" widthLimit:0];
    self.labelTitle.centerXTop = XY(self.backView.width/2,W(15));
    
    self.telBtn.leftTop = XY(0,W(5)+[self.backView addLineFrame:CGRectMake(0, self.labelTitle.bottom+W(15), self.backView.width, 1)]);
    
    self.cancelBtn.leftBottom = XY(W(5),SCREEN_HEIGHT);

    self.backView.height = self.telBtn.bottom+W(5);
    self.backView.bottom = self.cancelBtn.top-W(5);
    self.height = SCREEN_HEIGHT;

}
#pragma mark 点击事件
- (void)viewClick:(UIButton *)sender{
    [self removeFromSuperview];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [self gotoTelClick];
            [self removeFromSuperview];
        }
            break;
        case 2:
        {
            [self removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
}
//调用系统电话功能
-(void)gotoTelClick{
    NSString *callPhone = [NSString stringWithFormat:@"tel://400-808-1111"];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    UIApplication * application = [UIApplication sharedApplication];
    if ([application canOpenURL:[NSURL URLWithString:callPhone]]) {
        if (compare == NSOrderedAscending || compare == NSOrderedSame) {
            /// 大于等于10.0系统使用此openURL方法
            [application openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [application openURL:[NSURL URLWithString:callPhone]];
        }
    }
}
@end
