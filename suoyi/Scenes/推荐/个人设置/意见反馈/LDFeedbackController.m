//
//  JVCFeedbackController.m
//  CloudSEENew
//
//  Created by Joey on 16/6/21.
//  Copyright © 2016年 baoym. All rights reserved.
//

#import "LDFeedbackController.h"
////获取地理位置
//#import "BaseVC+Location.h"
#import <AFNetworking.h>
//keyboark observe


static const NSInteger WORDLIMIT  = 150;
@interface LDFeedbackController ()
{
    
    UILabel *numLable;
    
}
@property(nonatomic,strong) FeedbackHeaderView *headerView;
@property(nonatomic,strong) FeedbackFooterView *footerView;
@property(nonatomic,strong) NSString  *currentContent;//当前发送内容
@property(nonatomic,strong) NSString  *currentIP;//当前公网IP
@property(nonatomic,strong) NSString  *currentNetWork;//当前网络
@end

@implementation LDFeedbackController

-(FeedbackHeaderView *)headerView{
    if (!_headerView) {
        _headerView= [FeedbackHeaderView new];
        [_headerView resetView];
    }
    return _headerView;
}

-(FeedbackFooterView *)footerView{
    if (!_footerView) {
        _footerView= [FeedbackFooterView new];
        [_footerView resetView];
    }
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.separatorStyle =NO;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self setNavigationBar];
    [self listenNetWorkingStatus];
    //add keyboard observe
    [self addObserveOfKeyboard];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getPublicIPAddress];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopReachabilityMonitoring];
}

//发送按钮
- (void)setNavigationBar{
   BaseNavView * navView =   [BaseNavView initNavBackTitle:@"意见反馈" rightView:^(){
        UIButton *sendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        sendBtn.frame = CGRectMake( SCREEN_WIDTH-60, 20, 60, 44);
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
        [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        sendBtn.titleLabel.fontNum = F(16);
        return sendBtn;
    }()];
    [self.view addSubview:navView];

}

#pragma mark - 网络监听
-(void)listenNetWorkingStatus{
    //1:创建网络监听者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //开启网络监听
    [manager startMonitoring];
    //2:获取网络状态
    /*
     AFNetworkReachabilityStatusUnknown          = 未知网络，
     AFNetworkReachabilityStatusNotReachable     = 没有联网
     AFNetworkReachabilityStatusReachableViaWWAN = 蜂窝数据
     AFNetworkReachabilityStatusReachableViaWiFi = 无线网
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.currentNetWork =@"未知网络";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.currentNetWork =@"没有联网";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.currentNetWork =@"蜂窝数据";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.currentNetWork =@"wifi";
                break;
            default:
                break;
        }
    }];
   
}

/**
 * 关闭网络状态监听
 */
- (void)stopReachabilityMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

-(void)getPublicIPAddress{
 

    [GlobalMethod asynthicBlock:^{
        NSError *error;
        NSURL *ipURL = [NSURL URLWithString:@"https://pv.sohu.com/cityjson?ie=utf-8"];
        
        NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
        //判断返回字符串是否为所需数据
        if ([ip hasPrefix:@"var returnCitySN = "] && !error) {
            //对字符串进行处理，然后进行json解析
            //删除字符串多余字符串
            NSRange range = NSMakeRange(0, 19);
            [ip deleteCharactersInRange:range];
            NSString * nowIp =[ip substringToIndex:ip.length-1];
            //将字符串转换成二进制进行Json解析
            NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dict);
            self.currentIP = dict[@"cip"] ? dict[@"cip"] : @"";
            
        }
    }];
    
}

- (void)sendBtnAction{
    
    [self.view endEditing:YES];
    
    if (!isStr(self.headerView.textView.text) ) {
        [GlobalMethod showAlert:@"请输入反馈内容"];
        return;
    }

//    if (!isStr(self.footerView.textfield.text) ) {
//        [GlobalMethod showAlert:@"请输入联系方式"];
//        return;
    //    }
    
    if ([self.currentContent isEqualToString:self.headerView.textView.text]) {
        [GlobalMethod showAlert:@"请不要重复发送"];
        return;
    }
    
    NSString* systemVersion = [NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]];//系统版本
    
    NSString* deviceModel = [GlobalMethod LookDeviceName];//设备名称
    NSString *app_Version = [GlobalMethod getVersion];
//    [RequestApi requestSendFeedBackWithBackContent:self.headerView.textView.text contact:self.footerView.textfield.text sysVersion:systemVersion versionCode:app_Version mobileType:deviceModel networkType:self.currentNetWork ipAddress:self.currentIP delegate:self success:^(NSDictionary *response, id mark) {
//        self.currentContent = self.headerView.textView.text;
//        [GlobalMethod showAlert:@"发送成功"];
//    } failure:^(NSString *errorStr, id mark) {
//        [GlobalMethod showAlert:@"发送失败"];
//    }];

}


@end


@implementation FeedbackHeaderView
#pragma mark 懒加载

- (UILabel *)labelTip{
    if (_labelTip == nil) {
        _labelTip = [UILabel new];
        _labelTip.textColor = COLOR_LABEL;
        _labelTip.fontNum = F(14);
        _labelTip.numberOfLines = 0;
        _labelTip.lineSpace = 0;
        _labelTip.textAlignment = NSTextAlignmentRight;
        
    }
    return _labelTip;
}
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.widthHeight = XY(SCREEN_WIDTH - W(30), W(140));
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = COLOR_LABEL;
        _textView.font = [UIFont systemFontOfSize:F(15)];
        _textView.scrollEnabled = false;
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), -W(5), 0, -W(5));
        _textView.delegate = self;
        WEAKSELF
        _textView.blockTextChange = ^(PlaceHolderTextView *textView) {
//            weakSelf.ur = textView.text;
        };
        _textView.blockHeightChange  = ^(PlaceHolderTextView *textView) {
            if (weakSelf.textView.numTextHeight>W(140)) {
                weakSelf.textView.height = weakSelf.textView.numTextHeight;
                [weakSelf resetView];
                BaseTableVC * tableVC = (BaseTableVC *)[weakSelf fetchVC];
                if ([tableVC isKindOfClass:BaseTableVC.class]) {
                    [tableVC.tableView reloadData];
                }
            }
           
        };
    }
    return _textView;
}

- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_LABEL;
        _labelTitle.fontNum = F(16);
        _labelTitle.numberOfLines = 1;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
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
    [self addSubview:self.labelTip];
    [self addSubview:self.textView];
    
    //初始化页面
    [self createView];
}

#pragma mark 刷新view
- (void)createView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    [self.labelTitle fitTitle:@"问题详情:" variable:SCREEN_WIDTH - W(30)];
    self.labelTitle.leftTop = XY(W(15),W(15));
    
    [self.labelTip fitTitle:[NSString stringWithFormat:@"0/%ld",(long)WORDLIMIT] fixed:SCREEN_WIDTH-W(30)];
    [GlobalMethod setLabel:_textView.placeHolder widthLimit:self.textView.width  numLines:0 fontNum:F(15) textColor:[UIColor lightGrayColor] text:@"请尽量详细描述反馈，我们会在第一时间帮您解决问题。"];
    self.textView.leftTop = XY(W(15), [self addLineFrame:CGRectMake(0, self.labelTitle.bottom+W(10), SCREEN_WIDTH, 1)]+W(15));
    
    self.labelTip.rightTop = XY(SCREEN_WIDTH-W(15),self.textView.bottom+W(5));
    
    self.height = [self addLineFrame:CGRectMake(W(0), self.labelTip.bottom+W(15), SCREEN_WIDTH , 1)];
    
}

-(void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.textView.leftTop = XY(W(15), [self addLineFrame:CGRectMake(0, self.labelTitle.bottom+W(10), SCREEN_WIDTH, 1)]+W(15));
    
    self.labelTip.rightTop = XY(SCREEN_WIDTH-W(15),self.textView.bottom+W(5));
    
    self.height = [self addLineFrame:CGRectMake(W(0), self.labelTip.bottom+W(15), SCREEN_WIDTH , 1)];
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    NSString *text = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (text.length >WORDLIMIT ) {
    
                 [GlobalMethod showAlert:[NSString stringWithFormat:@"最多不超过%ld字",WORDLIMIT]];
                textView.text = [text substringToIndex:WORDLIMIT];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
        NSInteger num = WORDLIMIT-text.length;
        
        if(num<0||num==0){
            
            self.labelTip.text = @"字数已达上限";
            
            
        }else{
            
            self.labelTip.text = [NSString stringWithFormat:@"%ld/%ld",(unsigned long)text.length,(long)WORDLIMIT];
            
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        NSInteger num = WORDLIMIT-text.length;
        
        if(num<0||num==0){
            
            self.labelTip.text = @"字数已达上限";
            
        }else{
            
            self.labelTip.text = [NSString stringWithFormat:@"%ld/%ld",(unsigned long)text.length,(long)WORDLIMIT];
            
        }
        
        if(text.length>WORDLIMIT){
            [GlobalMethod showAlert:[NSString stringWithFormat:@"最多不超过%ld字",WORDLIMIT]];
            textView.text = [text substringToIndex:WORDLIMIT];
            
        }
    }
    
}

//实现UITextView的代理

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text

{
    
    if ([text isEqualToString:@"\n"]) {
        
        [self.textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}

@end



@implementation FeedbackFooterView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_LABEL;
        _labelTitle.fontNum = F(16);
        _labelTitle.numberOfLines = 1;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}

- (UITextField *)textfield{
    if (_textfield == nil) {
        _textfield = [UITextField new];
        _textfield.backgroundColor = [UIColor whiteColor];
        _textfield.textColor = COLOR_LABEL;
        _textfield.font = [UIFont systemFontOfSize:F(15)];
        _textfield.delegate = self;
        _textfield.returnKeyType = UIReturnKeyDone;
        _textfield.keyboardType =  UIKeyboardTypeEmailAddress;
    }
    return _textfield;
}



- (UILabel *)labelTip{
    if (_labelTip == nil) {
        _labelTip = [UILabel new];
        _labelTip.textColor = COLOR_DETAIL;
        _labelTip.fontNum = F(13);
        _labelTip.numberOfLines = 0;
        _labelTip.lineSpace = 0;
    }
    return _labelTip;
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
    [self addSubview:self.textfield];
    [self addSubview:self.labelTip];
    //初始化页面
    [self resetView];
}

#pragma mark 刷新view
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    [self.labelTitle fitTitle:@"联系方式:" variable:SCREEN_WIDTH - W(30)];
    self.labelTitle.leftTop = XY(W(15),W(15));
    
    
    self.textfield.leftTop = XY(W(15), [self addLineFrame:CGRectMake(0, self.labelTitle.bottom+W(10), SCREEN_WIDTH, 1)]);
    self.textfield.widthHeight = XY(SCREEN_WIDTH - W(30), W(44));
    self.textfield.placeholder = @"请输入手机号码、邮箱或者QQ号码等联系方式";
  
    
    [self.labelTip fitTitle:@"联系方式有助于我们沟通和解决问题,仅工作人员可见。" variable:SCREEN_WIDTH-W(30)];
    self.labelTip.leftTop = XY(W(15),[self addLineFrame:CGRectMake(W(0), self.textfield.bottom, SCREEN_WIDTH , 1)]+W(10));
    
    self.height = self.labelTip.bottom;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

