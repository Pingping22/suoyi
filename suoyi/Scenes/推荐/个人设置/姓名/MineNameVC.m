//
//  MineNameVC.m
//  乐销
//
//  Created by liuhuiping on 2017/9/23.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "MineNameVC.h"

@interface MineNameVC ()
@property (nonatomic, strong) MineNameView *headerView;

@end

@implementation MineNameVC
#pragma mark lazy
- (MineNameView *)headerView {
    if (!_headerView) {
        _headerView = [MineNameView new];
        _headerView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, _headerView.height);
        _headerView.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _headerView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.view.backgroundColor = COLOR_BACKGROUND;
    [self.tableView registerClass:MineNameView.class forCellReuseIdentifier:@"MineNameView"];
    //add keyboard observe
    [self addObserveOfKeyboard];
}
#pragma mark table delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.headerView.height;
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"姓名" rightTitle:@"保存" rightBlock:^{
        [self requestList];
    }]];
}
- (void)requestList{
//    [RequestApi requestCompileSelfWithEname:self.headerView.textField.text  delegate:self success:^(NSDictionary *response, id mark) {
//        [GlobalData sharedInstance].GB_UserModel.accountName = self.headerView.textField.text;
//        [GlobalData saveUserModel];
//        [GlobalMethod showAlert:@"修改成功"];
//        [GB_Nav popViewControllerAnimated:true];
//    } failure:^(NSString *errorStr, id mark) {
//        
//    }];
    
}
@end







@implementation MineNameView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_LABEL;
        _labelTitle.fontNum = F(15);
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.font = [UIFont systemFontOfSize:F(15)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = COLOR_LABEL;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.placeholder  = @"填写";
        //        [_textField addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _textField;
}
- (ModelBaseData *)modelData{
    if (!_modelData) {
        _modelData = [ModelBaseData new];
        _modelData.string = [GlobalData sharedInstance].GB_UserModel.introduction;
    }
    return _modelData;
}
#pragma mark 初始化c
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.textField];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:@"姓名" variable:0];
    self.labelTitle.leftTop = XY(W(15),W(15)+[self.contentView addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(10)) color:COLOR_BACKGROUND]);
    
    self.textField.text = [GlobalData sharedInstance].GB_UserModel.accountName;
    self.textField.widthHeight = XY(SCREEN_WIDTH-W(30), [GlobalMethod fetchHeightFromFont:self.textField.font.pointSize]);
    self.textField.leftTop = XY(W(15),W(15)+[self.contentView addLineFrame:CGRectMake(W(15), self.labelTitle.bottom+W(15), SCREEN_WIDTH-W(15), 1)]);
    
    self.height = self.textField.bottom + W(15);

    
}

@end







