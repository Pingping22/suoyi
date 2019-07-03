//
//  BtottomGreensView.h
//  乐销
//
//  Created by 隋林栋 on 2017/4/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//view category
#import "UIView+Category.h"

@interface BottomGreensView : UIView
//reset view
- (void)resetWithModels:(NSArray *)aryModelBtn target:(id)target selector:(NSString *)selector;
@end
