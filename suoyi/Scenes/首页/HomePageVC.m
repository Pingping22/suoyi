//
//  HomePageVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "HomePageVC.h"
#import "RecommendTabVC.h"
@interface HomePageVC ()
@property (nonatomic, strong) ProductMarketNavView * navView;

@end

@implementation HomePageVC
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    self.viewBG.backgroundColor = COLOR_NAV_COLOR;
}
#pragma mark - 改变statusbar颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end
