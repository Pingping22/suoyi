//
//  ToolsTabVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "ToolsTabVC.h"
#import "ToolsCell.h" //cell

@interface ToolsTabVC ()

@end

@implementation ToolsTabVC

#pragma mark - lazy


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.tableView.backgroundColor = [UIColor whiteColor];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavTitle:@"工具" leftView:nil rightView:nil]];
}

#pragma mark - requestList
- (void)requestList{
    [RequestApi requestAgriculturalProductsListWithPageNum:self.pageNum delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
        
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

#pragma mark - 修改状态栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
