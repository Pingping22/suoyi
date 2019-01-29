//
//  LHPDialVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/28.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LHPNumData;
@interface LHPDialVC : UIView
@property (nonatomic, strong) void (^NumBlock)(LHPNumData *data);
@property (nonatomic,strong) LHPNumData *data;
@end

NS_ASSUME_NONNULL_END


@interface LHPNumCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *numberBtn;
@property (nonatomic,strong) LHPNumData *data;
- (void)resetCellWithModel:(LHPNumData *)model;

@end



@interface LHPNumData : NSObject
@property (nonatomic,strong) NSString *normal;
@property (nonatomic,strong) NSString *highlight;
@property (nonatomic,strong) NSString *num;
-(void)getData:(NSInteger)integer;
@end





