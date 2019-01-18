//
//  CustomTabBarController.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "HomePageVC.h" //首页
#import "RecommendTabVC.h" //推荐
#import "ToolsTabVC.h" //工具
#import "DynamicTabVC.h" //动态

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去掉分割线
    GB_Nav.navigationBar.shadowImage = [UIImage new];
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 添加子控制器
    [self setUpChildVC:[RecommendTabVC new] title:@"语音技能" image:@"icon-wd-gray" selectedImage:@"icon-wd-green"];
    [self setUpChildVC:[HomePageVC new] title:@"家庭互动" image:@"icon-sy-gray" selectedImage:@"icon-sy-green"];
    [self setUpChildVC:[ToolsTabVC new] title:@"发现更多" image:@"icon-gj-gray" selectedImage:@"icon-gj-green"];
//    [self setUpChildVC:[DynamicTabVC new] title:@"我的" image:@"icon-my-gray" selectedImage:@"icon-my-green"];
    //添加中间加号按钮（居中按钮）
    //{
        //UIViewController * vc = [ManageModuleFormVC new];
        //vc.tabBarItem.image = [[UIImage imageNamed:@"menu_tj"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 禁用图片渲染
        //vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"menu_tj"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //[vc.tabBarItem setImageInsets:UIEdgeInsetsMake(W(4),0, -W(4), 0)];
        // 设置文字的样式
        //[self addChildViewController:vc];
    //}
    
    // 设置tabbar的背景图片
    [[CustomTabBar appearance]setBackgroundColor:[UIColor whiteColor]];
    [[CustomTabBar appearance]setShadowImage:[[UIImage alloc]init]];//将TabBar上的黑线去掉
    CustomTabBar *tabBar = [[CustomTabBar alloc] init];
    // 设置代理
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    [self setupTabBar];
}

- (void)setupTabBar{
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    //[self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
}

#pragma mark - 初始化子控制器
- (void)setUpChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 禁用图片渲染
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置字体和图片的距离
    CGFloat spaceTop;
    CGFloat imageTop;
    CGFloat fontSize;
    if (SCREEN_WIDTH == 320) {
        imageTop = 0;
        fontSize = 9;
        spaceTop = -4;
    }else if (SCREEN_WIDTH == 375){
        imageTop = 0;
        fontSize = 11;
        spaceTop = -1;
    }else if (SCREEN_WIDTH == 414){
        imageTop = -1;
        fontSize = 12;
        spaceTop = -3;
    }else{
        imageTop = 0;
        spaceTop = -5;
        fontSize = 11;
    }
    
    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(imageTop,0, -imageTop, 0)];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, spaceTop)];
    
    // 设置文字的样式
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_TABBAR_UNSELECT,NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_TABBAR_SELECT ,NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} forState:UIControlStateSelected];
    
    if([UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : COLOR_LABEL}];
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    [self addChildViewController:vc];
}

- (void)viewWillLayoutSubviews
{
    CGFloat tabberHeight = TABBAR_HEIGHT;
    if (isIphoneXSERIES) {
        tabberHeight = 83;
    }else{
        if (SCREEN_WIDTH == 320){
            tabberHeight = 50;
        }else if(SCREEN_WIDTH == 375){
            tabberHeight = 52;
        }else{
            tabberHeight = 55;
        }
    }
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = tabberHeight;
    tabFrame.origin.y = self.view.frame.size.height - tabberHeight;
    self.tabBar.frame = tabFrame;
}

@end
