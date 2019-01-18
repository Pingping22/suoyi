//
//  RecommendSkillsView.h
//  suoyi
//
//  Created by 王伟 on 2019/1/18.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SkillsView;
@interface RecommendSkillsView : UIView
@property (nonatomic, strong) NSMutableArray * aryImage;
@property int numNow;
@property (nonatomic) int numTime;
@property (strong, nonatomic) void (^blockNum)(double allNum,double num);
@property (nonatomic, strong) SkillsView * skView;
@property (nonatomic, strong) UILabel * labelName;
- (instancetype)initWithFrame:(CGRect)frame image:(NSArray *)aryImage;
- (void)resetWithImageAry:(NSArray *)aryImage;

@end

@class ModelSkills;
@interface SkillsView : UIView
//属性
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelContent;
@property (nonatomic, strong) ModelSkills * model;
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelSkills *)model;

@end



@interface ModelSkills : NSObject
@property (nonatomic, strong) NSString * imgStr;
@property (nonatomic, strong) NSString * iconStr;
@property (nonatomic, strong) NSString * nameStr;
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, strong) NSString * contentStr;
@end



@interface TrySkillsView : UIView
//属性
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *labelName;
#pragma mark 刷新view
- (void)resetViewWithStr:(NSString *)str;

@end

