//
//  SearchTextField.m
//  天下农商渠道版
//
//  Created by 刘惠萍 on 2017/6/23.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    return iconRect;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, W(40), 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
}


@end
