//
//  LHPDialListVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/28.
//  Copyright © 2019 liuhuiping. All rights reserved.
//
#import "LHPDialListVC.h"
#import "Masonry.h"
#import "LHPDialVC.h"
@interface LHPDialListVC ()<LHPShowNumViewDelegate>
@property (nonatomic,strong) LHPShowNumView *numview;//显示输入的view
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) LHPDialVC * dialView;
@end

@implementation LHPDialListVC
- (LHPShowNumView *)numview
{
    if (_numview == nil) {
        _numview = [LHPShowNumView new];
        _numview.delegate = self;
        _numview.frame = CGRectMake(0, 0, SCREEN_WIDTH, W(62));
    }
    return  _numview;
}
-(UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.tag = 1;
        [_submitButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton setImage:[UIImage imageNamed:@"upset"] forState:(UIControlStateNormal)];
        _submitButton.widthHeight = XY(SCREEN_WIDTH,W(40));
        [GlobalMethod setRoundView:_submitButton color:COLOR_LINE numRound:0 width:1];
    }
    return _submitButton;
}
- (LHPDialVC *)dialView
{
    if (_dialView == nil) {
        _dialView = [LHPDialVC new];
        _dialView.frame = CGRectMake(0, SCREEN_HEIGHT-W(400), SCREEN_WIDTH, W(400));
        _dialView.backgroundColor = COLOR_BACKGROUND;
        WEAKSELF
        _dialView.NumBlock = ^(){
                    NSString *text = weakSelf.numview.inputNumberLabel.text;
                    [weakSelf.numview.inputNumberLabel setText:[text stringByAppendingString:weakSelf.dialView.data.num]];
                    [weakSelf.numview.delBtn setHidden:NO];
            
        };
    }
    return  _dialView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"拨号盘" rightView:nil]];
    self.tableView.tableHeaderView = self.numview;
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - W(60);
    self.submitButton.frame = CGRectMake(0, SCREEN_HEIGHT- W(40), SCREEN_WIDTH, W(40));
    [self.view addSubview:self.submitButton];
    //cell
     [self.tableView registerClass:[LHPDialListCell class] forCellReuseIdentifier:@"LHPDialListCell"];
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [[UIApplication sharedApplication].keyWindow addSubview:self.dialView];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHPDialListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LHPDialListCell" forIndexPath:indexPath];
    [cell resetCellWithModel:nil];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LHPDialListCell fetchHeight:nil];
}
#pragma mark  实现XMShowNumViewDelegate  删除输入的号码
-(void)deleteAll{
    [self.numview.inputNumberLabel setText:@""];
    self.numview.delBtn.hidden = YES;
}
-(void)deleteOneByOne{
    NSString *text = self.numview.inputNumberLabel.text;
    if (text.length > 0) {
        text = [text substringToIndex:text.length -1];
        [self.numview.inputNumberLabel setText:text];
    }else{
        self.numview.delBtn.hidden = YES;
    }
    
}


@end






@implementation LHPShowNumView
- (instancetype)init{
    if (self = [super init]) {
        [self initialized];
    }
    return self;
}

- (void)initialized{
    self.backgroundColor = [UIColor whiteColor];
    UILongPressGestureRecognizer *Press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyLongPress:)];
    [self addGestureRecognizer:Press];
    [self addSubview:self.inputNumberLabel];
    [self addSubview:self.delBtn];
}
- (UITextField *)inputNumberLabel{
    if (_inputNumberLabel == nil) {
        _inputNumberLabel = [UITextField new];
        _inputNumberLabel.font = [UIFont systemFontOfSize:F(18)];
        _inputNumberLabel.textAlignment = NSTextAlignmentCenter;
        _inputNumberLabel.textColor = [UIColor redColor];
        _inputNumberLabel.borderStyle = UITextBorderStyleNone;
        _inputNumberLabel.backgroundColor = [UIColor whiteColor];
        _inputNumberLabel.placeholder = @"请输入视频号/手机号";
        _inputNumberLabel.text = @"";
        //        _inputNumberLabel.delegate = self;
        //        [_inputNumberLabel addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _inputNumberLabel;
}

-(UIButton *)delBtn{
    if (!_delBtn) {
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delBtn.hidden = YES;
        [_delBtn setImage:[UIImage imageNamed:@"icon_close_4"] forState:UIControlStateNormal];
        //逐个删除
        [_delBtn addTarget:self action:@selector(deleteOneByOne) forControlEvents:UIControlEventTouchUpInside];
        //长按全部删除
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAll:)];
        [_delBtn addGestureRecognizer:longPress];
    }
    return _delBtn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.inputNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(60);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.right.equalTo(self).with.offset(-80);
    }];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(self).with.offset(-25);
        make.centerY.equalTo(self);
    }];
}
-(void)deleteOneByOne{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteOneByOne)]) {
        [self.delegate deleteOneByOne];
    }
}
-(void)deleteAll:(UIGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan){
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAll)]) {
            [self.delegate deleteAll];
        }
    }
}
-(void)copyLongPress:(UILongPressGestureRecognizer*)recognizer{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
    
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    return [super canPerformAction:action withSender:sender];
}
-(void)cut:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.inputNumberLabel.text;
    self.inputNumberLabel.text = @"";
}
-(void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.inputNumberLabel.text;
}
@end







@implementation LHPDialListCell
#pragma mark 懒加载
- (UIImageView *)leftImg{
    if (_leftImg == nil) {
        _leftImg = [UIImageView new];
        _leftImg.image = [UIImage imageNamed:@"ai37"];
        _leftImg.widthHeight = XY(W(15),W(15));
    }
    return _leftImg;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"22"];
        _iconImg.widthHeight = XY(W(30),W(30));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
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
- (UILabel *)labelNum{
    if (_labelNum == nil) {
        _labelNum = [UILabel new];
        [GlobalMethod setLabel:_labelNum widthLimit:0 numLines:0 fontNum:F(10) textColor:COLOR_DETAIL text:@""];
    }
    return _labelNum;
}
- (UILabel *)labelTime{
    if (_labelTime == nil) {
        _labelTime = [UILabel new];
        [GlobalMethod setLabel:_labelTime widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_DETAIL text:@""];
    }
    return _labelTime;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelNum];
        [self.contentView addSubview:self.labelTime];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.iconImg.leftTop = XY(W(20)+self.leftImg.width,W(15)+[self.contentView addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(10)) color:COLOR_BACKGROUND]);
    
    self.leftImg.leftCenterY = XY(W(10),self.iconImg.centerY);

    [GlobalMethod resetLabel:self.labelName text:@"你好的家" widthLimit:0];
    self.labelName.leftTop = XY(W(10)+self.iconImg.right,self.iconImg.top);
    
    [GlobalMethod resetLabel:self.labelNum text:@"606985" widthLimit:0];
    self.labelNum.leftBottom = XY(self.labelName.left,self.iconImg.bottom);
    
    [GlobalMethod resetLabel:self.labelTime text:@"1月28日" widthLimit:0];
    self.labelTime.rightCenterY = XY(SCREEN_WIDTH-W(15),self.iconImg.centerY);
    
    self.height = [self.contentView addLineFrame:CGRectMake(0, self.iconImg.bottom+W(15), SCREEN_WIDTH, 1)];
}

@end
