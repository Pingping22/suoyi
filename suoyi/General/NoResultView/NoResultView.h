//
//  NoResultView.h
//  乐销
//
//  Created by mengxi on 17/1/19.
//  Copyright © 2017年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoResultView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (nonatomic, strong) UIView *lineTop;//someview need top 
@property (nonatomic, strong) UIImageView *ivNoResult;//image for specific vc

//show
- (void)showInView:(UIView *)viewShow frame:(CGRect)frame;
//reset with image
- (void)resetWithImageName:(NSString *)imageName;
@end
