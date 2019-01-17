//
//  UIView+Category.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

#pragma mark - get
- (BOOL)isEdited{
    if ([self isKindOfClass:[UITextField class]]||[self isKindOfClass:[UITextView class]]) {
        UITextView * text = (UITextView *)self;
        if (self.userInteractionEnabled && isStr(text.text)) {
            if ([text.text intValue] != 1) {
                return true;
            }
        }
    }
    for (UIView * viewSub in self.subviews) {
        if (viewSub.isEdited) {
            return true;
        }
    }
    return false;
}

#pragma mark - 获取第一响应者
- (UIView *)fetchFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView fetchFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

#pragma mark - 获取获取所在vc
- (UIViewController *)fetchVC{
    UIView * view = self;
    while (view) {
        UIResponder* nextResponder = [view nextResponder];
        if (nextResponder && [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
        view = view.superview;
    }
    return nil;
}

#pragma mark - 移除全部视图
- (void)removeAllSubViews{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

#pragma mark - 增加顶部高度
- (void)addSubViewsTopHeight:(CGFloat)height{
    for (UIView * view in self.subviews) {
        view.top += height;
    }
    self.height += height;
}

#pragma mark - 移除视图，根据tag
- (void)removeSubViewWithTag:(NSInteger)tag{
    if (self == nil) return;
    NSArray * aryView = self.subviews;
    for (UIView * viewSub in aryView) {
        if (viewSub.tag == tag) {
            [viewSub removeFromSuperview];
        }
    }
}

#pragma mark - 获取子视图，根据tag
- (NSMutableArray  *)fetchSubViewsWithTag:(NSInteger)tag{
    NSMutableArray * aryReturn = [NSMutableArray array];
    for (UIView * subView in self.subviews) {
        if (subView.tag == tag) {
            [aryReturn addObject:subView];
        }
    }
    return aryReturn;
}

#pragma mark - 添加线
- (CGFloat)addLineFrame:(CGRect)rect{
    return [self addLineFrame:rect color:COLOR_LINE];
}
- (CGFloat)addLineFrame:(CGRect)rect tag:(NSInteger)tag{
    return [self addLineFrame:rect color:COLOR_LINE tag:tag];
}
- (CGFloat)addLineFrame:(CGRect)rect color:(UIColor *)color{
    return [self addLineFrame:rect color:color tag:TAG_LINE];
}
- (CGFloat)addLineFrame:(CGRect)rect color:(UIColor *)color tag:(NSInteger)tag{
    UIView * viewLine = [UIView lineWithFrame:rect color:color];
    viewLine.tag = tag;
    [self addSubview:viewLine];
    return viewLine.bottom;
}
- (CGFloat)addLineWithHeight:(CGFloat)height{
    return [self addLineFrame:CGRectMake(0, 0, self.width, height) color:COLOR_LINE];
}

#pragma mark - 获取线视图
+ (UIView *)lineWithFrame:(CGRect)rect color:(UIColor *)color{
    UIView * viewLine = [[UIView alloc]initWithFrame:rect];
    viewLine.backgroundColor = color;
    viewLine.tag = TAG_LINE;
    return viewLine;
}
+ (UIView *)lineWithHeight:(CGFloat)height{
    return [self lineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) color:COLOR_LINE];
}
+ (UIView *)lineWithHeight:(CGFloat)height backGroundColor:(UIColor *)color{
    return [self lineWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) color:color];
}

#pragma mark - 增加点击事件
/**
 @param target 目标
 @param action 点击事件
 */
- (void)addTarget:(id)target action:(SEL)action{
    if(target){
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapClick=[[UITapGestureRecognizer alloc]initWithTarget:target action:action];
        tapClick.delegate = target;
        [self addGestureRecognizer:tapClick];
    }
}

@end
