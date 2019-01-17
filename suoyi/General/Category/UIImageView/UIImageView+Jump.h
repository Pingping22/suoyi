//
//  UIImageView+Jump.h
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/11/15.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Jump)

//UIImageView赋值
- (void)sd_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(NSString *)imgName withWidth:(CGFloat)width withHeight:(CGFloat)height;

//sdweb image category
- (void)sd_setProductImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

#pragma mark - show image with modelImage
- (void)sd_setImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName;
- (void)sd_setSmallImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName;

@end
