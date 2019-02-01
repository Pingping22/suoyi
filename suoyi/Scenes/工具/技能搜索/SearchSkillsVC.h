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



@class SearchSkillsBtnView;
//热门搜索
@interface TopSearchView : UIView
//属性
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) SearchSkillsBtnView *skillView;
@property (nonatomic, copy) void(^tagSelectblock)(ModelBtn *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end




@class SearchSkillsBtnView;
//热门搜索
@interface HistorySearchView : UIView
//属性
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) SearchSkillsBtnView *skillView;
@property (strong, nonatomic) UIButton *deleteBtn;
@property (nonatomic, copy) void(^tagSelectblock)(ModelBtn *);
@property (nonatomic, strong) NSMutableArray * aryData;
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
@end






@interface SearchSkillsBtnView : UIView
@property (nonatomic, strong) NSMutableArray *aryModels;//ary models
@property (nonatomic, assign) NSInteger numLinesLimit;//default 0 indicate don't limit
@property (nonatomic, copy) void(^tagSelectblock)(ModelBtn *);

#pragma mark 刷新view
- (void)resetViewWithAry:(NSMutableArray *)ary widthLimit:(CGFloat)widthLimit;
@end







@interface SearchSkillsCell : UITableViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelContent;
@property (nonatomic, strong) ModelBaseData * model;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;
@end
