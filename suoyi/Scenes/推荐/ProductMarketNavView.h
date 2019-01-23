//
//  ProductMarketNavView.h
//  suoyi
//
//  Created by 王伟 on 2019/1/23.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductMarketNavView : UIView
//属性
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelRed;
@property (nonatomic, strong) UIView      * lineView;

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)searchTitle;
@end
