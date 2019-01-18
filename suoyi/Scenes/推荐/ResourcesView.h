//
//  ResourcesView.h
//  suoyi
//
//  Created by 王伟 on 2019/1/18.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelResources;
@interface ResourcesView : UIView
//属性
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UIImageView *backImg;
@property (strong, nonatomic) UIImageView *topImg;
@property (strong, nonatomic) UIImageView *firImg;
@property (strong, nonatomic) UILabel *labelFir;
@property (strong, nonatomic) UIImageView *secImg;
@property (strong, nonatomic) UILabel *labelSec;
@property (nonatomic, strong) ModelResources * model;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResources *)model;
@end



@interface ModelResources : NSObject
@property (nonatomic, strong) NSString * nameStr;
@property (nonatomic, strong) NSString * backStr;
@property (nonatomic, strong) NSString * topStr;
@property (nonatomic, strong) NSString * firStr;
@property (nonatomic, strong) NSString * firLabelStr;
@property (nonatomic, strong) NSString * secStr;
@property (nonatomic, strong) NSString * secLabelStr;
@end
