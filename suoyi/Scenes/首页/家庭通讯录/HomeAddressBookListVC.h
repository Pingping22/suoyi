//
//  HomeAddressBookListVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/24.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeAddressBookListVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END




@interface HomeAddressBookListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelType;
@property (strong, nonatomic) UILabel *labelEquipment;
@property (strong, nonatomic) UILabel *labelNum;
@property (strong, nonatomic) UIImageView *videoImg;
@property (nonatomic, strong) ModelBaseData * model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;
@end
