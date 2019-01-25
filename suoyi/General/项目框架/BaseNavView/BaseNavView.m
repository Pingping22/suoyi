//
//  BaseNavView.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/19.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "BaseNavView.h"

@implementation BaseNavView

#pragma mark - 懒加载
- (UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:SCREEN_WIDTH - W(50) * 2 numLines:1 fontNum:F(17) textColor:[UIColor blackColor] text:@""];
    }
    return _labelTitle;
}

- (UIControl *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIControl new];
        _backBtn.tag = TAG_KEYBOARD;
        [_backBtn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
        [BaseNavView resetControl:_backBtn imageName:@"left_blue" isLeft:true];
    }
    return _backBtn;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        self.backgroundColor = [UIColor whiteColor];
//        //设置渐变色
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = self.bounds;
//        gradient.colors = [NSArray arrayWithObjects:
//                           (id)UIColorFromHexRGB(@"#f1fdfd").CGColor,
//                           (id)UIColorFromHexRGB(@"#d8eeeb").CGColor, nil];
//        [self.layer addSublayer:gradient];
    }
    return self;
}

#pragma mark - 刷新页面
+ (instancetype)initNavTitle:(NSString *)title
                    leftView:(UIView *)leftView
                   rightView:(UIView *)rigthView{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavTitle:title leftView:leftView rightView:rigthView];
    return baseNav;
}
- (void)resetNavTitle:(NSString *)title
             leftView:(UIView *)leftView
            rightView:(UIView *)rightView{
    //set title
    [self.labelTitle  fitTitle:title  variable:0];
    self.labelTitle.centerX = self.width/2.0;
    self.labelTitle.centerY = (NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT)/2.0 + STATUSBAR_HEIGHT;
    [self addSubview:self.labelTitle];
    //reset left view
    [self resetNavLeftView:leftView];
    //reset right view
    [self resetNavRightView:rightView];
    [self removeSubViewWithTag:TAG_LINE];
}
- (void)resetNavLeftView:(UIView *)leftView{
    //left view
    if (leftView != nil) {
        self.leftView = leftView;
        leftView.frame = CGRectMake(0, STATUSBAR_HEIGHT, leftView.width, NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        [self addSubview:leftView];
    }
}
- (void)resetNavRightView:(UIView *)rightView{
    //right view
    if (rightView != nil) {
        self.rightView = rightView;
        rightView.frame = CGRectMake(SCREEN_WIDTH - rightView.width, STATUSBAR_HEIGHT, rightView.width, NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        [self addSubview:rightView];
    }
}

#pragma mark - 左返回 右view
+ (instancetype)initNavBackTitle:(NSString *)title
                       rightView:(UIView *)rigthView{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavBackTitle:title rightView:rigthView];
    return baseNav;
}
- (void)resetNavBackTitle:(NSString *)title
                rightView:(UIView *)rigthView{
    [self resetNavTitle:title leftView:self.backBtn rightView:rigthView];
}

#pragma mark - 左图片 右图片
+ (instancetype)initNavTitle:(NSString *)title
               leftImageName:(NSString *)leftImageName
                   leftBlock:(void (^)())leftBlock
              rightImageName:(NSString *)rightImageName
                   righBlock:(void (^)())rightBlock{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavTitle:title leftImageName:leftImageName leftBlock:leftBlock rightImageName:rightImageName righBlock:rightBlock];
    return baseNav;
}
- (void)resetNavTitle:(NSString *)title
        leftImageName:(NSString *)leftImageName
            leftBlock:(void (^)())leftBlock
       rightImageName:(NSString *)rightImageName
            righBlock:(void (^)())rightBlock{
    UIView * leftView = nil;
    if (leftImageName != nil) {
        self.leftBlock = leftBlock;
        UIControl * con = [UIControl new];
        [BaseNavView resetControl:con imageName:leftImageName isLeft:true];
        [con addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
        leftView = con;
    }
    UIView * rightView = nil;
    if (rightImageName != nil) {
        self.rightBlock = rightBlock;
        UIControl * con = [UIControl new];
        [BaseNavView resetControl:con imageName:rightImageName isLeft:false];
        [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
        rightView = con;
    }
    [self resetNavTitle:title leftView:leftView rightView:rightView];
}

#pragma mark - 左返回 右图片
+ (instancetype)initNavBackWithTitle:(NSString *)title
                      rightImageName:(NSString *)rightImageName
                           righBlock:(void (^)())rightBlock{
    BaseNavView * baseNav = [self new];
    [baseNav resetNavBackWithTitle:title rightImageName:rightImageName righBlock:rightBlock];
    return baseNav;
}
- (void)resetNavBackWithTitle:(NSString *)title
               rightImageName:(NSString *)rightImageName
                    righBlock:(void (^)())rightBlock{
    self.rightBlock = rightBlock;
    UIControl * con = [UIControl new];
    [BaseNavView resetControl:con imageName:rightImageName isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavTitle:title leftView:self.backBtn rightView:con];
}

#pragma mark - 左返回 右文字
+ (instancetype)initNavBackTitle:(NSString *)title
                      rightTitle:(NSString *)rightTitle
                      rightBlock:(void (^)())rightBlock{
    BaseNavView * baseNav = [self new];
    [baseNav initNavBackTitle:title rightTitle:rightTitle rightBlock:rightBlock];
    return baseNav;
}
- (void)initNavBackTitle:(NSString *)title
              rightTitle:(NSString *)rightTitle
              rightBlock:(void (^)())rightBlock{
    self.rightBlock = rightBlock;
    if (!isStr(rightTitle)){
        [self resetNavTitle:title leftView:self.backBtn rightView:nil];
        return;
    }
    UIControl * con = [UIControl new];
    con.tag = TAG_KEYBOARD;
    [BaseNavView resetControl:con title:rightTitle isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavTitle:title leftView:self.backBtn rightView:con];
}

#pragma mark - 更改title
- (void)changeTitle:(NSString *)title{
    [self.labelTitle  fitTitle:title  variable:0];
    self.labelTitle.centerX = self.width/2.0;
}

#pragma mark - 更改nav right title
- (void)changeRightTitle:(NSString *)rightTitle{
    [self.rightView removeFromSuperview];
    
    UIControl * con = [UIControl new];
    con.tag = TAG_KEYBOARD;
    [BaseNavView resetControl:con title:rightTitle isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavRightView:con];
}

#pragma mark - 更改nav right image
- (void)changeRightImage:(NSString *)rightImageName{
    [self.rightView removeFromSuperview];
    UIControl * con = [UIControl new];
    [BaseNavView resetControl:con imageName:rightImageName isLeft:false];
    [con addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetNavRightView:con];
}

#pragma mark - 设置图片
+ (void)resetControl:(UIView*) control
           imageName:(NSString *) imageName
              isLeft:(BOOL)isLeft{
    control.backgroundColor = [UIColor clearColor];
    [control removeAllSubViews];
    UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    iv.backgroundColor = [UIColor clearColor];
    if (isLeft) {
        control.frame = CGRectMake(0, STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        iv.left = W(15);
    } else {
        control.frame = CGRectMake(SCREEN_WIDTH - W(100), STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        iv.right = control.width - W(15);
    }
    iv.centerY = control.height/2.0;
    [control addSubview: iv];
}

+ (void)resetControl:(UIView*) control
               title:(NSString *) title
              isLeft:(BOOL)isLeft{
    control.backgroundColor = [UIColor clearColor];
    [control removeAllSubViews];
    UILabel * label = [UILabel new];
    label.numLimit = 6;
    label.numberOfLines = 1;
    label.textColor = [UIColor orangeColor];
    label.fontNum = BASENAVVIEW_LEFT_TITLE_FONT_NUM;
    label.backgroundColor = [UIColor clearColor];
    [label fitTitle:title variable:0];
    if (isLeft) {
        control.frame = CGRectMake(0, STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        label.left = W(20);
    } else {
        control.frame = CGRectMake(SCREEN_WIDTH - W(100), STATUSBAR_HEIGHT, W(100), NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        label.right = control.width - W(20);
    }
    label.centerY = control.height/2.0;
    [control addSubview: label];
}

#pragma mark - 设置蓝色模式
- (void)restBlueStyle{
    [self removeSubViewWithTag:TAG_LINE];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.backgroundColor = COLOR_NAV_COLOR;
    [BaseNavView resetControl:self.backBtn imageName:@"left_blue" isLeft:true];
}

#pragma mark - 点击事件
- (void)btnBackClick{
    if (self.blockBack) {
        self.blockBack();
    }else{
        if (self.isNotShowEditAlert){
            [self popVC];
        }else {
            [self showEditAlert:[self fetchVC]];
        }
    }
}
- (void)popVC{
    UIViewController * vcRespond = [self fetchVC];
    if (vcRespond && [vcRespond isKindOfClass:UIViewController.class] && vcRespond.blockWillBack) {
        vcRespond.blockWillBack(vcRespond);
    }else{
        [GB_Nav popViewControllerAnimated:true];
    }
}
- (void)showEditAlert:(UIViewController *)vc{
    [[UIApplication sharedApplication].keyWindow endEditing:true];
    if (!vc || ![vc isKindOfClass:UIViewController.class]) return;
    if (vc.view.isEdited) {
        
        NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
        NSString *destructiveButtonTitle = NSLocalizedString(@"确认", nil);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认取消编辑？" message:@"返回将清除编辑的内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //NSLog(@"取消");
        }];
        UIAlertAction * destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
            [GB_Nav popViewControllerAnimated:YES];
        }];
        [alertController addAction:destructiveAction];
        [alertController addAction:cancelAction];
        [vc presentViewController:alertController animated:YES completion:nil];
        
    }else{
        [self popVC];
    }
}

- (void)btnRightClick{
    if (self.rightBlock != nil) {
        self.rightBlock();
    }
}
- (void)btnLeftClick{
    if (self.leftBlock != nil) {
        self.leftBlock();
    }
}

@end
