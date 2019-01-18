//
//  RecommendSkillsView.m
//  suoyi
//
//  Created by 王伟 on 2019/1/18.
//  Copyright © 2019年 liuhuiping. All rights reserved.
//

#import "RecommendSkillsView.h"
//网络加载图片
#import <SDWebImage/UIImageView+WebCache.h>
@interface RecommendSkillsView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scView;

@end
@implementation RecommendSkillsView

- (NSMutableArray *)aryImage{
    if (!_aryImage) {
        _aryImage = [NSMutableArray new];
    }
    return _aryImage;
}
- (SkillsView *)skView
{
    if (_skView == nil) {
        _skView = [SkillsView  new];
        self.skView = [[SkillsView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), _skView.height)];
    }
    return  _skView;
}

- (UIScrollView *)scView{
    if (!_scView) {
        //添加sc
        _scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scView.delegate = self;
        _scView.pagingEnabled = YES;
        _scView.showsHorizontalScrollIndicator = NO;
        _scView.showsVerticalScrollIndicator = NO;
        _scView.backgroundColor = [UIColor clearColor];
        _scView.bounces = NO;
        _scView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.aryImage.count, 0);
    }
    return _scView;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSuview];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame image:(NSArray *)aryImage{
    self = [super initWithFrame:frame];
    if (self ) {
        [self addSuview];
        //refresh rect
        [self resetWithImageAry:aryImage];
    }
    return self;
}
- (void)addSuview{
    self.backgroundColor = [UIColor whiteColor];
    //add subview
    [self addSubview:self.labelName];
    [self addSubview:self.scView];
}

#pragma mark resetView
- (void)resetWithImageAry:(NSArray *)aryImage{
    self.aryImage = aryImage.mutableCopy;
    //reset sc
    
    [GlobalMethod resetLabel:self.labelName text:@"推荐技能" widthLimit:0];
    self.labelName.leftTop = XY(W(25),[self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(5)) color:COLOR_BACKGROUND]+W(15));
    
    self.scView.leftTop = XY(0, self.labelName.bottom);
    self.scView.widthHeight = XY(self.width, self.skView.height);
    self.scView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.aryImage.count, 0);
    
    [self resetImageAnimated:NO];
}


#pragma mark 布置图片
- (void)resetImageAnimated:(BOOL)animated{
    if (!isAry(self.aryImage))return;
    [self.scView removeAllSubViews];
    [self addView];
}

- (void)addView{
    for (int i = 0; i<self.aryImage.count; i++) {
        self.skView = [[SkillsView alloc]initWithFrame:CGRectMake(i*CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), self.skView.height)];
        [self.skView resetViewWithModel:self.aryImage[i]];
        [self.skView addTarget:self action:@selector(imageClick:)];
        [self.scView addSubview:self.skView];
    }
}


#pragma mark image click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    if (!isAry(self.aryImage)) return;
    UIImageView * iv = (UIImageView *)tap.view;
    //    if (iv && [iv isKindOfClass:[UIImageView class]]) {
    //        ImageDetailBigView * detailView = [ImageDetailBigView new];
    //        int numSec = self.numNow%self.aryImage.count;
    //        [detailView resetView:^(){
    //            NSMutableArray * aryImages = [NSMutableArray new];
    //            for (NSString * strImage in self.aryImage) {
    //                ModelImage * model = [ModelImage new];
    //                model.url = strImage;
    //                [aryImages addObject:model];
    //            }
    //            return aryImages;
    //        }() isEdit:false index: numSec];
    //        [detailView showInView:[GB_Nav.lastVC view] imageViewShow:iv];
    //    }
}

@end








@implementation SkillsView
#pragma mark 懒加载
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.widthHeight = XY(SCREEN_WIDTH-W(40),W(150));
        [GlobalMethod setRoundView:_imgView color:[UIColor clearColor] numRound:W(5) width:0];
    }
    return _imgView;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
    }
    return _iconImg;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(10) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        [GlobalMethod setLabel:_labelContent widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_LABEL text:@""];
    }
    return _labelContent;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.imgView];
    [self addSubview:self.iconImg];
    [self addSubview:self.labelName];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelContent];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelSkills *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    _imgView.image = [UIImage imageNamed:UnPackStr(model.imgStr)];
    self.imgView.leftTop = XY(W(25),W(15));
    
    _iconImg.image = [UIImage imageNamed:UnPackStr(model.iconStr)];
    self.iconImg.leftTop = XY(W(25),self.imgView.bottom+W(10));
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.nameStr) widthLimit:0];
    self.labelName.leftTop = XY(W(15)+self.iconImg.right,self.iconImg.top+W(5));
    
    [GlobalMethod resetLabel:self.labelTitle text:UnPackStr(model.titleStr) widthLimit:0];
    [self addLineFrame:CGRectMake(self.labelName.right+W(5), W(5)+self.labelName.top, 1, W(10))];
    self.labelTitle.leftCenterY = XY(self.labelName.right+W(10),self.labelName.centerY);
    
    [GlobalMethod resetLabel:self.labelContent text:UnPackStr(model.contentStr) widthLimit:0];
    self.labelContent.leftTop = XY(self.labelName.left,self.labelName.bottom+W(3));
    
    self.height = self.iconImg.bottom + W(20);
}

@end



@implementation ModelSkills

@end






@implementation TrySkillsView
#pragma mark 懒加载
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.widthHeight = XY(SCREEN_WIDTH-W(40),W(150));
        [GlobalMethod setRoundView:_imgView color:[UIColor clearColor] numRound:W(5) width:0];
    }
    return _imgView;
}

- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(17) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.imgView];
    [self addSubview:self.labelName];
    
    //初始化页面
    [self resetViewWithStr:nil];
}

#pragma mark 刷新view
- (void)resetViewWithStr:(NSString *)str{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(str) widthLimit:0];
    self.labelName.leftTop = XY(W(25),[self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(5)) color:COLOR_BACKGROUND]+W(15));
    
    _imgView.image = [UIImage imageNamed:@"zy_2"];
    self.imgView.leftTop = XY(W(25),W(15)+self.labelName.bottom);
    
    self.height = self.imgView.bottom + W(15);
}

@end
