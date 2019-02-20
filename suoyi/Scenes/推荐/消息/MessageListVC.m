//
//  MessageListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/2/19.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "MessageListVC.h"
//cell
#import "DateCell.h"
@interface MessageListVC ()

@end

@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"你好的家" rightView:nil]];
    //cell
     [self.tableView registerClass:[MessageListCell class] forCellReuseIdentifier:@"MessageListCell"];
    [self.tableView registerClass:[DateCell class] forCellReuseIdentifier:@"DateCell"];

    [self creatDataSource];
}
- (void)creatDataSource{
    [self.aryDatas removeAllObjects];
    
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"1月21 12:21";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.enumType = ENUM_MESSAGE_JOIN;
        model.title = @"您已加入“你好的家”";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"1月22 10:21";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.enumType = ENUM_MESSAGE_IMAGE;
        model.title = @"“你好的家”拍了1张新照片";
        return  model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"1月23 14:21";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.enumType = ENUM_MESSAGE_NOTICE;
        model.title = @"小依小依，新年好！";
        return  model;
    }()]];
//    [self.aryDatas insertDateModelFromKeyPath:@"dateStr"];

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
    id model = self.aryDatas[indexPath.row];
    if ([model isKindOfClass:[ModelBaseData class]]) {
        DateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell" forIndexPath:indexPath];
        [cell resetCellWithModel:model];
        return cell;
    }
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.aryDatas[indexPath.row];
    if ([model isKindOfClass:[ModelBaseData class]]) {
        return [DateCell fetchHeight:self.aryDatas[indexPath.row]];
    }
    return [MessageListCell fetchHeight:self.aryDatas[indexPath.row]];
}


@end





@implementation MessageListCell
#pragma mark 懒加载
- (UIImageView *)noticeImg{
    if (_noticeImg == nil) {
        _noticeImg = [UIImageView new];
        _noticeImg.image = [UIImage imageNamed:@"xiaoxi"];
        _noticeImg.widthHeight = XY(W(40),W(40));
    }
    return _noticeImg;
}
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_backView color:COLOR_LINE numRound:8 width:1];
    }
    return _backView;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (UIImageView *)detailImg{
    if (_detailImg == nil) {
        _detailImg = [UIImageView new];
        _detailImg.image = [UIImage imageNamed:@"12"];
    }
    return _detailImg;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"xiangqing"];
    }
    return _imgView;
}
- (UILabel *)labelDetail{
    if (_labelDetail == nil) {
        _labelDetail = [UILabel new];
        [GlobalMethod setLabel:_labelDetail widthLimit:0 numLines:0 fontNum:F(14) textColor:[UIColor orangeColor] text:@""];
    }
    return _labelDetail;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.noticeImg];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.labelTitle];
        [self.backView addSubview:self.detailImg];
        [self.backView addSubview:self.imgView];
        [self.backView addSubview:self.labelDetail];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    [self.backView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    self.backView.widthHeight = XY(SCREEN_WIDTH-W(15)*3-W(40), W(200));
    self.backView.leftTop = XY(W(15)*2+W(40),W(10));
    
    self.noticeImg.leftBottom = XY(W(15),self.backView.bottom+W(5));

    [GlobalMethod resetLabel:self.labelTitle text:UnPackStr(model.title) widthLimit:0];
    self.labelTitle.leftTop = XY(W(15),W(10));
    
    if (model.enumType==ENUM_MESSAGE_JOIN) {
        self.detailImg.widthHeight = XY(W(50), W(50));
        [GlobalMethod setRoundView:self.detailImg color:[UIColor clearColor] numRound:self.detailImg.width/2 width:0];
    }else if (model.enumType==ENUM_MESSAGE_IMAGE){
        self.detailImg.widthHeight = XY(W(100), W(100));
    }else if (model.enumType==ENUM_MESSAGE_NOTICE){
        self.detailImg.widthHeight = XY(self.backView.width-W(30), W(150));
    }
    self.detailImg.leftTop = XY(W(15),self.labelTitle.bottom+W(10));
    
    if (model.enumType==ENUM_MESSAGE_NOTICE) {
        _imgView.widthHeight = XY(W(15),W(15));
        self.imgView.centerXTop = XY(self.backView.width/2,W(10)+[self.backView addLineFrame:CGRectMake(0, self.detailImg.bottom+W(10), self.backView.width, 1)]);
        
        [GlobalMethod resetLabel:self.labelDetail text:@"详情" widthLimit:0];
        self.labelDetail.leftCenterY = XY(W(5)+self.imgView.right,self.imgView.centerY);
        
        self.backView.height = self.imgView.bottom+W(10);
    }else{
        self.backView.height = self.detailImg.bottom+W(10);
    }
    self.noticeImg.bottom = self.backView.bottom+W(5);
    self.height = self.backView.bottom+W(10);
}

@end
