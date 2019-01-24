//
//  FamilyAlbumVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/24.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FamilyAlbumVC : BaseVC

@end

NS_ASSUME_NONNULL_END



@interface FamilyAlbumHeaderView : UICollectionViewCell
@property (nonatomic ,copy)NSString * dateStr;
@property (nonatomic ,strong)UILabel * dateLabel;

@end
