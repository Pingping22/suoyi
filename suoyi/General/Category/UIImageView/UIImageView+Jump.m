//
//  UIImageView+Jump.m
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/11/15.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "UIImageView+Jump.h"

@implementation UIImageView (Jump)

#pragma mark - UIImageView 赋值
- (void)sd_setImageWithUrlStr:(NSString *)urlStr placeholderImage:(NSString *)imgName withWidth:(CGFloat)width withHeight:(CGFloat)height
{
    if([urlStr rangeOfString:@"http"].location == NSNotFound){
        urlStr = [NSString stringWithFormat:@"%@%@",ImageNationURL,urlStr];
    }
    if (width > 0 || height > 0) {
        urlStr = [NSString stringWithFormat:@"%@@1e_1c_%.0lfw_%.0lfh",urlStr,width,height];
    }
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imgName]];
}

//sdweb image category
- (void)sd_setProductImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    WEAKSELF
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if (!weakSelf) {
            return;
        }
        STRONGSELF
        if (image) {
            self.image = image;
            self.contentMode = image.size.width>image.size.height?UIViewContentModeScaleAspectFill:UIViewContentModeScaleAspectFit;
        }
    }];
}

#pragma mark - show image with modelImage
- (void)sd_setImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName{
    [self sd_setImageWithModel:model placeholderImageName:placeholderName useSmaleImage:false];
}
- (void)sd_setSmallImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName{
    [self sd_setImageWithModel:model placeholderImageName:placeholderName useSmaleImage:true];
}

- (void)sd_setImageWithModel:(ModelImage *)model placeholderImageName:(NSString *)placeholderName  useSmaleImage:(BOOL)useSmallImage{
    if (isStr(model.image.imageURL)) {
        //本地图片缓存 抓取高清图片
        UIImage * imageCache = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:model.image.imageURL];
        if (imageCache) {
            self.image = imageCache;
            return;
        }
    }
    if (model.image) {
        //本地图片
        self.image = model.image;
    }else{
        //网络图片
        UIImage * imageSmallCache = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:model.url.smallImage];
        if (!imageSmallCache) {
            imageSmallCache = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:model.url.middleImage];
        }
        [self sd_setImageWithURL:[NSURL URLWithString:useSmallImage?model.url.smallImage:model.url] placeholderImage:imageSmallCache?:[UIImage imageNamed:placeholderName]];
    }
}

@end
