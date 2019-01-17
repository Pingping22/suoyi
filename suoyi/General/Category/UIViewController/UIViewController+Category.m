//
//  UIViewController+Category.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "UIViewController+Category.h"

static const char key_blockBack_UIViewController  = '\0';
static const char key_blockWillBack_UIViewController  = '\0';
static const char key_requestState_UIViewController  = '\0';

@implementation UIViewController (Category)

#pragma mark - property
- (void)setRequestState:(int)requestState{
    objc_setAssociatedObject(self, &key_requestState_UIViewController, [NSNumber numberWithInteger:requestState], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (int)requestState{
    NSNumber * num = objc_getAssociatedObject(self, &key_requestState_UIViewController);
    if (num && [num isKindOfClass:NSNumber.class]) {
        return [num intValue];
    }
    return 0;
}

-(void)setBlockBack:(void (^)(UIViewController *))blockBack{
    objc_setAssociatedObject(self, &key_blockBack_UIViewController, blockBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(UIViewController *))blockBack{
    return objc_getAssociatedObject(self, &key_blockBack_UIViewController);
}

- (void)setBlockWillBack:(void (^)(UIViewController *))blockWillBack{
    objc_setAssociatedObject(self, &key_blockWillBack_UIViewController, blockWillBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(UIViewController *))blockWillBack{
    return objc_getAssociatedObject(self, &key_blockWillBack_UIViewController);
}

#pragma mark - 删除子VC
- (void)removeAllChildVC{
    while (self.childViewControllers.count) {
        UIViewController * childVC = self.childViewControllers.lastObject;
        [childVC.view removeFromSuperview];
        [childVC removeFromParentViewController];
    }
}

@end
