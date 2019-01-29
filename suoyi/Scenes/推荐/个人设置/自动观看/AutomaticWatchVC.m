//
//  AutomaticWatchVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/29.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "AutomaticWatchVC.h"

@interface AutomaticWatchVC ()

@end

@implementation AutomaticWatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"自动观看" rightView:nil]];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    //cell
     [self.tableView registerClass:[AutomaticWatchCell class] forCellReuseIdentifier:@"AutomaticWatchCell"];
    [self creatDataSource];
}
- (void)creatDataSource{
    [self.aryDatas removeAllObjects];
    [self.aryDatas addObjectsFromArray:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"一直开启";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"仅WiFi网络下开启";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"关闭";
        return model;
    }()]];
    
    [self.tableView reloadData];
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
    AutomaticWatchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutomaticWatchCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AutomaticWatchCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBaseData *model = self.aryDatas[indexPath.row];
    if (self.blockModel) {
        self.blockModel(model);
    }
    [self.tableView reloadData];
}
@end







@implementation AutomaticWatchCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
-(UIButton *)imgView{
    if (_imgView == nil) {
        _imgView = [UIButton buttonWithType:UIButtonTypeCustom];
        _imgView.tag = 1;
        [_imgView addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_imgView setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        [_imgView setImage:[UIImage imageNamed:@"duihao"] forState:(UIControlStateSelected)];
        _imgView.widthHeight = XY(W(15),W(11));
    }
    return _imgView;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    model.hideState = true;
    [GlobalMethod resetLabel:self.labelTitle text:UnPackStr(model.string) widthLimit:0];
    self.labelTitle.leftTop = XY(W(15),W(15));
    self.imgView.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelTitle.centerY);
    self.imgView.selected = model.hideState;

    self.height = [self.contentView addLineFrame:CGRectMake(W(15), self.labelTitle.bottom+W(15), SCREEN_WIDTH-W(15), 1)];
    
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            self.model.hideState = !self.model.hideState;
            self.imgView.selected = !self.imgView.selected;
            
        }
            break;
            
        default:
            break;
    }
}
@end
