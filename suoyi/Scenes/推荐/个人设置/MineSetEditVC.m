//
//  MineSetEditVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/25.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "MineSetEditVC.h"

@interface MineSetEditVC ()
@property (nonatomic, strong) MineSetEditListHeaderView *headerView;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation MineSetEditVC
#pragma mark lazy
- (MineSetEditListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [MineSetEditListHeaderView new];
        WEAKSELF
        _headerView.blockImg = ^(NSString *url) {
//            [weakSelf requestListWithUrl:url];
        };
        _headerView.urlStr = [GlobalData sharedInstance].GB_UserModel.accountIcon;
        [_headerView resetViewWithTitle:@"头像"];
    }
    return _headerView;
}
-(UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.tag = 1;
        [_submitButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.backgroundColor = [UIColor redColor];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:W(17)];
        [GlobalMethod setRoundView:_submitButton color:[UIColor clearColor] numRound:W(20) width:0];
        [_submitButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
        _submitButton.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
    }
    return _submitButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.viewBG.backgroundColor = COLOR_BACKGROUND;
    self.tableView.height = W(300);

    self.submitButton.frame = CGRectMake(W(15), self.tableView.bottom + W(20), SCREEN_WIDTH - W(30), W(40));
    [self.view addSubview:self.submitButton];
     [self.tableView registerClass:[MineSetEditListCell class] forCellReuseIdentifier:@"MineSetEditListCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self creatDataSource];

}
#pragma mark click
- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1://退出
//            [GlobalMethod logoutSuccess];
            
            break;
            
        default:
            break;
    }
}
- (void)creatDataSource{
    [self.aryDatas removeAllObjects];
    WEAKSELF
    
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"姓名";
        model.subString = @"你";
        model.enumType = ENUM_COMPANYINFOEDITLISTCELL_TITLE;
        model.blocClick = ^(ModelBaseData *modelData) {
            [weakSelf jumpToEditVC:@"MineNameVC"];
        };
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"手机号";
        model.enumType = ENUM_COMPANYINFOEDITLISTCELL_NOARROW;
        model.subString = @"15006373289";
        model.hideState = true;
        model.blocClick = ^(ModelBaseData *modelData) {
        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_COMPANYINFOEDITLISTCELL_EMPTY;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"修改密码";
        model.enumType = ENUM_COMPANYINFOEDITLISTCELL_TITLE;
        model.hideState = true;
        model.blocClick = ^(ModelBaseData *modelData) {
            [weakSelf jumpToEditVC:@"Next_ChangePasswordVC"];
        };
        return  model;
    }()]];
    
    [self.tableView reloadData];
}
- (void)jumpToEditVC:(NSString *)className{
    WEAKSELF
    BaseVC *vc = (BaseVC *)[NSClassFromString(className) new];
    vc.blockBack = ^(UIViewController *vc){
        [weakSelf creatDataSource];
    };
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"个人信息" rightView:nil]];
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
    if (model.enumType == ENUM_COMPANYINFOEDITLISTCELL_EMPTY) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell.contentView removeAllSubViews];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = COLOR_BACKGROUND;
        return cell;
    }
    MineSetEditListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetEditListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBaseData *model =self.aryDatas[indexPath.row];
    if (model.enumType == ENUM_COMPANYINFOEDITLISTCELL_EMPTY) {
        return W(10);
    }
    static MineSetEditListCell *cell = nil;
    if (!cell) {
        cell=[[MineSetEditListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MineSetEditListCell"];
    }
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell.height;
}
@end






@implementation MineSetEditListCell
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
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"txl_jtr"];
        _imgView.widthHeight = XY(W(7),W(13));
    }
    return _imgView;
}
- (UIImageView *)rightImg{
    if (_rightImg == nil) {
        _rightImg = [UIImageView new];
        _rightImg.image = [UIImage imageNamed:@"wd_ewms"];
        _rightImg.widthHeight = XY(W(15),W(15));
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
        [self.contentView addSubview:self.imgView];
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
    
    self.imgView.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelTitle.centerY);
    self.imgView.hidden = model.enumType == ENUM_COMPANYINFOEDITLISTCELL_NOARROW;
    
    self.rightImg.rightCenterY = XY(self.imgView.left-W(10),self.labelTitle.centerY);
    self.rightImg.hidden = model.enumType != ENUM_COMPANYINFOEDITLISTCELL_IMAGE;
    
    [self.labelDetail fitTitle:UnPackStr(model.subString) variable:self.imgView.left - self.labelTitle.right - W(20)];
    if(model.enumType == ENUM_COMPANYINFOEDITLISTCELL_NOARROW){
        self.labelDetail.rightCenterY = XY(SCREEN_WIDTH -W(15),self.labelTitle.centerY);
    }else{
        self.labelDetail.rightCenterY = XY(self.imgView.left-W(10),self.labelTitle.centerY);
    }
    
    //设置总高度
    self.height = self.labelTitle.bottom+W(15);
    
    //line
    self.lineView.widthHeight = XY(SCREEN_WIDTH-W(30), 1);
    self.lineView.leftBottom = XY(W(15),self.height - 1);
    self.lineView.hidden = model.hideState;
}

#pragma mark cell click
- (void)cellClick{
    if (self.model.blocClick) {
        self.model.blocClick(self.model);
    }
}
@end






@implementation MineSetEditListHeaderView
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
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.widthHeight = XY(W(40),W(40));
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        [GlobalMethod setRoundView:_iconImg color:COLOR_LINE numRound:_iconImg.width/2 width:1];
    }
    return _iconImg;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed: @"txl_jtr"];
        _imgView.widthHeight = XY(W(7),W(13));
    }
    return _imgView;
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
    [self addSubview:self.iconImg];
      [self addSubview:self.imgView];
    
    //初始化页面
    [self resetViewWithTitle:nil];
    [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.height = W(95)+W(20);
    [self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(10)) color:COLOR_BACKGROUND];
    
    [self.labelTitle fitTitle:UnPackStr(title) variable:0];
    self.labelTitle.leftCenterY = XY(W(15),self.height/2);
    
      self.imgView.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelTitle.centerY);
    
    [self.iconImg sd_setImageWithURL: self.urlStr==nil?nil:[NSURL URLWithString:self.urlStr] placeholderImage:[UIImage imageNamed:@"tjzp_cra"]];
    self.iconImg.rightCenterY = XY(self.imgView.left-W(10),self.labelTitle.centerY);
    
    [self addLineFrame:CGRectMake(0, W(105), SCREEN_WIDTH, W(10)) color:COLOR_BACKGROUND];
    
}
#pragma mark click
- (void)btnClick:(UIButton *)sender {
    [self showImageVC:1];
}
- (void)imageSelect:(BaseImage *)image{
    //case 4://头像点击
    //    [[AliClient sharedInstance] updateImageAry:@[image]  pathType:ENUM_UPIMAGE_COMPANY_HEAD
    //                                storageSuccess:nil upSuccess:nil fail:nil];
    self.iconImg.image = image;
    self.urlStr = image.imageURL;
    if (self.blockImg) {
        self.blockImg(self.urlStr);
    }
}

@end
