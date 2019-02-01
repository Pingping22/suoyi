//
//  QRCoderVC.m
//  天下农商渠道版
//
//  Created by 刘惠萍 on 2017/6/20.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "QRCoderVC.h"
#import <CommonCrypto/CommonDigest.h>
#import <AudioToolbox/AudioToolbox.h>
//store info vc
//#import "SotreCodeInfoVC.h"
//supplier info vc
//#import "SupplierCodeInfoVC.h"

static const NSInteger LIGHTBTNTAG  = 1;
static const NSInteger QRBTNTAG     = 3;
@interface QRCoderVC ()<UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSTimer *_qrLineTimer;
    UIImageView *_qrLineImageView;
    BOOL isPhoto;
    NSTimer  *_timer;
    CGFloat ImageLineWidth;
    CGFloat ImageLineHeight;
    CGFloat ImageLineTop;
    BOOL stop;
    BOOL openLight;
    NSThread  *thread;
    UIImagePickerController *pickerVC;
    UILabel * lightLabel;
}
@end

@implementation QRCoderVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self judgeCamera];
    stop = NO;
    
    [self startScan];
    
    [self goonSerch];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.captureSession stopRunning];
    
    if ([_qrLineTimer isValid]) {
        [_qrLineTimer invalidate];
        _qrLineTimer=nil;
    }
    
}

- (BOOL)judgeCamera{
    
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        
        return NO;
        
    }
    return YES;
    
}

#pragma mark view did load
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initCapture];
    ImageLineWidth = W(258);
    
    ImageLineHeight = W(258) ;
    ImageLineTop = isIphoneX ? W(166)+W(34):W(166);
    [self initUI];
    [self setNavigationBar];
//    [self creatLightBtn];
    [self registerNotification];
    [self creatImagePicker];
    
     
}

-(void)drawImageViewRect:(UIView *)backView  contentRect:(CGRect)myRect
{
    //中间镂空的矩形框
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:backView.frame cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;//中间镂空的关键点 填充规则
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.3;
    [backView.layer addSublayer:fillLayer];
}

#pragma mark -初始化UI
-(void)initUI{

    [self.view addSubview:^(){
        UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        backView.image = [UIImage imageNamed:@"底图"];
        [self drawImageViewRect:backView contentRect:CGRectMake((SCREEN_WIDTH-ImageLineWidth)/2.0, ImageLineTop, ImageLineWidth, ImageLineWidth)];
        
        UIImageView *borderView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-ImageLineWidth)/2.0, ImageLineTop, ImageLineWidth, ImageLineWidth)];
        borderView.image = [UIImage imageNamed:@"scan_border"];
        [backView addSubview:borderView];
        [backView addSubview:^(){
            UIImage *ImageLine=[UIImage imageNamed:@"线"];
            _qrLineImageView=[[UIImageView alloc] initWithImage:ImageLine];
            _qrLineImageView.frame=CGRectMake((SCREEN_WIDTH-ImageLineWidth)/2.0,ImageLineTop, ImageLineWidth,1);
            _qrLineImageView.tag=109;
            _qrLineImageView.backgroundColor=[UIColor clearColor];
            return _qrLineImageView;
        }()];
        return backView;
        
    }()];
    
    [self.view addSubview:^(){
        UILabel * label = [UILabel new];
        label.text = @"将取景框对准屏幕上的二维码即可扫描";
        label.fontNum = F(14);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label fitVariable:CGFLOAT_MAX];
        label.centerXTop = XY(SCREEN_WIDTH/2.0, ImageLineTop+ImageLineWidth+W(10));
        
        
        return label;
    }()];

    [self.view addSubview:^(){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1;
        [btn addTarget:self action:@selector(btnCli:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(14)];
        [btn setTitle:@"输入视频号码/验证码" forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        btn.widthHeight = XY(SCREEN_WIDTH,W(20));
        btn.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-W(20));
        return btn;
    }()];
}
#pragma mark 点击事件
- (void)btnCli:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [GB_Nav pushVCName:@"AddFacilityVC" animated:true];
        }
            break;
            
        default:
            break;
    }
}
#pragma  mark - 添加通知
-(void)registerNotification{

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:@"applicationDidBecomeActive" object:nil];
    
}
#pragma mark - 加载ImgPickerVC
-(void)creatImagePicker{

     thread = [[NSThread alloc] initWithTarget:self selector:@selector(initImgPicker) object:nil];
     [thread start];
}
     
 -(void)initImgPicker
{
    if (pickerVC==nil) {
        pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.delegate = self;
        pickerVC.allowsEditing = false;
        
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if([pickerVC.navigationBar respondsToSelector:@selector(setTintColor:)])
        {
            [pickerVC.navigationBar setTintColor:COLOR_LABEL];
        }
    }
}


- (void)goonSerch{
    
    _qrLineImageView.hidden = NO;

    
    [self.captureSession startRunning];
    
}
- (void)showSerchView{
    
    if(stop){
        
        stop = NO;
        [self.captureSession stopRunning];
        _qrLineImageView.hidden = YES;
        
    }else{
        
        stop = YES;
    }
    
    
}
//设置导航内容
- (void)setNavigationBar{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"添加" rightView:nil]];
}
//按钮点击事件
- (void)btnClick:(UIButton *)btn{
            Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
            if (captureDeviceClass != nil) {
                AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                if ([device hasTorch] && [device hasFlash]){
                    [device lockForConfiguration:nil];
                    
                    if (openLight) {
                        openLight = NO;
                        [device setTorchMode:AVCaptureTorchModeOff];
                        [device setFlashMode:AVCaptureFlashModeOff];
                        
                    } else {
                        openLight = YES;
                        [device setTorchMode:AVCaptureTorchModeOn];
                        [device setFlashMode:AVCaptureFlashModeOn];
                        
                    }
                     [self changeLightBtnAndLabel:openLight];
                    [device unlockForConfiguration];
                }
            }
}


//设置控制灯光按钮 本地扫描二维码按钮
- (void)creatLightBtn{
    [self.view addSubview:^(){
        UIView *backV = [UIView new];
        backV.frame=CGRectMake(0, SCREEN_HEIGHT-W(84),SCREEN_WIDTH, W(84));
        backV.backgroundColor = [UIColor blackColor];
        
        [backV addSubview:^(){
            UIButton *photoLibraryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            photoLibraryBtn.frame = CGRectMake((SCREEN_WIDTH-W(30)*2)/3*2+W(30), W(16), W(30), W(30));
            photoLibraryBtn.tag = QRBTNTAG;
            [photoLibraryBtn setImage:[UIImage imageNamed:@"相册"] forState:UIControlStateNormal];
            [photoLibraryBtn setImage:[UIImage imageNamed:@"相册"] forState:UIControlStateHighlighted];
            [photoLibraryBtn addTarget:self action:@selector(pressPhotoLibraryButton:) forControlEvents:(UIControlEventTouchUpInside)];
            return photoLibraryBtn;
        }()];
        
        [backV addSubview:^(){
            UIButton *photoLibraryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            photoLibraryBtn.frame = CGRectMake((SCREEN_WIDTH-W(30)*2)/3, W(16), W(30), W(30));
            photoLibraryBtn.tag = LIGHTBTNTAG;
            [photoLibraryBtn setImage:[UIImage imageNamed:@"手电筒"] forState:UIControlStateNormal];
            [photoLibraryBtn setImage:[UIImage imageNamed:@"手电筒选中"] forState:UIControlStateHighlighted];
            [photoLibraryBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            return photoLibraryBtn;
        }()];
        
        [backV addSubview:^(){
            lightLabel = [UILabel new];
            lightLabel.text = @"手电筒";
            lightLabel.fontNum = F(14);
            lightLabel.textColor = [UIColor whiteColor];
            lightLabel.textAlignment = NSTextAlignmentCenter;
            [lightLabel fitVariable:W(60)];
            lightLabel.centerXTop = XY([backV viewWithTag:LIGHTBTNTAG].center.x, backV.height-W(30));
            return lightLabel;
        }()];

        
        [backV addSubview:^(){

            UILabel * photoLibraryLabel = [UILabel new];
            photoLibraryLabel.text = @"相册";
            photoLibraryLabel.fontNum = F(14);
            photoLibraryLabel.textColor = [UIColor whiteColor];
            photoLibraryLabel.textAlignment = NSTextAlignmentCenter;
            [photoLibraryLabel fitVariable:W(60)];
            photoLibraryLabel.centerXTop = XY([backV viewWithTag:QRBTNTAG].center.x, backV.height-W(30));
            return photoLibraryLabel;
        }()];
        return backV;
    }()];
    
}
#pragma mark 照片处理
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
#pragma  mark - 获取图片信息
-(void)getImageInfo:(UIImage *)pickImage{
    
    
    NSData *imageData = UIImagePNGRepresentation(pickImage);
    
    CIImage *ciImage = [CIImage imageWithData:imageData];
    
    // 2.从选中的图片中读取二维码数据
    // 2.1创建一个探测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    
    // 2.2利用探测器探测数据
    NSArray *feature = [detector featuresInImage:ciImage];
    
    // 2.3取出探测到的数据
//    for (CIQRCodeFeature *result in feature) {
//        NSLog(@"%@",result.messageString);
//    }
    
    CIQRCodeFeature *result = feature.firstObject;
    [self handleCodeInfo:result.messageString];
}


/**
 *  开始二维码扫描
 */
- (void)startScan
{
    _qrLineImageView.hidden = NO;
    if (_qrLineTimer) {
        [_qrLineTimer invalidate];
        _qrLineTimer = nil;
    }
    _qrLineTimer=[NSTimer scheduledTimerWithTimeInterval:1.5
                                                  target:self
                                                selector:@selector(changeQrLineFrame)
                                                userInfo:nil repeats:YES];
    
}

-(void)changeQrLineFrame{
    
    _qrLineImageView.frame=CGRectMake((SCREEN_WIDTH-ImageLineWidth)/2.0,ImageLineTop, ImageLineWidth,1);
    [UIView beginAnimations:@"change" context:nil];
    [UIView setAnimationDuration:1.5];
    _qrLineImageView.image = [UIImage imageNamed:@"线"];
    _qrLineImageView.frame=CGRectMake((SCREEN_WIDTH-ImageLineWidth)/2.0,ImageLineTop+ImageLineWidth-5, ImageLineWidth,1);
    [UIView commitAnimations];
    
    
}

#pragma mark -跳转相册
- (void)pressPhotoLibraryButton:(UIButton *)button
{
    
    openLight = NO;
    [self changeLightBtnAndLabel:openLight];
    if ([thread isFinished]) {
       
        [self presentViewController:pickerVC animated:YES completion:nil];
    }else{
        NSLog(@"加载未完成");
    }
  
    [self.captureSession stopRunning];
}

- (void)pressCancelButton:(UIButton *)button
{

    [self.captureSession stopRunning];
    
    
    if ([_qrLineTimer isValid]) {
        [_qrLineTimer invalidate];
        _qrLineTimer=nil;
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - 初始化扫码捕获
- (void)initCapture
{
    self.captureSession = [[AVCaptureSession alloc] init];
    [GlobalMethod asynthicBlock:^{
        
    }];
    AVCaptureDevice* inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    
    if (!error) {
        
        [self.captureSession removeInput:captureInput];
        
        [self.captureSession addInput:captureInput];
    }else{
        return;
    }
    
    AVCaptureMetadataOutput *_output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [self.captureSession addOutput:_output];
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    if (!self.captureVideoPreviewLayer) {
        self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    }
    
    self.captureVideoPreviewLayer.frame = self.view.bounds;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer: self.captureVideoPreviewLayer];

    [self.captureSession startRunning];
    
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
    [self handleCodeInfo:metadataObject.stringValue];
}
-(void)stopRunCloseLight{
    openLight = NO;
     [self changeLightBtnAndLabel:openLight];
    
}
//图像选取器的委托方法，选完图片后回调该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];裁剪后的图片
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//原始图片
    
    isPhoto=YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self getImageInfo:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.captureSession startRunning];
            
        });
    }];
    
    
}
-(void)decoderFailedCallBack
{
    //    DDLogInfo(@"fail==decoderFailedCallBack");
    if (isPhoto) {
        [GlobalMethod showAlert:@"非二维码图片，请重新选择"];
    }
}

- (void)decoderSucceedCallBack:(NSString *)decoderResultText
{
    [self.captureSession stopRunning];
    
}

-(void)applicationDidBecomeActive{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch] && [device hasFlash]){
        [device lockForConfiguration:nil];
         [self changeLightBtnAndLabel:openLight];
        if (openLight) {
            [device setTorchMode:AVCaptureTorchModeOn];
            [device setFlashMode:AVCaptureFlashModeOn];
        }else{
            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
        }
    }
}

#pragma mark 跳转零售商页面
- (void)handleCodeInfo:(NSString *)stringValue{
    if (!isStr(stringValue)) {
        [GlobalMethod showAlert:@"此二维码不是有效二维码"];
        return;
    }
    
    if([stringValue rangeOfString:KEY_CODE_STORE_PRE].location !=NSNotFound){
        stringValue = [stringValue stringByReplacingOccurrencesOfString:KEY_CODE_STORE_PRE withString:@""];
        [self.captureSession stopRunning];
        [self stopRunCloseLight];
//        SotreCodeInfoVC * sDetailVC=[SotreCodeInfoVC new];
//        sDetailVC.storeID = stringValue;
//        [GB_Nav popLastAndPushVC:sDetailVC];
        return;
    }else if([stringValue rangeOfString:KEY_CODE_COMPANY_PRE].location != NSNotFound){
        stringValue = [stringValue stringByReplacingOccurrencesOfString:KEY_CODE_COMPANY_PRE withString:@""];
        [self.captureSession stopRunning];
        [self stopRunCloseLight];
//        SupplierCodeInfoVC * sDetailVC=[SupplierCodeInfoVC new];
//        sDetailVC.codeNumber = stringValue;
//        [GB_Nav popLastAndPushVC:sDetailVC];
        return;
    }
}
#pragma mark - 改变手电筒状态
-(void)changeLightBtnAndLabel:(BOOL)result{
    UIButton *lightBtn = [self.view viewWithTag:LIGHTBTNTAG];
    if (result) {
        lightBtn.selected = YES;
        lightLabel.textColor = COLOR_LABEL;
    }else{
        lightBtn.selected = NO;
        lightLabel.textColor = [UIColor whiteColor];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidBecomeActive" object:nil];

}






@end

