//
//  GroupChatListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/7/2.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "GroupChatListVC.h"
//scroll view
#import "LinkScrollView.h"
@interface GroupChatListVC ()

@end

@implementation GroupChatListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView scrollLink:(LinkScrollView *)scrollView.superview.superview.superview];
}


@end
