//
//  HomeAddressBookListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/24.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "HomeAddressBookListVC.h"

@interface HomeAddressBookListVC ()

@end

@implementation HomeAddressBookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"家庭通讯录" rightTitle:@"陪伴记录" rightBlock:^{
        
    }]];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
     [self.tableView registerClass:[HomeAddressBookListCell class] forCellReuseIdentifier:@"HomeAddressBookListCell"];
    //request
    [self requestList];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeAddressBookListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeAddressBookListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HomeAddressBookListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    [view removeSubViewWithTag:TAG_LINE];//移除线
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, W(100));
    view.backgroundColor = [UIColor clearColor];
    UILabel*labelName = [UILabel new];
    [GlobalMethod setLabel:labelName widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_DETAIL text:@""];
    [GlobalMethod resetLabel:labelName text:@"家庭圈" widthLimit:0];
    labelName.leftTop = XY(W(10),W(15));
    [view addSubview:labelName];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return W(40);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [GB_Nav pushVCName:@"HomeAddressBookDetailVC" animated:true];
}
#pragma mark - request
- (void)requestList{
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"你好的家";
        model.subString = @"本机";
        model.alertString = @"视频号码：606895";
        model.hideState = true;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"你好";
        model.string = @"管理员";
        model.hideSubState = true;
        model.hideState = false;
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.imageName = @"你";
        model.subString = @"我";
        model.hideSubState = true;
        model.hideState = true;
        return model;
    }()]];
}
@end






@implementation HomeAddressBookListCell
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"22"];
        _iconImg.widthHeight = XY(W(40),W(40));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
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
- (UILabel *)labelType{
    if (_labelType == nil) {
        _labelType = [UILabel new];
        [GlobalMethod setLabel:_labelType widthLimit:0 numLines:0 fontNum:F(12) textColor:[UIColor whiteColor] text:@""];
        _labelType.backgroundColor = [UIColor blackColor];
        [GlobalMethod setRoundView:_labelType color:COLOR_DETAIL numRound:3 width:0];
    }
    return _labelType;
}
- (UILabel *)labelEquipment{
    if (_labelEquipment == nil) {
        _labelEquipment = [UILabel new];
        [GlobalMethod setLabel:_labelEquipment widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_DETAIL text:@""];
        [GlobalMethod setRoundView:_labelEquipment color:COLOR_DETAIL numRound:3 width:1];

    }
    return _labelEquipment;
}
- (UILabel *)labelNum{
    if (_labelNum == nil) {
        _labelNum = [UILabel new];
        [GlobalMethod setLabel:_labelNum widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_DETAIL text:@""];
    }
    return _labelNum;
}
- (UIImageView *)videoImg{
    if (_videoImg == nil) {
        _videoImg = [UIImageView new];
        _videoImg.image = [UIImage imageNamed:@"shexiangtou"];
        _videoImg.widthHeight = XY(W(30),W(30));
    }
    return _videoImg;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelType];
        [self.contentView addSubview:self.labelEquipment];
        [self.contentView addSubview:self.labelNum];
        [self.contentView addSubview:self.videoImg];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    self.iconImg.leftTop = XY(W(15),W(15));
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.imageName) widthLimit:0];
    if (model.hideSubState) {//无视频号码的时候
        self.labelName.leftCenterY = XY(W(15)+self.iconImg.right,self.iconImg.centerY);
    }else{
        self.labelName.leftTop = XY(W(15)+self.iconImg.right,self.iconImg.top+W(2));
    }
    
    [GlobalMethod resetLabel:self.labelType text:UnPackStr(model.string) widthLimit:0];
    self.labelType.leftCenterY = XY(W(10)+self.labelName.right,self.labelName.centerY);
    self.labelType.hidden = model.hideState==true;
    
    [GlobalMethod resetLabel:self.labelEquipment text:UnPackStr(model.subString) widthLimit:0];
    self.labelEquipment.leftCenterY = XY(W(10)+self.labelName.right,self.labelName.centerY);
    self.labelEquipment.hidden = !model.hideState==true;
    
    [GlobalMethod resetLabel:self.labelNum text:UnPackStr(model.alertString) widthLimit:0];
    self.labelNum.leftTop = XY(W(15)+self.iconImg.right,self.labelName.bottom+W(8));
    self.labelNum.hidden = model.hideSubState == true;
    
    self.videoImg.rightCenterY = XY(SCREEN_WIDTH-W(15),self.iconImg.centerY);
    
    self.height = [self.contentView addLineFrame:CGRectMake(W(15), self.iconImg.bottom+W(15), SCREEN_WIDTH-W(15), 1)];
}

@end
