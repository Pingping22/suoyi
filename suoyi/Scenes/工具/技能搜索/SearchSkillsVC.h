//
//  SearchSkillsVC.h
//  suoyi
//
//  Created by 王伟 on 2019/1/30.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "BaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchSkillsVC : BaseTableVC

@end

NS_ASSUME_NONNULL_END






@interface SearchSkillsBtnView : UIView
//属性
@property (strong, nonatomic) UIButton *nameBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end
