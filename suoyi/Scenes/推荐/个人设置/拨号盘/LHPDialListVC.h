//
//  LHPDialListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/28.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHPDialListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END



@protocol LHPShowNumViewDelegate <NSObject>
@optional
-(void)deleteAll;
@required
-(void)deleteOneByOne;
@end
@interface LHPShowNumView : UIView
@property (strong, nonatomic) UITextField *inputNumberLabel;
@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,assign) id <LHPShowNumViewDelegate> delegate;
@end





@interface LHPDialListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *leftImg;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelNum;
@property (strong, nonatomic) UILabel *labelTime;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;
@end
