//
//  ContentResourcesListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/2/20.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "ContentResourcesListVC.h"

@interface ContentResourcesListVC ()

@end

@implementation ContentResourcesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"内容资源" rightView:nil]];
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







@implementation ContentResourcesCell
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"12"];
        _iconImg.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:5 width:0];
    }
    return _iconImg;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        [GlobalMethod setLabel:_labelContent widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_DETAIL text:@""];
    }
    return _labelContent;
}
-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.tag = 1;
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.backgroundColor = COLOR_BACKGROUND;
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:F(12)];
        [GlobalMethod setRoundView:_addBtn color:[UIColor clearColor] numRound:5 width:0];
        [_addBtn setTitle:@"启用" forState:(UIControlStateNormal)];
        [_addBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        _addBtn.widthHeight = XY(W(50),W(30));
    }
    return _addBtn;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelContent];
        [self.contentView addSubview:self.addBtn];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    self.iconImg.leftTop = XY(W(15),W(15));
    
    [GlobalMethod resetLabel:self.labelTitle text:UnPackStr(model.string) widthLimit:0];
    self.labelTitle.leftTop = XY(W(10)+self.iconImg.right,self.iconImg.top+W(3));
    
    [GlobalMethod resetLabel:self.labelContent text:UnPackStr(model.subString) widthLimit:0];
    self.labelContent.leftTop = XY(W(10)+self.iconImg.right,self.labelTitle.bottom+W(5));
    
    self.addBtn.rightCenterY = XY(SCREEN_WIDTH-W(15),self.iconImg.centerY);
    
    self.height = self.iconImg.bottom+W(15);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            sender.selected = !sender.selected;
            if (!sender.selected) {
                [_addBtn setTitle:@"启用" forState:(UIControlStateNormal)];
                [_addBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
            }else{
                [_addBtn setTitle:@"取消" forState:(UIControlStateNormal)];
                [_addBtn setTitleColor:COLOR_DETAIL forState:(UIControlStateNormal)];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
