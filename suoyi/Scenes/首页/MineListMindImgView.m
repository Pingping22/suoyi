//
//  MineListMindImgView.m
//  乐销
//
//  Created by 隋林栋 on 2017/10/23.
//Copyright © 2017年 ping. All rights reserved.
//

#import "MineListMindImgView.h"
//detail big image view
#import "ImageDetailBigView.h"

@interface MineListMindImgView()
@property (nonatomic, assign) CGFloat imgWidth;
@property (nonatomic, assign) CGFloat imgHeight;
@property (nonatomic, strong) UILabel *labelNum;
@end

@implementation MineListMindImgView
#pragma mark lazy init
- (NSMutableDictionary *)dicImages{
    if (!_dicImages) {
        _dicImages = [NSMutableDictionary new];
    }
    return _dicImages;
}
- (NSArray *)aryModels{
    if (!_aryModels) {
        _aryModels = [NSArray new];
    }
    return _aryModels;
}
- (UILabel *)labelNum{
    if (!_labelNum) {
        _labelNum = [UILabel new];
        _labelNum.fontNum = F(17);
        _labelNum.textColor = [UIColor whiteColor];
        _labelNum.textAlignment = NSTextAlignmentCenter;
        _labelNum.userInteractionEnabled = true;
        _labelNum.backgroundColor = [UIColor blackColor];
        _labelNum.hidden = true;
        _labelNum.numberOfLines = 0;
        _labelNum.lineSpace = 0;
    }
    return _labelNum;
}
- (UIImageView *)imageWithIndex:(NSInteger )index{
    UIImageView * iv = [self.dicImages objectForKey:[NSString stringWithFormat:@"%ld",index]];
    if (!iv) {
        iv = [UIImageView new];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        [self.dicImages setObject:iv forKey:[NSString stringWithFormat:@"%ld",index]];
        iv.tag = index;
        iv.userInteractionEnabled = true;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [iv addGestureRecognizer:tap];
    }
    return iv;
}
- (CGFloat)imgWidth{
    return (SCREEN_WIDTH - self.leftInteral * 2- self.imgSpace * 2)/3;
}
- (CGFloat)imgHeight{
    return (SCREEN_WIDTH - self.leftInteral * 2- self.imgSpace * 2)/3;
}
#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgSpace = W(6);
        self.leftInteral = W(15);
        self.topInteral = W(0);
        self.width = SCREEN_WIDTH;
        self.numLimit = 6;
    }
    return self;
}

#pragma mark 刷新view
- (void)resetViewWithArray:(NSArray *)array{
    [self resetViewWithArray:array totalNum:array.count];
}
- (void)resetViewWithArray:(NSArray *)array totalNum:(double)totalNum{
    [self removeAllSubViews];
    self.aryModels = array;
    //刷新view
    CGFloat top = self.topInteral;
    CGFloat left = self.leftInteral;
    self.height = 0;
    self.labelNum.hidden = true;
    for (int i = 0; i <  array.count; i++) {
        ModelImage *model = array[i];
        UIImageView *img = [self imageWithIndex:i];
        img.frame = CGRectMake(left, top, self.imgWidth, self.imgHeight);
        [img sd_setImageWithURL:model.url==nil?nil:[NSURL URLWithString:(i==0 && totalNum == 1)?model.url:model.url.middleImage] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        img.contentMode = UIViewContentModeScaleAspectFill;
        if (i<9) {
            [self addSubview:img];
            //show label num
            if (i == array.count-1||i==8) {
                self.labelNum.text = [NSString stringWithFormat:@"%ld%@查看全部",array.count-1,@"\n"];
                self.labelNum.widthHeight = img.widthHeight;
                [img addSubview:self.labelNum];
                self.labelNum.hidden = false;
            }
            left = img.right + self.imgSpace;
            if (totalNum == 2){
                left = img.right + self.imgSpace;
            }else if ((i+1)%3 == 0 ){
                left = self.leftInteral;
                top = img.bottom + self.imgSpace;
            }
            self.height = img.bottom + self.bottomInterval;
        }
        
    }
}

#pragma mark image Click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView * view = (UIImageView *)tap.view;
    if (view.tag==self.aryModels.count-1) {
        
        [GB_Nav pushVCName:@"FamilyAlbumVC" animated:true];
    }else if (self.aryModels.count>9) {
        if (view.tag==self.aryModels.count-2) {
            [GB_Nav pushVCName:@"FamilyAlbumVC" animated:true];
        }else{
            ImageDetailBigView * detailView = [ImageDetailBigView new];
            
            [detailView resetView:self.aryModels.tmpMuAry isEdit:false index: view.tag];
            [detailView showInView:GB_Nav.lastVC.view imageViewShow:view];
        }
    }else{
        ImageDetailBigView * detailView = [ImageDetailBigView new];
        
        [detailView resetView:self.aryModels.tmpMuAry isEdit:false index: view.tag];
        [detailView showInView:GB_Nav.lastVC.view imageViewShow:view];
    }
}

@end

