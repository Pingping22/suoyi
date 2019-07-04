//
//  NewFriendListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/7/4.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "NewFriendListVC.h"

@interface NewFriendListVC ()

@end

@implementation NewFriendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"新的朋友" rightView:nil]];
//cell
     [self.tableView registerClass:[NewFriendListCell class] forCellReuseIdentifier:@"NewFriendListCell"];
    [self requestList];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewFriendListCell" forIndexPath:indexPath];
    WEAKSELF
    cell.blockClick = ^(ModelNewFriendList *model) {
        [weakSelf requestAddFriendWithFuid:model.uid];
    };
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NewFriendListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)requestList{
    [RequestApi requestFriendListWithDelegate:self success:^(NSDictionary *  response, id   mark) {
        [self.aryDatas removeAllObjects];
        NSArray * aryResponse = [GlobalMethod exchangeDic:response[@"friends"] toAryWithModelName:@"ModelNewFriendList"];
        [self.aryDatas addObjectsFromArray:aryResponse];
        [self.tableView reloadData];
    } failure:^(NSString *  errorStr, id   mark) {
        
    }];
}
- (void)requestAddFriendWithFuid:(double)fuid{
    [RequestApi requestFriendAgreeWithFuid:fuid delegate:self success:^(NSDictionary *  response, id   mark) {
        [GlobalMethod showAlert:@"添加成功"];
    } failure:^(NSString *  errorStr, id   mark) {
        
    }];
}
@end




@implementation NewFriendListCell
#pragma mark 懒加载
- (UIImageView *)headerImage{
    if (_headerImage == nil) {
        _headerImage = [UIImageView new];
        _headerImage.widthHeight = XY(W(45),W(45));
        [GlobalMethod setRoundView:_headerImage color:[UIColor clearColor] numRound:_headerImage.width/2 width:0];
    }
    return _headerImage;
}
- (UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable = [UILabel new];
        [GlobalMethod setLabel:_nameLable widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _nameLable;
}
- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [UILabel new];
        [GlobalMethod setLabel:_addressLabel widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_DETAIL text:@""];
    }
    return _addressLabel;
}
-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.tag = 1;
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:F(12)];
        _addBtn.widthHeight = XY(W(40),W(20));
    }
    return _addBtn;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.headerImage];
        [self.contentView addSubview:self.nameLable];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.addBtn];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNewFriendList *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.avatar)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.headerImage.leftTop = XY(W(16),W(8));
    
    [GlobalMethod resetLabel:self.nameLable text:UnPackStr(model.nick) widthLimit:0];
    self.nameLable.leftTop = XY(W(15)+self.headerImage.right,self.headerImage.top);
    
    [GlobalMethod resetLabel:self.addressLabel text:@"请求添加你为好友" widthLimit:0];
    self.addressLabel.leftBottom = XY(self.nameLable.left,self.headerImage.bottom);
    
    if (model.type == 0) {
        [self.addBtn setTitleColor:COLOR_DETAIL forState:UIControlStateNormal];
        [self.addBtn setTitle:@"已通过" forState:(UIControlStateNormal)];
        [self.addBtn setBackgroundColor:[UIColor whiteColor]];
        self.addBtn.userInteractionEnabled = false;
    }else if (model.type == 1){
        [GlobalMethod setRoundView:self.addBtn color:[UIColor clearColor] numRound:2 width:0];
        [self.addBtn setTitle:@"接受" forState:(UIControlStateNormal)];
        self.addBtn.backgroundColor = COLOR_GREEN;
        self.addBtn.userInteractionEnabled = true;
    }
    self.addBtn.rightCenterY = XY(SCREEN_WIDTH-W(16),self.headerImage.centerY);
    
    self.height = [self.contentView addLineFrame:CGRectMake(0, self.headerImage.bottom+W(8), SCREEN_WIDTH, 1)];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            if (self.blockClick) {
                self.blockClick(self.model);
            }
        }
            break;
            
        default:
            break;
    }
}

@end
