//
//  AutomaticWatchVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/29.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AutomaticWatchVC : BaseTableVC
@property (nonatomic, strong) void (^blockModel)(ModelBaseData *model);
@property (nonatomic, strong) ModelBaseData * model;
@end

NS_ASSUME_NONNULL_END





@interface AutomaticWatchCell : UITableViewCell
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIButton *imgView;
@property (nonatomic, strong) ModelBaseData * model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;

@end
