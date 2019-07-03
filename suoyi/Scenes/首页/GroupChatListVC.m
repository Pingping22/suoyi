//
//  GroupChatListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/7/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "GroupChatListVC.h"
//scroll view
#import "LinkScrollView.h"

@interface GroupChatListVC ()

@end

@implementation GroupChatListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //cell
    [self.tableView registerClass:[GroupChatListCell class] forCellReuseIdentifier:@"GroupChatListCell"];
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
    GroupChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupChatListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [GroupChatListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)requestList{
    [RequestApi requestUserGroupFetchGroupWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.aryDatas removeAllObjects];
        NSArray * aryResponse = [GlobalMethod exchangeDic:response[@"owner"] toAryWithModelName:@"ModelUserGroupOwner"];
        [self.aryDatas addObjectsFromArray:aryResponse];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
#pragma mark scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView scrollLink:(LinkScrollView *)scrollView.superview.superview.superview];
}


@end









@implementation GroupChatListCell
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"group_default"];
        _iconImg.widthHeight = XY(W(45),W(45));
    }
    return _iconImg;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(18) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        [GlobalMethod setLabel:_labelContent widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_DETAIL text:@""];
    }
    return _labelContent;
}
-(UIButton *)telBtn{
    if (_telBtn == nil) {
        _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _telBtn.tag = 1;
        [_telBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_telBtn setImage:[UIImage imageNamed:@"phone_list"] forState:(UIControlStateNormal)];
        _telBtn.widthHeight = XY(W(40),W(40));
    }
    return _telBtn;
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
        [self.contentView addSubview:self.labelContent];
        [self.contentView addSubview:self.telBtn];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelUserGroupOwner *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.gAvatar)] placeholderImage:[UIImage imageNamed:@"group_default"]];
    self.iconImg.leftTop = XY(W(16),W(12));
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.groupName) widthLimit:0];
    self.labelName.leftTop = XY(W(15)+self.iconImg.right,self.iconImg.top);
    
    [GlobalMethod resetLabel:self.labelContent text:UnPackStr(model.gNotice) widthLimit:0];
    self.labelContent.leftBottom = XY(W(15)+self.iconImg.right,self.iconImg.bottom);
    
    self.telBtn.rightCenterY = XY(SCREEN_WIDTH-W(16),self.iconImg.centerY);
    
    self.height = [self.contentView addLineFrame:CGRectMake(W(16), self.iconImg.bottom+W(12), SCREEN_WIDTH-W(16), 1)];
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
