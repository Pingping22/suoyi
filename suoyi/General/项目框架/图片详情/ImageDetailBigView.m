//
//  ImageDetailBigView.m
//  乐销
//
//  Created by 隋林栋 on 2017/3/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "ImageDetailBigView.h"
#import "BaseImage.h"//image
#import "ShareAlertView.h"

@interface ImageDetailBigView()
{
    CGFloat contentSetY;
}
@property (nonatomic, strong) UpImageDetailImageViewCell *cellShow;
@property (nonatomic, strong) UIControl *btnDelete;
@property (nonatomic, strong) UILabel *labelNum;
@property (nonatomic, strong) ShareAlertView * shareAlertView;
@end

@implementation ImageDetailBigView
#pragma mark lazy init
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
- (UICollectionView *)collectionImageDetail{
    if (_collectionImageDetail == nil) {
        //布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        CGSize size = [UpImageDetailImageViewCell fetchHeight];
        layout.itemSize = size;
        //设定滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 6.创建UICollectionView
        _collectionImageDetail = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        // 7.设置collectionImageDetail的背景色
        _collectionImageDetail.backgroundColor = [UIColor clearColor];
        // 8.设置代理
        _collectionImageDetail.collectionViewLayout = layout;
        _collectionImageDetail.delegate = self;
        _collectionImageDetail.dataSource = self;
        _collectionImageDetail.scrollEnabled = YES;
        _collectionImageDetail.pagingEnabled = true;
        _collectionImageDetail.showsVerticalScrollIndicator = false;
        _collectionImageDetail.showsHorizontalScrollIndicator = false;
        
        [_collectionImageDetail registerClass:[UpImageDetailImageViewCell class] forCellWithReuseIdentifier:@"UpImageDetailImageViewCell"];
    }
    return _collectionImageDetail;
}
- (BaseNavView *)navView{
    if (!_navView) {
        WEAKSELF
        _navView = [BaseNavView initNavTitle:@"" leftImageName:@"left_white" leftBlock:^{
            [weakSelf removeSelf:YES];
        } rightImageName:nil righBlock:nil];
        [_navView removeSubViewWithTag:TAG_LINE];
        _navView.labelTitle.textColor = [UIColor whiteColor];
        _navView.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        [_navView addSubview:self.btnDelete];
        [_navView addSubview:self.labelNum];
    }
    return _navView;
}
- (UILabel *)labelNum{
    if (!_labelNum) {
        _labelNum = [UILabel new];
        _labelNum.fontNum = F(12);
        _labelNum.textColor = [UIColor whiteColor];
        _labelNum.numberOfLines = 0;
        _labelNum.lineSpace = 0;
        _labelNum.textAlignment = NSTextAlignmentCenter;
    }
    return _labelNum;
}
- (UIControl *)btnDelete{
    if (!_btnDelete) {
        _btnDelete = [UIControl new];
        _btnDelete.tag = 2;
        _btnDelete.width = W(45);
        _btnDelete.frame = CGRectMake(SCREEN_WIDTH - _btnDelete.width, STATUSBAR_HEIGHT, _btnDelete.width, NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT);
        [_btnDelete addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnDelete addSubview: ^(){
            UIImageView * iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gengduo"]];
            iv.backgroundColor = [UIColor clearColor];
            iv.right = _btnDelete.width - W(15);
            iv.centerY = _btnDelete.height/2.0;
            return iv;
        }()];
    }
    return _btnDelete;
}
- (ShareAlertView *)shareAlertView
{
    if (_shareAlertView == nil) {
        _shareAlertView = [ShareAlertView new];
        _shareAlertView.frame = CGRectMake(W(0), W(0), SCREEN_WIDTH, SCREEN_HEIGHT);
        [_shareAlertView.wechatControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareAlertView.personControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareAlertView.weiboControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareAlertView.downControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareAlertView.deleteControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return  _shareAlertView;
}

- (UILabel *)label{
    if (_label == nil) {
        _label = [UILabel new];
        _label.fontNum = F(14);
        _label.textColor = [UIColor whiteColor];
        _label.numberOfLines = 0;
        _label.lineSpace = 0;
    }
    return _label;
}
- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.image = [UIImage imageNamed:@"12"];
        _iconImg.widthHeight = XY(W(30),W(30));
        [GlobalMethod setRoundView:_iconImg color:[UIColor clearColor] numRound:_iconImg.width/2 width:0];
    }
    return _iconImg;
}

- (UIScrollView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIScrollView new];
        _viewBG.backgroundColor = COLOR_BLACK_ALPHA_PER60;
    }
    return _viewBG;
}

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.collectionImageDetail];
        [self addSubview:self.navView];
        [self addSubview:self.viewBG];
        [self.viewBG addSubview:self.label];
        [self.viewBG addSubview:self.iconImg];
    }
    return self;
}
//reset view
- (void)resetView:(NSMutableArray *)ary isEdit:(BOOL)isEdit index:(NSInteger)index{
    self.aryDatas = ary;
    self.isEdit = isEdit;
    [self.labelNum fitTitle:@"2019年1月22日\n13:23" variable:SCREEN_WIDTH-W(45)];
    self.labelNum.centerXCenterY = XY(SCREEN_WIDTH/2,self.btnDelete.centerY);
    [self.label fitTitle:@"wo" variable:SCREEN_WIDTH-W(45)];

    WEAKSELF
    [self.collectionImageDetail performBatchUpdates:^{
        [weakSelf.collectionImageDetail reloadData];
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.collectionImageDetail performBatchUpdates:^{
                [weakSelf.collectionImageDetail scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index < weakSelf.aryDatas.count?index:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                
            } completion:^(BOOL finished) {
                //初始化显示cell
                [weakSelf resetTableCell];
                [weakSelf resetNavTitle];
            }];
            
        }
    }];
}

#pragma mark删除当前图片
- (void)removeItemNow{
    int index = 0;
    // 获取已经滚动的比例
    double ratio = self.collectionImageDetail.contentOffset.x / SCREEN_WIDTH;
    int  page  = floor(ratio + 0.5);
    index = page;
    if (self.aryDatas.count > index) {
        [self.aryDatas removeObjectAtIndex:index];
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:page inSection:0];
        if (self.blockRefresh) {
            self.blockRefresh();
        }
        [self.collectionImageDetail deleteItemsAtIndexPaths:@[indexPath]];
        if (self.aryDatas.count == 0) {
            [self removeSelf:NO];
            return;
        }
        //        [self.navView changeTitle:[NSString stringWithFormat:@"%ld/%ld",MIN(page+1, self.aryDatas.count),self.aryDatas.count]];
        [self resetviewBG:(int)MIN(page, self.aryDatas.count-1)];
    }
}

#pragma mark reset label
- (void)resetNavTitle{
    // 获取已经滚动的比例
    double ratio = self.collectionImageDetail .contentOffset.x / SCREEN_WIDTH;
    int page = (int)(ratio + 0.5);
    //    [self.navView changeTitle:[NSString stringWithFormat:@"%d/%ld",page+1,self.aryDatas.count]];
    [self resetviewBG:page];
}

-(void)resetviewBG:(int)page{
    self.iconImg.leftTop = XY(W(15),W(5));

    self.label.leftCenterY = XY(W(10)+self.iconImg.right,self.iconImg.centerY);

    self.viewBG.widthHeight = XY(SCREEN_WIDTH, self.iconImg.bottom + W(10));
    self.viewBG.leftTop = XY(0, self.navView.bottom);
}

#pragma mark amplify image
- (void)amplifyImage:(UIImageView *)ivOrigin viewShow:(UIView *)viewShow{
    UIImage *image = ivOrigin.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:true];
    //背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //获取位置
    CGRect oldframe = [ivOrigin convertRect:ivOrigin.bounds toView:window];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    [imageView setImage:image];
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    //动画放大
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat width,height;
        if (image.size.height/image.size.width>SCREEN_HEIGHT/SCREEN_WIDTH) {
            width = image.size.width * SCREEN_HEIGHT / image.size.height;
            height = SCREEN_HEIGHT;
        }else{
            //宽度
            width = SCREEN_WIDTH;
            //高度
            height = image.size.height * SCREEN_WIDTH / image.size.width;
        }
        imageView.widthHeight = XY(width, height);
        imageView.center = backgroundView.center;
        [backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        [viewShow addSubview:self];
//        self.navView.alpha = 0;
//        self.label.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.navView.alpha = 1;
            self.label.alpha = 1;
        }];
    }];
}
#pragma mark 显示与隐藏
- (void)showInView:(UIView *)view imageViewShow:(UIImageView *)iv{
    [self amplifyImage:iv viewShow:view];
    //change status bar
    [GlobalMethod exchangeStatusBar:UIStatusBarStyleLightContent];
}

- (void)removeSelf:(BOOL)isNavLeft{
    //change status bar
    [GlobalMethod exchangeStatusBar:UIStatusBarStyleLightContent];
    if (isNavLeft) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}

#pragma mark - UICollectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.aryDatas.count;
}
// item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UpImageDetailImageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpImageDetailImageViewCell" forIndexPath:indexPath];
    cell.detailBigView= self;
    cell.navView = self.navView;
    cell.viewBG = self.viewBG;
    WEAKSELF
    cell.blockClick = ^{
        [weakSelf removeSelf:NO];
    };
    cell.hidenBlockClick = ^{
        weakSelf.navView.hidden = !weakSelf.navView.hidden;
        weakSelf.viewBG.hidden = !weakSelf.viewBG.hidden;
    };
    [cell resetWithModel:self.aryDatas[indexPath.row] isEdit:self.isEdit];
    return cell;
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat  offsetY = scrollView.contentOffset.y;
//    if (scrollView == self.label) {
//        if (self.label.height>=W(130)) {
//            if ((self.label.height<W(170)&& offsetY>0) ||offsetY<0 ) {
//                self.label.leftTop = XY(W(10),W(20));
//                self.label.widthHeight = XY(SCREEN_WIDTH - W(20), self.label.height+offsetY);
//                if (offsetY<0 && self.label.height<W(130)) {
//                    self.label.widthHeight = XY(SCREEN_WIDTH - W(20), W(130));
//                }
//                if (offsetY>0 && self.label.height>W(170) ) {
//                    self.label.widthHeight = XY(SCREEN_WIDTH - W(20), W(170));
//                }
//                if (offsetY>0 && self.label.height>=contentSetY) {
//                    self.label.widthHeight = XY(SCREEN_WIDTH - W(20),contentSetY-1);
//                }
//                self.viewBG.widthHeight = XY(SCREEN_WIDTH, self.label.height+W(60));
//
//                self.viewBG.leftBottom = XY(0, self.bottom);
//                scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
//            }
//        }
//    }
//}

#pragma mark scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (scrollView !=self.label) {
        [self resetNavTitle];
        [self resetTableCell];
//    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (!decelerate && scrollView !=self.label) {
        [self resetNavTitle];
        [self resetTableCell];
//    }
}

#pragma mark reset tableview cell visible
- (void)resetTableCell{
    NSIndexPath * indexPath = [self.collectionImageDetail  indexPathsForVisibleItems].lastObject;
    UpImageDetailImageViewCell * cellNow = (UpImageDetailImageViewCell *)[self.collectionImageDetail cellForItemAtIndexPath:indexPath];
    if (cellNow && cellNow != self.cellShow) {
        if ([self.cellShow isKindOfClass:UpImageDetailImageViewCell.class]) {
            [self.cellShow recoverScrollView];
        }
        self.cellShow = cellNow;
    }
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    WEAKSELF
    switch (sender.tag) {
        case 2:
        {
            [[UIApplication sharedApplication].keyWindow addSubview:self.shareAlertView];
        }
            break;
        case 11://微信好友
        {
            
        }
            break;
        case 12://微信朋友圈
        {
            
        }
            break;
        case 13://新浪微博
        {
            
        }
            break;
        case 14://下载
        {
            [self.shareAlertView removeFromSuperview];
            UIImageWriteToSavedPhotosAlbum(weakSelf.cellShow.iv.image,weakSelf,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);

        }
            break;
        case 15://删除
        {
            ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_LABEL];
            modelConfirm.blockClick = ^(void){
                [weakSelf removeItemNow];
            };
            [BaseAlertView initWithTitle:@"确认删除？" content:@"确认删除当前图片" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:self];
            
        }
            break;
                
        default:
            break;
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(void*)contextInfo{
    NSString*message =@"";
    if(!error) {
        message =@"成功保存到相册";
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"message:message delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        [alert show];
    }else
    {
        message = [error description];
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提    示"message:message delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        [alert show];
    }
}
@end

@implementation UpImageDetailImageViewCell

#pragma mark 懒加载
- (UIImageView *)iv{
    if (_iv == nil) {
        _iv = [UIImageView new];
        _iv.backgroundColor = [UIColor clearColor];
        _iv.widthHeight = XY(SCREEN_WIDTH,SCREEN_HEIGHT);
        _iv.contentMode = UIViewContentModeScaleAspectFit;
        _iv.userInteractionEnabled = true;
        [_iv addTarget:self action:@selector(imageClick)];
        UILongPressGestureRecognizer*longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imglongTapClick:)];
        [_iv addGestureRecognizer:longTap];
    }
    return _iv;
}

- (UIScrollView *)scBG{
    if (!_scBG) {
        _scBG = [UIScrollView new];
        _scBG.scrollEnabled = true;
        _scBG.delegate = self;
        _scBG.maximumZoomScale = 2;
        _scBG.backgroundColor = [UIColor clearColor];
        _scBG.showsVerticalScrollIndicator = false;
        _scBG.showsHorizontalScrollIndicator = false;
        if (@available(iOS 11.0, *)) {
            _scBG.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _scBG.decelerationRate = 0.1f;
        [_scBG.panGestureRecognizer addTarget:self action:@selector(scrollViewPanMethod:)];
        _scBG.userInteractionEnabled = true;
    }
    return _scBG;
}

#pragma mark 获取高度
+ (CGSize)fetchHeight{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT );
    
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self.contentView addSubview:self.scBG];
    [self.scBG addSubview:self.iv];
}


#pragma mark 刷新view
- (void)resetWithModel:(ModelImage *)model isEdit:(BOOL)isEdit{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.iv sd_setImageWithModel:model placeholderImageName:IMAGE_BIG_DEFAULT];
    self.iv.leftTop = XY(0, 0);
    self.iv.widthHeight = XY(SCREEN_WIDTH,SCREEN_HEIGHT);
    [self recoverScrollView];
    
}
//recover scroll view
- (void)recoverScrollView{
    [self.scBG setZoomScale:1 animated:false];
    self.scBG.leftTop = XY(0, 0);
    self.scBG.widthHeight = XY(SCREEN_WIDTH,SCREEN_HEIGHT);
    self.scBG.contentSize = CGSizeMake(SCREEN_WIDTH, 2*SCREEN_HEIGHT);
    
}

#pragma mark click
- (void)imageClick{
    if (self.hidenBlockClick) {
        self.hidenBlockClick();
    }
}

#pragma mark - 长按手势方法
-(void)imglongTapClick:(UIGestureRecognizer *)gesture{
    if(gesture.state==UIGestureRecognizerStateBegan)
    {
//        WEAKSELF
//        [GlobalMethod fetchPhotoAuthorityBlock:^{
//            [BaseAlertView customAlertControllerWithTitle:@"保存图片" modelBtnArr:@[[ModelBtn modelWithTitle:@"保存图片到手机" imageName:nil highImageName:nil tag:1 color:COLOR_LABEL]] cancelTitle:@"取消" cancelColor:COLOR_LABEL selectIndex:^(int selectIndex) {
//                if (selectIndex==1) {
//                    UIImageWriteToSavedPhotosAlbum(weakSelf.iv.image,weakSelf,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
//                }
//            }];
//        }];
    }
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (scale != 1) {return;}
    [self recoverScrollView];
}

-(void)scrollViewPanMethod:(UIPanGestureRecognizer *)pan{
    if (_scBG.zoomScale != 1.0f) {return;}
    CGFloat contentOffSetY  = _scBG.contentOffset.y > 0 ? -_scBG.contentOffset.y:_scBG.contentOffset.y;
    //拖拽结束后判断位置
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (ABS(_scBG.contentOffset.y) < 120.0f) {
            [UIView animateWithDuration:0.35 animations:^{
                self.navView.alpha = 1;
                self.viewBG.alpha = 1;
                self.detailBigView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
                _scBG.contentOffset = CGPointZero;
                _scBG.contentInset = UIEdgeInsetsZero;
                [self recoverScrollView];
            }completion:^(BOOL finished) {
                _scBG.contentOffset = CGPointZero;
                _scBG.contentInset = UIEdgeInsetsZero;
            }];
        }else{
            [UIView animateWithDuration:0.35 animations:^{
                //设置移除动画
                CGFloat transformHeight =SCREEN_HEIGHT;
                if (_scBG.contentOffset.y>0) {
                    transformHeight = -transformHeight;
                }
                self.scBG.transform = CGAffineTransformTranslate(self.scBG.transform, self.scBG.contentOffset.x,transformHeight);
                self.detailBigView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
                
            }completion:^(BOOL finished) {
                
                if (self.blockClick) {
                    self.blockClick();
                }
                [self recoverScrollView];
                _scBG.contentInset = UIEdgeInsetsZero;
            }];
        }
    }else{
        //拖拽过程中逐渐改变透明度
        _scBG.contentInset = UIEdgeInsetsMake(-contentOffSetY, 0, 0, 0);
        CGFloat alpha = 1 - 8*ABS(_scBG.contentOffset.y/(_scBG.bounds.size.height));
        self.navView.alpha = alpha;
        self.viewBG.alpha = alpha;
        self.detailBigView.backgroundColor = [UIColor colorWithWhite:0 alpha:alpha];
    }
}

#pragma mark scroll delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.iv;
}

@end


