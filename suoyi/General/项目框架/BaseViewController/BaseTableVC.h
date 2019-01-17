//
//  BaseTableVC.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "BaseVC.h"

@interface BaseTableVC : BaseVC<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong, readonly) NSString *strCellName; //关联无数据加载
@property (nonatomic, assign) BOOL isRemoveAll;//是否移除全部
@property (nonatomic, assign) double pageNum; //分页相关
@property (nonatomic, readonly) NSString *lastRow;
@property (nonatomic, readonly) NSString *lastUpdateTime;
@property (nonatomic, readonly) id requestDelegate;
    
#pragma mark - request
- (void)requestList;

#pragma mark - 添加上拉下拉
- (void)addRefresh;
- (void)addRefreshHeader;
- (void)addRefreshFooter;

#pragma mark - refresh
- (void)refreshHeaderAll;

#pragma mark - 结束上拉下拉
- (void)endRefreshing;

@end
