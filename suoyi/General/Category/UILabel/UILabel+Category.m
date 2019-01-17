//
//  UILabel+Category.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "UILabel+Category.h"

static const char lineSpaceKey = '\0';
static const char numLimitKey = '\0';

@implementation UILabel (Category)

#pragma mark - 运行时 获取line space
- (void)setLineSpace:(CGFloat)lineSpace{
    objc_setAssociatedObject(self, &lineSpaceKey, [NSNumber numberWithFloat:lineSpace], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)lineSpace{
    NSNumber * lineSpace = objc_getAssociatedObject(self, &lineSpaceKey);
    return lineSpace?[lineSpace floatValue]:0;
}
- (void)setNumLimit:(int)numLimit{
    objc_setAssociatedObject(self, &numLimitKey, [NSNumber numberWithInt:numLimit], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (int)numLimit{
    NSNumber * lineSpace = objc_getAssociatedObject(self, &numLimitKey);
    return lineSpace?[lineSpace intValue]:0;
}
- (void)setFontNum:(CGFloat)fontNum{
    self.font = [UIFont systemFontOfSize:fontNum];
}
- (CGFloat)fontNum{
    return self.font.pointSize;
}

#pragma mark - 固定宽度
- (void)fitFixed:(CGFloat)width{
    [self fitWidth:width isFixed:true];
}
- (void)fitTitle:(NSString *)title fixed:(CGFloat)width{
    self.text = title;
    [self fitFixed:width];
}

#pragma mark - 可变宽度
- (void)fitVariable:(CGFloat)width{
    [self fitWidth:width?:CGFLOAT_MAX isFixed:false];
}
- (void)fitTitle:(NSString *)title variable:(CGFloat)width{
    self.text = title;
    [self fitVariable:width];
}

/**
 根据行数改变宽高
 
 @param width 宽度
 @param isFiexed 宽度是否固定
 */
- (void)fitWidth:(CGFloat)width isFixed:(BOOL)isFiexed{
    NSString * string = self.text;
    if (!isStr(string) || !width) {
        self.widthHeight = XY(isFiexed?width:0, self.font.lineHeight);
        return;
    }
    //获取高度 会获取行高
    CGSize size = [self fetchRectWithString:string width:width];
    CGFloat num_height_return = size.height;
    
    //如果有行高 并且不是一行
    if (self.lineSpace && num_height_return > self.font.lineHeight) {
        NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:self.text];
        //段落格式
        NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.alignment = self.textAlignment;
        paragraphStyle.lineSpacing = self.lineSpace;
        [attributeString setAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:self.font} range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributeString;
    }
    //限制行数 并且超过一行
    if (self.numberOfLines != 0 && num_height_return > self.font.lineHeight) {
        CGFloat heightLines = self.numberOfLines * self.font.lineHeight + (self.numberOfLines - 1)*self.lineSpace;
        num_height_return = num_height_return >heightLines ?heightLines :num_height_return;
    }
    self.widthHeight = XY(isFiexed?width:size.width, num_height_return);
}

//计算高度的方法
- (CGSize)fetchRectWithString:(NSString *)string width:(CGFloat)width{
    //如果string 无效 返回
    if (!isStr(string)) {
        return CGSizeMake(0, 0);
    }
    CGRect frame = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.lineSpace?@{NSParagraphStyleAttributeName:[NSMutableParagraphStyle initWithLineSpace:self.lineSpace],NSFontAttributeName:self.font}:@{NSFontAttributeName:self.font} context:nil];
    //如果只有一行
    if (self.lineSpace && CGRectGetHeight(frame) == self.font.lineHeight + self.lineSpace) {
        return  CGSizeMake(CGRectGetWidth(frame), self.font.lineHeight);
    }
    return  CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
}

@end
