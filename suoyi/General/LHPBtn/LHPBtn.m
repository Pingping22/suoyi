//
//  LHPBtn.m
//  suoyi
//
//  Created by 王伟 on 2019/1/17.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "LHPBtn.h"

@implementation LHPBtn

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY , titleW, titleH);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = W(20);
    CGFloat imageH = W(20);
    return CGRectMake(contentRect.size.width *0.35, 5, imageW, imageH);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


@end
