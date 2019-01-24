//
//  FamilyAlbumVC.m
//  suoyi
//
//  Created by 王伟 on 2019/1/24.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "FamilyAlbumVC.h"
#import "GXPhotoAssetModel.h"
#import "AlbumNavTitleView.h"
#import "AlbumSelectAssetGroupView.h"
#import "LargePhotoPageViewController.h"
#import "GXPHKitTool.h"
//view
#import "ImageDetailBigView.h"
@interface FamilyAlbumVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic ,strong)UICollectionView * albumCollectionView;
@property (nonatomic ,strong)AlbumNavTitleView    * navTitleView;
@property (nonatomic ,strong)AlbumSelectAssetGroupView * selectGroupView;

@property (nonatomic ,strong)NSMutableArray      * photosDateArray;
@property (nonatomic ,strong)NSMutableDictionary * photosDict;
@property (nonatomic ,strong)NSMutableArray      * selectedImageArray;
@end

@implementation FamilyAlbumVC

#pragma mark - lazy 头部选择相册组视图
- (AlbumNavTitleView *)navTitleView
{
    if (!_navTitleView) {
        
        __weak typeof(self) weakSelf = self;
        _navTitleView = [[AlbumNavTitleView alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
        _navTitleView.navTitleButtonClick = ^(UIButton *button) {
            
            if (button.selected == YES) {
                
                [weakSelf.view addSubview:weakSelf.selectGroupView];
                [weakSelf.selectGroupView showGroupListView];
            } else {
                
                [weakSelf.selectGroupView hideGroupListView];
            }
        };
    }
    return _navTitleView;
}
#pragma mark - lazy 选择相册薄
- (AlbumSelectAssetGroupView *)selectGroupView
{
    if (!_selectGroupView) {
        
        __weak typeof(self) weakSelf = self;
        _selectGroupView = [[AlbumSelectAssetGroupView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, self.view.frame.size.height -64)];
        _selectGroupView.selectALGroupBlock = ^(PHAssetCollection * group,NSString * groupName) {
            
            NSLog(@" 开始读取 -------- 相簿 = %zd",groupName);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.navTitleView.detailLab.text = groupName;
                [weakSelf.navTitleView rotationBack];
                PHFetchResult * fetch = [[GXPHKitTool sharedPHKitTool] getFetchResult:group];
                [[GXPHKitTool sharedPHKitTool] getPhotoAssets:fetch resultBlock:^(NSMutableArray<GXPhotoAssetModel *> *imageArray) {
                    
                    NSLog(@"读取完的相簿 = %@ --- 个数%zd",groupName,imageArray.count);
                    [weakSelf setupPhotosDataWithArray:imageArray];
                }];
                
            });
            
        };
    }
    return _selectGroupView;
}

#pragma mark - lazy 已选中的照片数组
- (NSMutableArray *)selectedImageArray
{
    if (!_selectedImageArray) {
        _selectedImageArray = [NSMutableArray array];
    }
    return _selectedImageArray;
}

#pragma mark - lazy 日期数组
- (NSMutableArray *)photosDateArray
{
    if (!_photosDateArray) {
        _photosDateArray = [NSMutableArray array];
    }
    return _photosDateArray;
}
#pragma mark - lazy 图片字典
- (NSMutableDictionary *)photosDict
{
    if (!_photosDict) {
        _photosDict = [NSMutableDictionary dictionary];
    }
    return _photosDict;
}

- (UICollectionView *)albumCollectionView
{
    if (!_albumCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing      = 0.0;
        _albumCollectionView                    = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) collectionViewLayout:flowLayout];
        _albumCollectionView.backgroundColor    = [UIColor whiteColor];
        _albumCollectionView.dataSource         = self;
        _albumCollectionView.delegate           = self;
        _albumCollectionView.alwaysBounceVertical = YES; //不够一屏也能滚
        _albumCollectionView.pagingEnabled      = NO;
        [_albumCollectionView registerClass:[FamilyAlbumCell class] forCellWithReuseIdentifier:@"FamilyAlbumCell"];
        [_albumCollectionView registerClass:[FamilyAlbumHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
    }
    return _albumCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavTitle];
    
    [self setupView];
    
    [self loadPhotosData];
    
}
- (void)loadPhotosData
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        //执行操作
        NSLog(@"after 0.1s");
        
        [self loadLocalPhotoAlbumData];
        
    });
    
}
#pragma mark - title
- (void)setupNavTitle
{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"家庭相册" rightView:nil]];
}


#pragma mark - 设置UI
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.albumCollectionView];
    
}
#pragma mark - 首次进入加载相机胶卷照片资源
- (void)loadLocalPhotoAlbumData
{
    __weak typeof(self) weakSelf = self;
    [[GXPHKitTool sharedPHKitTool] getCameraRollAssetsWithResultBlock:^(PHAuthorizationStatus status,NSArray<GXPhotoAssetModel *> *imageArray) {
        
        if (imageArray.count > 0) {
            [weakSelf setupPhotosDataWithArray:imageArray];
        }
        if (status == PHAuthorizationStatusDenied) { //拒绝访问需弹窗提示用户
            [GlobalMethod showAlert:@"请在设备的“设置-隐私-照片”中允许访问照片。"];
        }
    }];
    
}
#pragma mark - 对照片进行日期分组
- (void)setupPhotosDataWithArray:(NSArray <GXPhotoAssetModel*>* )imageArray
{
    WEAKSELF
    
    [weakSelf.photosDict      removeAllObjects];
    [weakSelf.photosDateArray removeAllObjects];
    
    __block NSString * lastDateStr = @"";
    [imageArray enumerateObjectsUsingBlock:^(GXPhotoAssetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            
            lastDateStr = obj.dateStr;
            [weakSelf.photosDict setObject:[NSMutableArray arrayWithObjects:obj, nil] forKey:obj.dateStr];
            
        } else {
            
            if ([obj.dateStr isEqualToString:lastDateStr]) {
                
                //把图片添加到字典中
                [weakSelf.photosDict[obj.dateStr] addObject:obj];
            } else {
                
                lastDateStr = obj.dateStr;
                [weakSelf.photosDict setObject:[NSMutableArray arrayWithObjects:obj, nil] forKey:obj.dateStr];
            }
        }
    }];
    
    weakSelf.photosDateArray  = [NSMutableArray arrayWithArray:[weakSelf.photosDict allKeys]];
    
    //按日期排序
    NSArray * descriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:NO]];
    
    NSArray * tmpArray    = [NSArray arrayWithArray:weakSelf.photosDateArray];
    
    weakSelf.photosDateArray  = [NSMutableArray arrayWithArray:[tmpArray sortedArrayUsingDescriptors:descriptors]];
    
    [weakSelf.albumCollectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.photosDateArray.count == 0) {
        return 0;
    } else {
        NSArray * array = self.photosDict[self.photosDateArray[section]];
        return array.count;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.photosDateArray.count == 0 ? 1 : self.photosDateArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"FamilyAlbumCell";
    FamilyAlbumCell * collect = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (self.photosDateArray.count > 0) {
        
        //判断是否是已选的照片
        NSArray * array           = self.photosDict[self.photosDateArray[indexPath.section]];
        GXPhotoAssetModel * model = array[indexPath.row];
        collect.assetModel        = model;
        collect.ary = @[^(){
            ModelImage * model = [ModelImage new];
            model.url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548138517507&di=78799c29d427b33735de2756e1a89a2d&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201701%2F2017022305.jpg";
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.url = @"22";
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548139295838&di=77757991a6ffe2652e4e7589f5d7dd68&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201508%2F03%2F20150803090619_sYGZM.thumb.700_0.jpeg";
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.url = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548138934438&di=382a1d65280c7b7544c9b4515b0f39c3&imgtype=0&src=http%3A%2F%2Fs1.sinaimg.cn%2Fmw690%2F001KcHF3zy75TWW2s7ud0%26690";
            return model;
        }()].mutableCopy;
        
    }
    return collect;
}
#pragma mark - 头部视图（日期和全选）
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        
        FamilyAlbumHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
            //显示日期
        [headerView resetCellWithStr:@"今天"];
        return headerView;
    } else {
        return nil;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-5)/4, (SCREEN_WIDTH-5)/4);
}
//横向间距
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
//纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size={self.view.frame.size.width, 56};
    return size;
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end








@implementation FamilyAlbumHeaderView
#pragma mark 懒加载
- (UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [UILabel new];
        [GlobalMethod setLabel:_dateLabel widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_LABEL text:@""];
    }
    return _dateLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.dateLabel];
        
    }
    return self;
}
- (void)resetCellWithStr:(NSString *)str{
    
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [GlobalMethod resetLabel:self.dateLabel text:UnPackStr(str) widthLimit:0];
    self.dateLabel.leftTop = XY(W(15),W(15));
    
    self.height = self.dateLabel.bottom+W(15);
}

@end








@implementation FamilyAlbumCell
#pragma mark 懒加载
- (UIImageView *)photoButton{
    if (_photoButton == nil) {
        _photoButton = [UIImageView new];
        _photoButton.frame      = self.bounds;
        [_photoButton setContentMode:UIViewContentModeScaleAspectFill];
        _photoButton.clipsToBounds = YES;
        _photoButton.userInteractionEnabled  = true;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [_photoButton addGestureRecognizer:tap];
    }
    return _photoButton;
}
- (NSMutableArray *)ary
{
    if (_ary == nil) {
        _ary = [NSMutableArray new];
    }
    return  _ary;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.photoButton];
    }
    return self;
}
- (void)setAssetModel:(GXPhotoAssetModel *)assetModel
{
    _assetModel = assetModel;
    
    CGSize imgSize = CGSizeMake(((SCREEN_WIDTH-5)/4)*2, ((SCREEN_WIDTH-5)/4)*2);
    
    PHImageRequestOptions * options = [[PHImageRequestOptions alloc]init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    [[GXPHKitTool sharedPHKitTool].phManager requestImageForAsset:assetModel.asset
                                                       targetSize:imgSize
                                                      contentMode:PHImageContentModeAspectFill
                                                          options:options
                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                        [self.photoButton setImage:result];
                                                    }];
    
}
#pragma mark image Click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView * view = (UIImageView *)tap.view;
    ImageDetailBigView * detailView = [ImageDetailBigView new];
    
    [detailView resetView:self.ary isEdit:false index: view.tag];
    [detailView showInView:GB_Nav.lastVC.view imageViewShow:view];
}
@end
