//
//  MineSetEditVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/25.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineSetEditVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END



typedef NS_ENUM(NSUInteger, ENUM_COMPANYINFOEDITLISTCELL_TYPE) {
    ENUM_COMPANYINFOEDITLISTCELL_EMPTY,
    ENUM_COMPANYINFOEDITLISTCELL_TITLE,
    ENUM_COMPANYINFOEDITLISTCELL_NOARROW,
    ENUM_COMPANYINFOEDITLISTCELL_IMAGE,
};
@interface MineSetEditListCell : UITableViewCell
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelDetail;
@property (strong, nonatomic) UIImageView *rightImg;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIView *lineView;
@property (nonatomic, strong) ModelBaseData *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;
@end




@interface MineSetEditListHeaderView : UIControl
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UIImageView *imgView;
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) void (^blockImg)(NSString *);

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title;
@end
