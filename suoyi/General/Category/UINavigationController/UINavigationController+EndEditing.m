//
//  UINavigationController+EndEditing.m
//  lanberProject
//
//  Created by lirenbo on 2018/7/21.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "UINavigationController+EndEditing.h"

@implementation UINavigationController (EndEditing)

#pragma mark run time
+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self,@selector(pushViewController: animated:)), class_getInstanceMethod(self,@selector(sldPushViewController: animated:)));
    method_exchangeImplementations(class_getInstanceMethod(self,@selector(popViewControllerAnimated:)), class_getInstanceMethod(self,@selector(sldPopViewControllerAnimated:)));
    method_exchangeImplementations(class_getInstanceMethod(self,@selector(popToRootViewControllerAnimated:)), class_getInstanceMethod(self,@selector(sldPopToRootViewControllerAnimated:)));
}
- (void)sldPushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.view endEditing:true];
    [self sldPushViewController:viewController animated:animated];
}
- (void)sldPopViewControllerAnimated:(BOOL)animated{
    [self.view endEditing:true];
    if ([self.viewControllers.lastObject isKindOfClass:[BaseVC class]]) {
        BaseVC * lastVC = self.viewControllers.lastObject;
        if (lastVC.blockBack) {
            lastVC.blockBack();
        }
    }
    [self sldPopViewControllerAnimated:animated];
}
- (void)sldPopToRootViewControllerAnimated:(BOOL)animated{
    [self.view endEditing:true];
    [self sldPopToRootViewControllerAnimated:animated];
}

#pragma mark - 属性
- (UIViewController *)lastVC{
    return self.viewControllers.lastObject;
}
- (UIViewController *)lastSecondVC{
    NSArray * ary = GB_Nav.viewControllers;
    if (ary.count >= 2) {
        return ary[ary.count - 2];
    }
    return self.viewControllers.lastObject;
}

#pragma mark - 方法
//根据名称跳转
- (void)pushVCName:(NSString *)strClassName animated:(BOOL)animated{
    id vc = [[NSClassFromString(strClassName) alloc]init];
    [self pushViewController:vc animated:animated];
}

//根据名称pop
- (void)popToClass:(NSString *)className{
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    for (UIViewController * vc in ary) {
        if ([vc isKindOfClass:NSClassFromString(className)]) {
            [self popToViewController:vc animated:true];
            return;
        }
    }
    [self popViewControllerAnimated:true];
}

//根据个数pop
- (void)popMultiVC:(NSInteger)num{
    NSMutableArray * ary = [NSMutableArray arrayWithArray:self.viewControllers];
    if (ary.count > 0) {
        UIViewController * vc = [ary objectAtIndex:MAX(0, ary.count - 1 - num)];
        [self popToViewController:vc animated:true];
    }
}

@end
