//
//  SearchFriendListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/7/3.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "SearchFriendListVC.h"
//view
#import "LdSearchView.h"
//vc
#import "SearchFriendDetailVC.h"

@interface SearchFriendListVC ()
@property (nonatomic, strong) LdSearchView * searchView;

@end

@implementation SearchFriendListVC
- (LdSearchView *)searchView
{
    if (_searchView == nil) {
        _searchView = [LdSearchView new];
        _searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _searchView.height);
        WEAKSELF
        _searchView.blockDele = ^{
            weakSelf.searchView.searchTextField.text = @"";
            [weakSelf.view addKeyboardHideGesture];
            [weakSelf.aryDatas removeAllObjects];
            [weakSelf.tableView reloadData];
        };
        _searchView.blockSearch = ^(NSString *str) {
            [weakSelf searchTitle:UnPackStr(str)];
            [weakSelf.tableView reloadData];
        };
    }
    return  _searchView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"" rightView:nil]];
    //cell
    [self.tableView registerClass:[SearchFriendListCell class] forCellReuseIdentifier:@"SearchFriendListCell"];
    self.tableView.tableHeaderViews = @[self.searchView];

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
    SearchFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchFriendListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SearchFriendListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchFriendDetailVC *vc = [SearchFriendDetailVC new];
    vc.model = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
}
- (void)searchTitle:(NSString *)str{
    [RequestApi requestFriendSearchByPhoneWithPhone:UnPackStr(str) delegate:self success:^(NSDictionary * response, id  mark) {
        if ([str isEqualToString:[GlobalData sharedInstance].GB_UserModel.phone]) {
            [GlobalMethod showAlert:@"你不能添加自己到通讯录"];
            return ;
        }
        [self.aryDatas removeAllObjects];
        NSArray * aryResponse = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelFriend"];
        [self.aryDatas addObjectsFromArray:aryResponse];
        [self.tableView reloadData];
    } failure:^(NSString * errorStr, id  mark) {
        
    }];
    self.searchView.searchTextField.text = str;
    
    
}

@end





@implementation SearchFriendListCell
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"22"];
        _iconImg.widthHeight = XY(W(45),W(45));
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

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.labelName];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFriend *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.avtar)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.iconImg.leftTop = XY(W(15),W(15));
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.nick) widthLimit:0];
    self.labelName.leftCenterY = XY(W(10)+self.iconImg.right,self.iconImg.centerY);
    
    self.height = self.iconImg.bottom+W(15);
}

@end
