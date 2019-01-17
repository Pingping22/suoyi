//
//  BaseImage.m
//  乐销
//
//  Created by 隋林栋 on 2017/1/9.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BaseImage.h"

@implementation BaseImage

+ (BaseImage *)imageWithCGImage:(CGImageRef)cgImage imageAsset:(PHAsset *)asset{
    BaseImage * baseImage = [[BaseImage alloc]initWithCGImage:cgImage];
    baseImage.asset = asset;
    return baseImage;
}

@end
