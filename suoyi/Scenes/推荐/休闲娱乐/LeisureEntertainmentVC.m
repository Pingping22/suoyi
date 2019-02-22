//
//  LeisureEntertainmentVC.m
//  suoyi
//
//  Created by 王伟 on 2019/2/22.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "LeisureEntertainmentVC.h"
//cell
#import "ContentResourcesListVC.h"
@interface LeisureEntertainmentVC ()

@end

@implementation LeisureEntertainmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"休闲娱乐" rightView:nil]];
    //cell
    [self.tableView registerClass:[ContentResourcesCell class] forCellReuseIdentifier:@"ContentResourcesCell"];
    
    [self requestList];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentResourcesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentResourcesCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ContentResourcesCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark - request
- (void)requestList{
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"对联大全";
        model.subString = @"“打开对联大全”";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"雨林深处";
        model.subString = @"“打开雨林深处”";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"新年说啥好";
        model.subString = @"“打开新年说啥好”";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"音乐咖啡厅";
        model.subString = @"“打开音乐咖啡厅”";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"足球知识";
        model.subString = @"“打开足球知识”";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"每日图片";
        model.subString = @"“打开每日图片”";
        return model;
    }()]];
}


@end
