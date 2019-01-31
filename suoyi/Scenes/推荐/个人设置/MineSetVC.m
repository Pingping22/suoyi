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
//vc
#import "AutomaticWatchVC.h"
@interface MineSetVC ()
@property (nonatomic, strong) MineSetHeaderView * headerView;
@property (nonatomic, strong) ModelBaseData * modelB;
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
    //cell
     [self.tableView registerClass:[MineSetCell class] forCellReuseIdentifier:@"MineSetCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self creatDataSource];
}
- (void)creatDataSource{
    [self.aryDatas removeAllObjects];
    WEAKSELF
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"dianhua";
        model.string = @"拨号盘";
        model.hidelineState = true;
        model.hideSubState = true;
        model.blocClick = ^(ModelBaseData *modelData) {
            [weakSelf jumpToEditVC:@"LHPDialListVC"];
        };
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = 1;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"shuidi2";
        model.string = @"3G/4G省流量模式";
        model.hideSubState = true;
        model.hideState = true;
        model.blocClick = ^(ModelBaseData *modelData) {
        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"kanguo";
        model.string = @"自动观看";
        model.subString = @"一直开启";
        model.hideSubState = true;
        model.hidelineState = true;
        model.blocClick = ^(ModelBaseData *modelData) {
            AutomaticWatchVC *vc = [AutomaticWatchVC new];
            vc.blockModel = ^(ModelBaseData * model11) {
                weakSelf.modelB = model11;
            };
            [GB_Nav pushViewController:vc animated:true];
        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = 1;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"duanlashuoming";
        model.string = @"使用说明";
        model.hideSubState = true;
        model.blocClick = ^(ModelBaseData *modelData) {

        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"shequ";
        model.string = @"社区";
        model.hideSubState = true;
        model.blocClick = ^(ModelBaseData *modelData) {

        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"yifankui";
        model.string = @"问题反馈";
        model.hideSubState = true;
        model.blocClick = ^(ModelBaseData *modelData) {
            [weakSelf jumpToEditVC:@"LDFeedbackController"];
        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"guanyu";
        model.string = @"关于";
        model.hideSubState = true;
        model.hidelineState = true;
        model.blocClick = ^(ModelBaseData *modelData) {

        };
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = 1;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"tongzhi";
        model.string = @"通知";
        model.hideSubState = true;
        model.hidelineState = true;
        model.blocClick = ^(ModelBaseData *modelData) {

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
    if (model.enumType == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell.contentView removeAllSubViews];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = COLOR_BACKGROUND;
        return cell;
    }
    MineSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetCell" forIndexPath:indexPath];
    [cell resetCellWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBaseData *model =self.aryDatas[indexPath.row];
    if (model.enumType == 1) {
        return W(10);
    }
    static MineSetCell *cell = nil;
    if (!cell) {
        cell=[[MineSetCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MineSetCell"];
    }
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell.height;
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
        [_addBtn setImage:[UIImage imageNamed:@"jiahao"] forState:(UIControlStateNormal)];
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
        case 2:
        {
            [GB_Nav pushVCName:@"QRCoderVC" animated:true];
        }
            break;
        default:
            break;
    }
}

@end








@implementation MineSetCell
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
- (UIImageView *)iconImgView{
    if (_iconImgView == nil) {
        _iconImgView = [UIImageView new];
        _iconImgView.widthHeight = XY(W(30),W(30));
    }
    return _iconImgView;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.widthHeight = XY(W(7),W(13));
        _imgView.image = [UIImage imageNamed:@"12"];
    }
    return _imgView;
}
- (UIImageView *)rightImg{
    if (_rightImg == nil) {
        _rightImg = [UIImageView new];
        _rightImg.image = [UIImage imageNamed:@"txl_jtr"];
        _rightImg.widthHeight = XY(W(7),W(13));
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
-(UIButton *)openSwitch{
    if (_openSwitch == nil) {
        _openSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
        _openSwitch.tag = 1;
        [_openSwitch addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_openSwitch setImage:[UIImage imageNamed:@"guan"] forState:(UIControlStateNormal)];
        [_openSwitch setImage:[UIImage imageNamed:@"kai"] forState:(UIControlStateSelected)];
        _openSwitch.widthHeight = XY(W(70),W(50));
    }
    return _openSwitch;
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
        [self.contentView addSubview:self.iconImgView];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.openSwitch];
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
    self.iconImgView.image = [UIImage imageNamed:UnPackStr(model.imageName)];
    self.iconImgView.leftTop = XY(W(15),W(15));
    
    [self.labelTitle fitTitle:UnPackStr(model.string) variable:0];
    self.labelTitle.leftCenterY = XY(W(10)+self.iconImgView.right,self.iconImgView.centerY);
    
    
    self.rightImg.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelTitle.centerY);
    self.rightImg.hidden = model.hideState==true;
    
    self.imgView.rightCenterY = XY(self.rightImg.left-W(10),self.labelTitle.centerY);
    self.imgView.hidden = model.hideSubState==true;
    
    [self.labelDetail fitTitle:UnPackStr(model.subString) variable:model.hideSubState==true?self.rightImg.left - self.labelTitle.right - W(20):self.imgView.left-self.labelTitle.right-W(20)];
    if(model.hideSubState == true){
        self.labelDetail.rightCenterY = XY(self.rightImg.left -W(10),self.labelTitle.centerY);
    }else{
        self.labelDetail.rightCenterY = XY(self.imgView.left-W(10),self.labelTitle.centerY);
    }
    
    if (model.hideState) {
        self.openSwitch.rightCenterY = XY(SCREEN_WIDTH,self.labelTitle.centerY);

    }else{
        self.openSwitch.hidden = true;
    }
    
    
    //设置总高度
    self.height = self.iconImgView.bottom+W(15);
    
    //line
    self.lineView.widthHeight = XY(SCREEN_WIDTH, 1);
    self.lineView.leftBottom = XY(0,self.height - 1);
    self.lineView.hidden = model.hidelineState;
}

#pragma mark cell click
- (void)cellClick{
    if (self.model.blocClick) {
        self.model.blocClick(self.model);
    }
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            self.model.btnState = !self.model.btnState;
            self.openSwitch.selected = !self.openSwitch.selected;
            
        }
            break;
            
        default:
            break;
    }
}
@end
