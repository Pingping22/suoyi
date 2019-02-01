//
//  SearchSkillsVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/30.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "SearchSkillsVC.h"
//view
#import "LdSearchView.h"
@interface SearchSkillsVC ()
@property (nonatomic, strong) TopSearchView * btnView;
@property (nonatomic, strong) HistorySearchView * hisView;
@property (nonatomic, strong) LdSearchView * searchView;
@property (nonatomic, strong) NSMutableArray * aryHis;
@end

@implementation SearchSkillsVC
- (NSMutableArray *)aryHis
{
    if (_aryHis == nil) {
        _aryHis = [NSMutableArray new];
    }
    return  _aryHis;
}

- (LdSearchView *)searchView
{
    if (_searchView == nil) {
        _searchView = [LdSearchView new];
        _searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _searchView.height);
        WEAKSELF
        _searchView.blockDele = ^{
            weakSelf.searchView.searchTextField.text = @"";
            [weakSelf.view addKeyboardHideGesture];
            [weakSelf.aryDatas removeAllObjects];
            [weakSelf resetView];
            [weakSelf.tableView reloadData];
        };
        _searchView.blockSearch = ^(NSString *str) {
            ModelBtn *modelC = [ModelBtn modelWithTitle:UnPackStr(str)];
            [weakSelf.aryHis addObject:modelC];
            [weakSelf searchTitle:UnPackStr(str)];
            [weakSelf resetView];
            [weakSelf.tableView reloadData];
        };
    }
    return  _searchView;
}
- (TopSearchView *)btnView
{
    if (_btnView == nil) {
        _btnView = [TopSearchView new];
        _btnView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _btnView.height);
        WEAKSELF
        _btnView.tagSelectblock = ^(ModelBtn *model) {
            ModelBtn *modelC = [ModelBtn modelWithTitle:UnPackStr(model.title)];
            [weakSelf.aryHis addObject:modelC];
            [weakSelf searchTitle:UnPackStr(model.title)];
        };
    }
    return  _btnView;
}
- (HistorySearchView *)hisView
{
    if (_hisView == nil) {
        _hisView = [HistorySearchView new];
        _hisView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _hisView.height);
        WEAKSELF
        _hisView.tagSelectblock = ^(ModelBtn *model) {
            [weakSelf searchTitle:UnPackStr(model.title)];
        };
    }
    return  _hisView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"技能搜索" rightView:nil]];
    [self resetView];
//cell
     [self.tableView registerClass:[SearchSkillsCell class] forCellReuseIdentifier:@"SearchSkillsCell"];

}
- (void)resetView{
    if (isAry(self.aryDatas)||isStr(self.searchView.searchTextField.text)) {
        self.tableView.tableHeaderViews = @[self.searchView];
    }else{
        self.tableView.tableHeaderViews = @[self.searchView,self.btnView,self.hisView];
    }
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
    SearchSkillsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchSkillsCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SearchSkillsCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)searchTitle:(NSString *)str{
    self.searchView.searchTextField.text = str;
    // 去除数组中model重复
    for (NSInteger i = 0; i < self.aryHis.count; i++) {
        for (NSInteger j = i+1;j < self.aryHis.count; j++) {
            ModelBtn *tempModel = self.aryHis[i];
            ModelBtn *model = self.aryHis[j];
            if ([tempModel.title isEqualToString:model.title]) {
                [self.aryHis removeObject:model];
            }
        }
    }
    [self.hisView.skillView resetViewWithAry:self.aryHis widthLimit:SCREEN_WIDTH];
    [self.hisView resetViewWithModel:nil];
    self.tableView.tableHeaderViews = @[self.searchView,self.btnView,self.hisView];
    
    [self.aryDatas removeAllObjects];
    ModelBaseData *model = [ModelBaseData new];
    model.string = str;
    [self.aryDatas addObject:model];
    [self resetView];
    [self.tableView reloadData];
}

@end





@implementation TopSearchView
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (SearchSkillsBtnView *)skillView{
    if (!_skillView) {
        _skillView = [SearchSkillsBtnView new];
        WEAKSELF
        _skillView.tagSelectblock = ^(ModelBtn *modelB) {
            if (weakSelf.tagSelectblock) {
                weakSelf.tagSelectblock(modelB);
            }
        };
    }
    return _skillView;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelName];
    [self addSubview:self.skillView];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.labelName text:@"热门搜索" widthLimit:0];
    self.labelName.leftTop = XY(W(15),W(15));
    
    self.skillView.widthHeight = XY(SCREEN_WIDTH, self.skillView.height);
    self.skillView.leftTop = XY(0,self.labelName.bottom);
    [self.skillView resetViewWithAry:@[[ModelBtn modelWithTitle:@"我爱猜歌词"],[ModelBtn modelWithTitle:@"词汇乐园"],[ModelBtn modelWithTitle:@"小伴龙儿歌"],[ModelBtn modelWithTitle:@"宝宝知道"],[ModelBtn modelWithTitle:@"音乐"],[ModelBtn modelWithTitle:@"新闻"],[ModelBtn modelWithTitle:@"闹钟"],[ModelBtn modelWithTitle:@"天气"],[ModelBtn modelWithTitle:@"时间"],[ModelBtn modelWithTitle:@"百科"]].mutableCopy widthLimit:SCREEN_WIDTH];
    self.height = self.skillView.bottom;
}

@end







@implementation HistorySearchView
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (NSMutableArray *)aryData
{
    if (_aryData == nil) {
        _aryData = [NSMutableArray new];
    }
    return  _aryData;
}

- (SearchSkillsBtnView *)skillView{
    if (!_skillView) {
        _skillView = [SearchSkillsBtnView new];
    }
    WEAKSELF
    _skillView.tagSelectblock = ^(ModelBtn *modelB) {
        if (weakSelf.tagSelectblock) {
            weakSelf.tagSelectblock(modelB);
        }
    };
    return _skillView;
}
-(UIButton *)deleteBtn{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.tag = 1;
        [_deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.widthHeight = XY(W(50),W(20));
        [_deleteBtn setImage:[UIImage imageNamed:@"dele"] forState:(UIControlStateNormal)];
    }
    return _deleteBtn;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelName];
    [self addSubview:self.skillView];
    [self addSubview:self.deleteBtn];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.labelName text:@"历史搜索" widthLimit:0];
    self.labelName.leftTop = XY(W(15),W(15));
    self.labelName.hidden = !isAry(self.skillView.aryModels);

    self.skillView.widthHeight = XY(SCREEN_WIDTH, self.skillView.height);
    self.skillView.leftTop = XY(0,self.labelName.bottom);

    self.deleteBtn.rightCenterY = XY(SCREEN_WIDTH-W(15),self.labelName.centerY);
    self.deleteBtn.hidden = !isAry(self.skillView.aryModels);
    
    self.height = self.skillView.bottom;

}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [self.skillView.aryModels removeAllObjects];
            [self.skillView resetViewWithAry:nil widthLimit:SCREEN_WIDTH];
            [self resetViewWithModel:nil];
        }
            break;
            
        default:
            break;
    }
}

@end







@interface SearchSkillsBtnView ()
{
    CGFloat x ;
    CGFloat y ;
    CGFloat height ;//视图高度
    CAShapeLayer *border;
}
@end
@implementation SearchSkillsBtnView
#pragma mark lazy init
- (NSMutableArray *)aryModels{
    if (!_aryModels) {
        _aryModels = [NSMutableArray new];
    }
    return _aryModels;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithAry:(NSMutableArray *)aryModelBtns widthLimit:(CGFloat)widthLimit{
    [self removeAllSubViews];
    //重置视图坐标
    self.width = widthLimit;
    self.aryModels = aryModelBtns;
    x = W(15);//
    y = W(13);//
    height  = 0;//视图高度
    NSInteger numLines = 1;//行数
    for (int i = 0; i < aryModelBtns.count; i++) {
        ModelBtn * modelBtn =aryModelBtns[i];
        UIButton * btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
        btnItem.modelBtn = modelBtn;
        [btnItem addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnItem.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        btnItem.backgroundColor = COLOR_BACKGROUND;
        [GlobalMethod setRoundView:btnItem color:COLOR_LINE numRound:W(15) width:0];
        [btnItem setTitle:UnPackStr(modelBtn.title) forState:(UIControlStateNormal)];
        [btnItem setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        //根据计算文字的大小
        btnItem.width = [GlobalMethod fetchWidthFromButton:btnItem]+W(15);
        btnItem.height = W(30);
        if (btnItem.width + x > self.width) {
            numLines ++;
            y += btnItem.height + W(10);
            x = W(15);
        }
        if (self.numLinesLimit && numLines>self.numLinesLimit) {
            break;
        }
        btnItem.leftTop = XY(x, y);
        [self addSubview:btnItem];
        if (i != aryModelBtns.count) {
            x = btnItem.right + W(15);
        }
        height = btnItem.bottom;
    }
    self.height = height+ W(10);
}
#pragma mark - click
- (void)btnClick:(UIButton *)sender
{
    if (self.tagSelectblock) {
        self.tagSelectblock(sender.modelBtn);
    }
}

@end








@implementation SearchSkillsCell
#pragma mark 懒加载
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"22"];
        _iconImg.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:7 width:0];
    }
    return _iconImg;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        [GlobalMethod setLabel:_labelContent widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_DETAIL text:@""];
    }
    return _labelContent;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelContent];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    self.iconImg.leftTop = XY(W(15),W(15));
    
    [GlobalMethod resetLabel:self.labelName text:UnPackStr(model.string) widthLimit:0];
    self.labelName.leftTop = XY(W(10)+self.iconImg.right,self.iconImg.top+W(2));
    
    [GlobalMethod resetLabel:self.labelContent text:@"打开我爱猜歌名" widthLimit:0];
    self.labelContent.leftTop = XY(self.labelName.left,self.labelName.bottom+W(8));
    
    self.height = self.iconImg.bottom+W(15);
}

@end
