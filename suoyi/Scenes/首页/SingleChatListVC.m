//
//  SingleChatListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/7/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "SingleChatListVC.h"
//scroll view
#import "LinkScrollView.h"
//vc
#import "NewFriendListVC.h"

@interface SingleChatListVC ()
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation SingleChatListVC
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return  _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //cell
     [self.tableView registerClass:[SingleChatListCell class] forCellReuseIdentifier:@"SingleChatListCell"];
 [self.tableView registerClass:[SingleChatFriendCell class] forCellReuseIdentifier:@"SingleChatFriendCell"];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SingleChatFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleChatFriendCell" forIndexPath:indexPath];
        [cell resetCellWithArr:self.dataArr];
        return cell;

    }
    SingleChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleChatListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:nil];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [SingleChatFriendCell fetchHeight:self.dataArr className:nil selectorName:@"resetCellWithArr:"];
    }
    return [SingleChatListCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NewFriendListVC *vc = [NewFriendListVC new];
        WEAKSELF
        vc.blockBack = ^(UIViewController *vcvc) {
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.tableView reloadData];
        };
        [self.dataArr removeAllObjects];
        [self.tableView reloadData];
        [GB_Nav pushViewController:vc animated:true];
    }
}
#pragma mark scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView scrollLink:(LinkScrollView *)scrollView.superview.superview.superview];
}
- (void)requestList{
    [RequestApi requestFriendListWithDelegate:self success:^(NSDictionary *  response, id   mark) {
        [self.dataArr removeAllObjects];
        NSMutableArray *arr = [NSMutableArray array];
        NSArray * aryResponse = [GlobalMethod exchangeDic:response[@"friends"] toAryWithModelName:@"ModelNewFriendList"];
        [arr addObjectsFromArray:aryResponse];
        for (ModelNewFriendList *model in arr) {
            if (model.type==1) {
                [self.dataArr addObject:model];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSString *  errorStr, id   mark) {
        
    }];
}
@end



@implementation SingleChatListCell
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
- (UILabel *)labelCount
{
    if (_labelCount == nil) {
        _labelCount = [UILabel  new];
        _labelCount.textColor = [UIColor whiteColor];
        _labelCount.backgroundColor = [UIColor redColor];
    }
    return  _labelCount;
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
        [self.contentView addSubview:self.labelCount];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
//    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.iconImg.leftTop = XY(W(16),W(12));
    
    [GlobalMethod exchangeLabel:self.labelCount count:1];
    self.labelCount.rightTop = XY(self.iconImg.right, self.iconImg.top);
    
    [GlobalMethod resetLabel:self.labelName text:@"幸福一家人" widthLimit:0];
    self.labelName.leftTop = XY(W(15)+self.iconImg.right,self.iconImg.top);
    
    [GlobalMethod resetLabel:self.labelContent text:@"你已添加为好友，现在可以聊天了" widthLimit:0];
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






@implementation SingleChatFriendCell

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelCount];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithArr:(NSMutableArray *)arr{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.iconImg.image = [UIImage imageNamed:@"friendlist"];
    self.iconImg.leftTop = XY(W(16),W(12));
    
    [GlobalMethod exchangeLabel:self.labelCount count:(int)arr.count];
    self.labelCount.rightTop = XY(self.iconImg.right, self.iconImg.top);
    
    [GlobalMethod resetLabel:self.labelName text:@"新的朋友" widthLimit:0];
    self.labelName.leftCenterY = XY(W(15)+self.iconImg.right,self.iconImg.centerY);
    
    self.labelContent.hidden = true;
    self.telBtn.hidden = true;
    
    self.height = [self.contentView addLineFrame:CGRectMake(W(16), self.iconImg.bottom+W(12), SCREEN_WIDTH-W(16), 1)];
}

@end
