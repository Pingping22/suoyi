//
//  ToolsTabVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//Copyright © 2018年 lirenbo. All rights reserved.
//

#import "ToolsTabVC.h"
#import "ToolsCell.h" //cell
#import "RecommendTabVC.h"

@interface ToolsTabVC ()
@property (nonatomic, strong) ProductMarketNavView * navView;

@end

@implementation ToolsTabVC

#pragma mark - lazy
- (ProductMarketNavView *)navView
{
    if (_navView == nil) {
        _navView = [ProductMarketNavView  new];
        _navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        [_navView resetViewWithTitle:@"你好的家"];
    }
    return  _navView;
}


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
    [self.view addSubview:self.navView];
}

#pragma mark - 改变statusbar颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
