//
//  SearchFriendDetailVC.m
//  suoyi
//
//  Created by 王伟 on 2019/7/3.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "SearchFriendDetailVC.h"

@interface SearchFriendDetailVC ()
@property (nonatomic, strong) SearchFriendDetailHeaderView * headerView;
@end

@implementation SearchFriendDetailVC
- (SearchFriendDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [SearchFriendDetailHeaderView new];
    }
    return  _headerView;
}
- (BottomGreensView *)bottomBtnView{
    if (!_bottomBtnView) {
        _bottomBtnView = [BottomGreensView new];
        [_bottomBtnView resetWithModels:_model.isFriend==1?@[[ModelBtn modelWithTitle:@"音视频通话" tag:1],[ModelBtn modelWithTitle:@"发消息" tag:2]]:@[[ModelBtn modelWithTitle:@"加好友" tag:3]] target:self selector:@"btnClick:"];
        _bottomBtnView.bottom = SCREEN_HEIGHT;
    }
    return _bottomBtnView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"个人资料" rightView:nil]];

    self.tableView.tableHeaderView = self.headerView;
    [self.headerView resetViewWithModel:self.model];
    [self.view addSubview:self.bottomBtnView];

}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 3:
        {
            [self addFriend];
        }
            break;
            
        default:
            break;
    }
}
//加好友
- (void)addFriend{
    [RequestApi requestFriendApplyWithFuid:self.model.userId delegate:self success:^(NSDictionary * response, id mark) {
        [GlobalMethod showAlert:@"申请成功"];
        [GB_Nav popMultiVC:2];
    } failure:^(NSString * errorStr, id mark) {
        
    }];
}
@end




@implementation SearchFriendDetailHeaderView
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(20) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UILabel *)labelDetail{
    if (_labelDetail == nil) {
        _labelDetail = [UILabel new];
        [GlobalMethod setLabel:_labelDetail widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_DETAIL text:@""];
    }
    return _labelDetail;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"22"];
        _iconImg.widthHeight = XY(W(60),W(60));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
    }
    return _iconImg;
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
    [self addSubview:self.labelDetail];
    [self addSubview:self.iconImg];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFriend *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.model = model;
    //刷新view
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.nick) widthLimit:0];
    self.labelName.leftTop = XY(W(16),W(26));
    
    [GlobalMethod resetLabel:self.labelDetail text:[NSString stringWithFormat:@"ID:%.f",model.userId] widthLimit:0];
    self.labelDetail.leftTop = XY(self.labelName.left,self.labelName.bottom+W(12));
    
    self.height = self.labelDetail.bottom+W(19);
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.avtar)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.iconImg.rightCenterY = XY(SCREEN_WIDTH-W(16),self.height/2);
    
}

@end
