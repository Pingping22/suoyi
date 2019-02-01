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
    self.tableView.tableHeaderViews = @[self.searchView,self.btnView,self.hisView];


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
    [self.skillView resetViewWithAry:@[[ModelBtn modelWithTitle:@"我e啥说啥"],[ModelBtn modelWithTitle:@"奥都懂的"],[ModelBtn modelWithTitle:@"奥的"],[ModelBtn modelWithTitle:@"奥顶顶顶顶顶"],[ModelBtn modelWithTitle:@"奥大大"],[ModelBtn modelWithTitle:@"奥顶顶顶顶顶大大"]].mutableCopy widthLimit:SCREEN_WIDTH];
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
