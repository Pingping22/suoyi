//
//  UIView+SelectImageView.h
//  lanberProject
//
//  Created by lirenbo on 2018/7/21.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import <UIKit/UIKit.h>
//选择图片
#import "ImagePickerVC.h"
#import "BaseImage.h"

@interface UIView (SelectImageView)<ImagePickerVCDelegate>

//选择图片
- (void)showImageVC:(NSInteger)imageNum;
- (void)imageSelect:(BaseImage *)image;
- (void)imagesSelect:(NSArray *)aryImages;
    
@end
