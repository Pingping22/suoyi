//
//  BaseVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "BaseVC.h"
#import "BaseVC+KeyboardObserve.h" //键盘观察者

@interface BaseVC ()

@end

@implementation BaseVC

#pragma mark - lazy
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
}
- (LoadingView *)loadingView{
    if (_loadingView == nil) {
        _loadingView = [LoadingView new];
    }
    return _loadingView;
}
- (NoticeView *)noticeView{
    if (_noticeView == nil) {
        _noticeView = [NoticeView new];
    }
    return _noticeView;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
    }
    return _noResultView;
}
- (NoResultView *)noResultLoadingView{
    if (!_noResultLoadingView) {
        _noResultLoadingView = [NoResultView new];
        [_noResultLoadingView resetWithImageName:@"noresult_列表"];
    }
    return _noResultLoadingView;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //增加侧滑
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:self.viewBG atIndex:0];
}

#pragma mark - 添加键盘观察者
- (void)addObserveOfKeyboard{
    self.isKeyboardObserve = true;
}

#pragma mark - view appear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = [GlobalMethod canLeftSlide];
    if (self.isKeyboardObserve) {
        [self addKeyboardObserve];
    }
#ifdef DEBUG
    NSLog(@"current vc - %@",NSStringFromClass(self.class));
#endif
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    if (self.isKeyboardObserve) {
        [self removeKeyboardObserve];
    }
}

#pragma mark - 请求过程回调
- (void)protocolWillRequest{
    [self showNoResultLoadingView];
    [self showLoadingView];
}
- (void)showNoResultLoadingView{
    [self.noResultLoadingView removeFromSuperview];
    if(!self.isShowNoResultLoadingView)return;
    [self.noResultLoadingView showInView:self.view frame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
}
- (void)showLoadingView{
    [self.loadingView hideLoading];
    if (self.isNotShowLoadingView) {
        return;
    }
    [self.loadingView resetFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT) viewShow:self.view];
}
- (void)showNoResult{
    [self.noResultLoadingView removeFromSuperview];
    [self.noResultView removeFromSuperview];
    if(!self.isShowNoResult)return;
    [self.noResultView showInView:self.view frame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT)];
}
- (void)protocolDidRequestSuccess{
    [self.loadingView hideLoading];
}
- (void)protocolDidRequestFailure:(NSString *)errorStr{
    [self.loadingView hideLoading];
    if (self.isNotShowNoticeView) {
        return;
    }
    [GlobalMethod endEditing];
    if ([self.view isShowInScreen]) {
        [self.noticeView showNotice:errorStr time:1 frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) viewShow:[UIApplication sharedApplication].keyWindow];
    }
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:true];
    return true;
}

#pragma mark - dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - 改变statusbar颜色
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return [GlobalData sharedInstance].statusBarStyle;
//}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden{
    return [GlobalData sharedInstance].statusHidden;
}

@end
