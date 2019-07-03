//
//  HomePageVC.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "HomePageVC.h"
#import "ProductMarketNavView.h"
//slider view
#import "SliderView.h"
//sc link
#import "LinkScrollView.h"
//vc
#import "SingleChatListVC.h"
#import "GroupChatListVC.h"
//view
#import "SelectTypeView.h"
@interface HomePageVC ()<UIScrollViewDelegate,SliderViewDelegate>
@property (nonatomic, strong) LinkScrollView *scAll;//全部sc
@property (nonatomic, strong) UIScrollView *scList;//list sc
@property (strong, nonatomic) SliderView *sliderView;//sliderview
@property (nonatomic, strong) SingleChatListVC *listVCNew;//最新订单
@property (nonatomic, strong) GroupChatListVC *listVCComplete;//已完成订单
@property (nonatomic, strong) SelectTypeView *selectTypeView;
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) NSArray * dataArr;
@end

@implementation HomePageVC
#pragma mark lazy
- (SelectTypeView *)selectTypeView {
    if (!_selectTypeView) {
        _selectTypeView = [SelectTypeView new];
    }
    return _selectTypeView;
}
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[^(){
            ModelBtn * model = [ModelBtn modelWithTitle:@"扫一扫" imageName:@"sweepcode" highImageName:@"sweepcode" tag:0];
            model.blockClick = ^{

            };
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn modelWithTitle:@"添加好友" imageName:@"addfriend" highImageName:@"addfriend" tag:1];
            model.blockClick = ^{
                [GB_Nav pushVCName:@"SearchFriendListVC" animated:true];
            };
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn modelWithTitle:@"发起群聊" imageName:@"groupchat" highImageName:@"groupchat" tag:3];
            model.blockClick = ^{
                [GB_Nav pushVCName:@"CreateGroupVC" animated:true];
            };
            return model;
        }()];
    }
    return _dataArr;
}
- (LinkScrollView *)scAll{
    if (!_scAll) {
        _scAll = [LinkScrollView new];
        if (@available(iOS 11.0, *)) {
            _scAll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _scAll.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT);
        _scAll.contentSize = CGSizeMake(0, SCREEN_HEIGHT*5);
        _scAll.backgroundColor = [UIColor clearColor];
        _scAll.sizeHeight = self.sliderView.top - 2;
        _scAll.showsVerticalScrollIndicator = false;
        _scAll.showsHorizontalScrollIndicator = false;
        _scAll.scrollEnabled = false;
        [_scAll addSubview:self.scList];
    }
    return _scAll;
}
- (UIScrollView *)scList{
    if (!_scList) {
        _scList = [UIScrollView new];
        _scList.backgroundColor = [UIColor whiteColor];
        _scList = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.sliderView.bottom +1, SCREEN_WIDTH, SCREEN_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT)];
        _scList.delegate = self;
        _scList.showsVerticalScrollIndicator = false;
        _scList.showsHorizontalScrollIndicator = false;
        _scList.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
        _scList.pagingEnabled = true;
    }
    return _scList;
}
- (SingleChatListVC *)listVCNew{
    if (!_listVCNew) {
        _listVCNew = [SingleChatListVC new];
        _listVCNew.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT);
        _listVCNew.tableView.frame = _listVCNew.view.bounds;
        [self addChildViewController:_listVCNew];
    }
    return _listVCNew;
}
- (GroupChatListVC *)listVCComplete{
    if (!_listVCComplete) {
        _listVCComplete = [GroupChatListVC new];
        _listVCComplete.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT);
        _listVCComplete.tableView.frame = _listVCComplete.view.bounds;
        [self addChildViewController:_listVCComplete];
    }
    return _listVCComplete;
}

- (BaseNavView *)nav {
    if (!_nav) {
        WEAKSELF
        _nav = [BaseNavView initNavTitle:@"" leftImageName:@"" leftBlock:nil rightImageName:@"add_right" righBlock:^{
            [weakSelf.view endEditing:YES];
            [weakSelf navRightClick];
        }];
    }
    return _nav;
}
- (SliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = [SliderView new];
        _sliderView.widthHeight = XY(SCREEN_WIDTH, W(44));
        _sliderView.viewSlidWidth = W(44);
        _sliderView.isHasSlider = true;
        _sliderView.isLineVerticalHide = true;
        _sliderView.viewSlidColor = [UIColor blueColor];
        [_sliderView resetWithAry:@[[ModelBtn modelWithTitle:@"聊天"],[ModelBtn modelWithTitle:@"群"]]];
        _sliderView.delegate = self;
    }
    
    return _sliderView;
}
#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.scAll];
    [self.scAll addSubview:self.sliderView];
    //初始化子vc
    [self setupChildVC];
}

-(void)addNav{
    
    [self.view addSubview:self.nav];
    
}
- (void)navRightClick{
    UIView * window = [UIApplication sharedApplication].keyWindow;
    [self.selectTypeView showWithFrame:[self.view convertRect:self.nav.frame toView:window] ary:self.dataArr];
}
#pragma mark view will appear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.listVCNew refreshHeaderAll];
    [self.listVCComplete refreshHeaderAll];
}
/**
 * 初始化子控制器
 */
- (void)setupChildVC{
    [self.scList addSubview:self.listVCNew.view];
    [self.scList addSubview:self.listVCComplete.view];
}

#pragma mark scrollview delegat
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.scList]) {
        [self fetchCurrentView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([scrollView isEqual:self.scList]) {
        if (!decelerate) {
            [self fetchCurrentView];
        }
    }
}
- (void)fetchCurrentView {
    // 获取已经滚动的比例
    double ratio = self.scList.contentOffset.x / SCREEN_WIDTH;
    int    page  = (int)(ratio + 0.5);
    // scrollview 到page页时 将toolbar调至对应按钮
    [self.sliderView sliderToIndex:page noticeDelegate:NO];
}

#pragma mark slider delegate
- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control{
    [UIView animateWithDuration:0.5 animations:^{
        self.scList.contentOffset = CGPointMake(SCREEN_WIDTH * tag, 0);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark click
- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 3://search
        {

        }
            break;
        default:
            break;
    }
}
@end





@implementation HomePageHeaderView
#pragma mark 懒加载
- (UIImageView *)backView{
    if (_backView == nil) {
        _backView = [UIImageView new];
        _backView.image = [UIImage imageNamed:@"12"];
        _backView.widthHeight = XY(SCREEN_WIDTH,W(250));
    }
    return _backView;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:[UIColor whiteColor] text:@""];
    }
    return _labelTitle;
}
- (SPMultipleSwitch *)switch3
{
    if (_switch3 == nil) {
        _switch3 = [[SPMultipleSwitch alloc] initWithItems:@[@"",@"视频通话"]];
        _switch3.widthHeight = XY(SCREEN_WIDTH-W(180),W(40));
        _switch3.backgroundColor = COLOR_GREEN;
        _switch3.selectedTitleColor = [UIColor clearColor];
        _switch3.titleColor = [UIColor whiteColor];
        _switch3.trackerColor = [UIColor whiteColor];
        _switch3.contentInset = 5;
        _switch3.spacing = 10;
        _switch3.titleFont = [UIFont systemFontOfSize:F(12)];
        _switch3.trackerImage = [UIImage imageNamed:@"tracker"];
        [_switch3 addTarget:self action:@selector(switchAction3:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _switch3;
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
    [self addSubview:self.backView];
    [self addSubview:self.labelTitle];
    [self addSubview:self.switch3];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.backView.leftTop = XY(0,0);
    
    [GlobalMethod resetLabel:self.labelTitle text:@"滑动按钮，开始视频通话" widthLimit:0];
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH/2,W(80));
    
    self.switch3.leftTop = XY(W(90),W(50)+self.labelTitle.bottom);

    self.backView.height = self.switch3.bottom+W(10);
    self.height = self.backView.bottom;
}
- (void)switchAction3:(SPMultipleSwitch *)multipleSwitch {
    NSLog(@"点击了第%zd个",multipleSwitch.selectedSegmentIndex);
}
@end




@implementation HomePageSecHeaderView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.backgroundColor = COLOR_LINE;
        _imgView.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_imgView color:[UIColor clearColor] numRound:_imgView.width/2 width:0];
    }
    return _imgView;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        [GlobalMethod setLabel:_labelName widthLimit:0 numLines:0 fontNum:F(12) textColor:COLOR_LABEL text:@""];
    }
    return _labelName;
}
- (UIControl *)control{
    if (_control == nil) {
        _control = [UIControl new];
        _control.tag = 1;
        [_control addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _control.backgroundColor = [UIColor clearColor];
        _control.widthHeight = XY(W(55),W(70));
    }
    return _control;
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
    [self addSubview:self.labelTitle];
    [self addSubview:self.imgView];
    [self addSubview:self.labelName];
    [self addSubview:self.control];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.labelTitle text:@"留言" widthLimit:0];
    self.labelTitle.leftTop = XY(W(15),W(15));
    
    self.imgView.leftTop = XY(W(15),self.labelTitle.bottom+W(15));
    
    [GlobalMethod resetLabel:self.labelName text:@"家庭通讯录" widthLimit:0];
    self.labelName.centerXTop = XY(self.imgView.centerX,self.imgView.bottom+W(8));
    
    self.control.leftTop = XY(W(0),self.labelTitle.bottom+W(15));
    
    self.height = [self addLineFrame:CGRectMake(0, self.labelName.bottom+W(15), SCREEN_WIDTH, 1)];
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav pushVCName:@"HomeAddressBookListVC" animated:true];
        }
            break;
            
        default:
            break;
    }
}
@end




@implementation HomePageThirHeaderView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}
-(UIButton *)addBtn{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.tag = 1;
        [_addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:F(12)];
        [_addBtn setTitle:@"添加照片" forState:(UIControlStateNormal)];
        [_addBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        _addBtn.widthHeight = XY(W(100),W(20));
    }
    return _addBtn;
}
- (MineListMindImgView *)upImageInfoView{
    if (!_upImageInfoView) {
        _upImageInfoView = [MineListMindImgView new];
        _upImageInfoView.topInteral = W(2);
        _upImageInfoView.numLimit = 3;
    }
    return _upImageInfoView;
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
    [self addSubview:self.labelTitle];
    [self addSubview:self.addBtn];
    [self addSubview:self.upImageInfoView];

    //初始化页面
    [self resetWithAry:nil];
}

#pragma mark 刷新view
- (void)resetWithAry:(NSArray *)aryImage{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.labelTitle text:@"家庭相册" widthLimit:0];
    self.labelTitle.leftTop = XY(W(15),W(15));
    
    self.addBtn.rightCenterY = XY(SCREEN_WIDTH,self.labelTitle.centerY);
    
    self.upImageInfoView.top = self.labelTitle.bottom+W(15);

    [self.upImageInfoView resetViewWithArray:aryImage];

    self.height = self.upImageInfoView.bottom+W(15);

}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav pushVCName:@"CustomPhotoAlbumViewController" animated:true];
        }
            break;
            
        default:
            break;
    }
}




@end





