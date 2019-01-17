//
//  DynamicTabVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "DynamicTabVC.h"
#import "DynamicCell.h" //cell

@interface DynamicTabVC ()

@end

@implementation DynamicTabVC

#pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    //request
    [self requestList];
}

#pragma mark - 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavTitle:@"我的" leftView:nil rightView:nil]];
}

#pragma mark - UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    ModelBtn * model = self.aryDatas[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return W(60);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn * model = self.aryDatas[indexPath.row];
    if ([model.title isEqualToString:@"选择图片"]){
        [self.view showImageVC:1];
        return;
    }
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark - request
- (void)requestList{
    NSArray * titleAry = @[@"选择图片"];
    for (NSString * str in titleAry) {
        ModelBtn * model = [ModelBtn new];
        model.title = str;
        [self.aryDatas addObject:model];
    }
    [self.tableView reloadData];
}

@end
