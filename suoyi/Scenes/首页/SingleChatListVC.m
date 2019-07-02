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
@interface SingleChatListVC ()

@end

@implementation SingleChatListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView scrollLink:(LinkScrollView *)scrollView.superview.superview.superview];
}

@end
