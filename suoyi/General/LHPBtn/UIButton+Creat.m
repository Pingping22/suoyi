//
//  UIButton+Creat.m
//  天下农商渠道版
//
//  Created by 刘惠萍 on 2017/6/21.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "UIButton+Creat.h"
//runtime
#import <objc/runtime.h>
static const char modelBtnKey = '\0';
@implementation UIButton (Creat)

#pragma mark runtime add property
- (void)setModelBtn:(ModelBtn *)modelBtn{
    objc_setAssociatedObject(self, &modelBtnKey, modelBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (ModelBtn *)modelBtn{
    return objc_getAssociatedObject(self, &modelBtnKey);
}


#pragma mark fit width
- (CGFloat)fitWidth{
    UIFont * font = self.titleLabel.font;
    NSAttributedString * attributeString = [[NSAttributedString alloc]initWithString:self.titleLabel.text attributes:@{NSFontAttributeName: font}];
    CGRect rect =[attributeString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return CGRectGetWidth(rect);
}
- (CGFloat)fitHeight{
    return self.titleLabel.font.lineHeight;
}

#pragma mark logic relate
+ (UIButton *)createBottomAddBtn{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.tag = 1;
    [addButton setImage:[UIImage imageNamed:@"dd_xj"] forState:(UIControlStateNormal)];
    addButton.widthHeight = XY(W(80),W(84));
    addButton.frame = CGRectMake(W(15), SCREEN_HEIGHT - W(145), W(80), W(84));
    addButton.rightBottom = XY(SCREEN_WIDTH - W(5), SCREEN_HEIGHT -W(45)-(SCREEN_HEIGHT == 812?34:0 ));
    return addButton;
}
@end
