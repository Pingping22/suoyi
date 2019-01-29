//
//  LHPDialVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/28.
//  Copyright © 2019 liuhuiping. All rights reserved.
//
#define SELFVIEWBGC      [UIColor colorWithRed:247.0/255.0 green:245.0/255.0 blue:243.0/255 alpha:1.0];
#define KSCALE  /375.0 * SCREEN_WIDTH

#import "LHPDialVC.h"
#import "Masonry.h"

@interface LHPDialVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *xmDialCollectionView; //拨号界面

@end

@implementation LHPDialVC
- (instancetype)init{
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

#pragma mark 创建视图
-(void)creatView{

    WEAKSELF
    //创建拨号界面
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(62 KSCALE ,62 KSCALE);
    flowLayout.minimumLineSpacing = 20 KSCALE;
    flowLayout.sectionInset = UIEdgeInsetsMake(20 KSCALE,62 KSCALE, 0,62 KSCALE);
    _xmDialCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_xmDialCollectionView registerClass:[LHPNumCell class] forCellWithReuseIdentifier:@"LHPNumCell"];
    _xmDialCollectionView.dataSource = self;
    _xmDialCollectionView.delegate = self;
    _xmDialCollectionView.backgroundColor = COLOR_BACKGROUND;
    [self addSubview:_xmDialCollectionView];
    [_xmDialCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.width.mas_equalTo(@(SCREEN_WIDTH));
        make.height.mas_equalTo(weakSelf);
    }];

    UIButton *downSet = [UIButton buttonWithType:UIButtonTypeCustom];
    [downSet setBackgroundImage:[UIImage imageNamed:@"downset"] forState:UIControlStateNormal];
    [downSet addTarget:self action:@selector(downSetCall) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:downSet];
    [downSet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(W(60)));
        make.bottom.equalTo(weakSelf).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(W(50), W(50)));
    }];
    
    UIButton *call = [UIButton buttonWithType:UIButtonTypeCustom];
    [call setBackgroundImage:[UIImage imageNamed:@"Key13"] forState:UIControlStateNormal];
    [call addTarget:self action:@selector(phoneCall) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:call];
    [call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(W(60), W(60)));
    }];
    
    
}

#pragma mark UICollectionView delegate datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHPNumData *data =  [[LHPNumData alloc]init];
    [data getData:indexPath.row];
    LHPNumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LHPNumCell" forIndexPath:indexPath ];
    [cell resetCellWithModel:data];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LHPNumData *data =  [[LHPNumData alloc]init];
    [data getData:indexPath.row];
    if (self.NumBlock) {
        self.NumBlock(data);
    }
    // 手动触发cell为选中状态
    dispatch_async(dispatch_get_main_queue(), ^{
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    });
}

#pragma mark 拨打电话
-(void)phoneCall{
    
}
- (void)downSetCall{
    [self removeFromSuperview];
}
#pragma mark 销毁
- (void)dealloc{
    NSLog(@"%s  %@",__func__,self.class);
}
@end






@implementation LHPNumCell
- (UIImageView *)numberBtn{
    if (_numberBtn == nil) {
        _numberBtn = [UIImageView new];
        _numberBtn.widthHeight = XY(W(62),W(62));
    }
    return _numberBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.numberBtn];
    }
    return self;
}

- (void)resetCellWithModel:(LHPNumData *)model{
    self.data = model;
    self.numberBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",UnPackStr(model.normal)]];
    self.numberBtn.leftTop = XY(0,0);
    self.height = self.numberBtn.bottom ;
}

@end







@implementation LHPNumData
{
    NSArray *_normalArr; //存放普通号码按钮图片
    NSArray *_highlightArr;//存放高亮号码按钮图片
    NSArray *_numArr; //存号码
    
}
-(instancetype)init{
    
    return [super init];
}
#pragma mark 从plist获取图片
-(void)getData:(NSInteger)integer{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NumberList" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _normalArr = [dic objectForKey:@"normalNum"];
    _highlightArr  = [dic objectForKey:@"highlight"];
    _numArr = [dic objectForKey:@"Num"];
    self.normal = _normalArr[integer];
    self.highlight = _highlightArr[integer];
    self.num = _numArr[integer];
}
@end








