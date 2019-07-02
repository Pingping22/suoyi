//
//  SelectBlackTypeView.m
//  乐销
//
//  Created by liuhuiping on 2018/5/11.
//Copyright © 2018年 ping. All rights reserved.
//

#import "SelectBlackTypeView.h"

@interface SelectBlackTypeView ()

@end

@implementation SelectBlackTypeView

#pragma mark - 懒加载
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"yx_sjb"];
        _imgView.widthHeight = XY(W(13),W(8));
    }
    return _imgView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SelectBlackTypeCell class] forCellReuseIdentifier:@"SelectBlackTypeCell"];
    }
    return _tableView;
}
- (UIView *)imageViewBg{
    if (!_imageViewBg) {
        //        UIImage * image =  [[UIImage imageNamed:@"xsd_bj"]resizableImageWithCapInsets:UIEdgeInsetsMake(W(15),W(15), W(15), W(15))resizingMode:UIImageResizingModeTile];
        _imageViewBg = [UIView new];
        _imageViewBg.backgroundColor = [UIColor colorWithHexString:@"#49484B"];
        [GlobalMethod setRoundView:_imageViewBg color:[UIColor clearColor] numRound:2 width:0];
        _imageViewBg.userInteractionEnabled = YES;
    }
    return _imageViewBg;
}
- (CGFloat )cellHeight{
    if (!_cellHeight) {
        _cellHeight = [SelectBlackTypeCell fetchHeight:nil className:nil selectorName:@"resetCellWithModel:"];
    }
    return _cellHeight;
}
- (CGFloat )cellWidth{
    if (!_cellWidth) {
        _cellWidth = W(120);
    }
    return _cellWidth;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self addSubview:self.imageViewBg];
    [self.imageViewBg addSubview:self.tableView];
    [self addSubview:self.imgView];
    [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectBlackTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectBlackTypeCell" forIndexPath:indexPath];
    cell.lineView.hidden = self.aryDatas.count == indexPath.row + 1? YES : NO;
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockCellClick = ^(SelectBlackTypeCell *cell) {
        if (cell.model.blockClick) {
            cell.model.blockClick();
        }
        [weakSelf removeFromSuperview];
    };
    if ([tableView isLastCellInSection:indexPath]) {
        [cell.contentView removeSubViewWithTag:TAG_LINE];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//刷新页面
- (void)showWithFrame:(CGRect)rect ary:(NSArray *)array{
    
    self.aryDatas = array;
    
    self.imgView.rightTop = XY(SCREEN_WIDTH - W(20), NAVIGATIONBAR_HEIGHT+W(4));
    self.imageViewBg.frame = CGRectMake(SCREEN_WIDTH-self.cellWidth-W(10)-W(7), self.imgView.bottom-2, self.cellWidth+W(10), self.aryDatas.count * self.cellHeight);
    self.tableView.widthHeight = XY(self.cellWidth, self.aryDatas.count * self.cellHeight);
    self.tableView.leftTop = XY(W(5),0);
    
    
    UIView * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

#pragma mark btnClick

- (void)btnClick:(UIButton *)sender{
    [self removeFromSuperview];
}

@end




@implementation SelectBlackTypeCell

#pragma mark 懒加载
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.widthHeight = XY(W(17),W(17));
    }
    return _imgView;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor whiteColor] text:@""];
    }
    return _labelName;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#5B5A5D"];
        _lineView.hidden = false;
    }
    return _lineView;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.lineView];
        [self.contentView addTarget:self action:@selector(cellClick)];
        
    }
    return self;
}

#pragma mark 刷新view
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.imgView.image = model.imageName?[UIImage imageNamed:model.imageName]:nil;
    self.imgView.leftTop = XY(W(14),W(14));
    
    [self.labelName fitTitle:model.title variable:0];
    if (isStr(model.imageName)) {
        self.imgView.hidden = NO;
        self.labelName.leftCenterY = XY(self.imgView.right+W(17),self.imgView.centerY);
    }else{
        self.imgView.hidden = YES;
        self.labelName.leftCenterY = XY(W(17),self.imgView.centerY);
    }
    self.labelName.textColor = model.color?model.color:[UIColor whiteColor];
    self.height = self.imgView.bottom+W(14);
    
    self.lineView.widthHeight = XY(self.width - W(28), 1);
    self.lineView.leftTop = XY(W(14),self.height-1);
}

#pragma mark click
- (void)cellClick {
    if (self.blockCellClick) {
        self.blockCellClick(self);
    }
}
@end

