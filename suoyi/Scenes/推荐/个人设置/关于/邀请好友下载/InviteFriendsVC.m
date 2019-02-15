//
//  InviteFriendsVC.m
//  suoyi
//
//  Created by 王伟 on 2019/2/15.
//  Copyright © 2019 liuhuiping. All rights reserved.
//

#import "InviteFriendsVC.h"
//微信
#import "WXApi.h"
#import <MessageUI/MessageUI.h>
@interface InviteFriendsVC ()<MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong) InviteFriendsView * inviteFriendsView;
@end

@implementation InviteFriendsVC
- (InviteFriendsView *)inviteFriendsView
{
    if (_inviteFriendsView == nil) {
        _inviteFriendsView = [InviteFriendsView new];
        _inviteFriendsView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, _inviteFriendsView.height);
        [_inviteFriendsView.controlWechat addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_inviteFriendsView.personControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_inviteFriendsView.smsControl addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _inviteFriendsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"邀请好友下载" rightView:nil]];
    [self.view addSubview:self.inviteFriendsView];
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [self shareWithWechatType:WXSceneSession];
        }
            break;
        case 2:
        {
            [self shareWithWechatType:WXSceneTimeline];
        }
            break;
        case 3:
        {
            [self shareWithSMS];
        }
            break;
            
        default:
            break;
    }
}
//微信
- (void)shareWithWechatType:(int)type
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        //1.创建多媒体消息结构体
        WXMediaMessage *mediaMsg = [WXMediaMessage message];
        mediaMsg.title = @"所依";//标题
        mediaMsg.description = @"我正在使用所依，小依小依乐趣在家！点击链接下载体验吧";//描述
        [mediaMsg setThumbImage:[UIImage imageNamed:@"12"]];//设置缩略图
        
        //创建网页数据对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = @"https://www.baidu.com";//链接
        mediaMsg.mediaObject = webObj;
        //3.创建发送消息至微信终端程序的消息结构体
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        //多媒体消息的内容
        req.message = mediaMsg;
        //指定为发送多媒体消息（不能同时发送文本和多媒体消息，两者只能选其一）
        req.bText = NO;
        //默认是Session分享给朋友,Timeline是朋友圈,Favorite是收藏
        req.scene = type;
        //发送请求到微信,等待微信返回onResp
        [WXApi sendReq:req];
        
    } else {
        [GlobalMethod showAlert:@"你还没有安装微信"];
    }
}
//短信
- (void)shareWithSMS
{
    if( [MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = @[@" "];//发送短信的号码，数组形式入参
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = @"我正在使用所依，小依小依乐趣在家！点击链接下载体验吧 https://www.baidu.com"; //此处的body就是短信将要发生的内容
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"title"];//修改短信界面标题
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            break;
        default:
            break;
    }
}
@end





@implementation InviteFriendsView
#pragma mark 懒加载
- (UIImageView *)wechatImg{
    if (_wechatImg == nil) {
        _wechatImg = [UIImageView new];
        _wechatImg.image = [UIImage imageNamed:@"about_wechat"];
        _wechatImg.widthHeight = XY(W(50),W(50));
    }
    return _wechatImg;
}
- (UILabel *)wechatLabel{
    if (_wechatLabel == nil) {
        _wechatLabel = [UILabel new];
        [GlobalMethod setLabel:_wechatLabel widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_LABEL text:@""];
    }
    return _wechatLabel;
}
- (UIControl *)controlWechat{
    if (_controlWechat == nil) {
        _controlWechat = [UIControl new];
        _controlWechat.tag = 1;
        _controlWechat.backgroundColor = [UIColor clearColor];
        _controlWechat.widthHeight = XY(W(80),W(80));
    }
    return _controlWechat;
}
- (UIImageView *)personImg{
    if (_personImg == nil) {
        _personImg = [UIImageView new];
        _personImg.image = [UIImage imageNamed:@"pyq"];
        _personImg.widthHeight = XY(W(50),W(50));
    }
    return _personImg;
}
- (UILabel *)personLabel{
    if (_personLabel == nil) {
        _personLabel = [UILabel new];
        [GlobalMethod setLabel:_personLabel widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_LABEL text:@""];
    }
    return _personLabel;
}
- (UIControl *)personControl{
    if (_personControl == nil) {
        _personControl = [UIControl new];
        _personControl.tag = 2;
        _personControl.backgroundColor = [UIColor clearColor];
        _personControl.widthHeight = XY(W(80),W(80));
    }
    return _personControl;
}
- (UIImageView *)smsImg{
    if (_smsImg == nil) {
        _smsImg = [UIImageView new];
        _smsImg.image = [UIImage imageNamed:@"sms"];
        _smsImg.widthHeight = XY(W(50),W(50));
    }
    return _smsImg;
}
- (UILabel *)labelSms{
    if (_labelSms == nil) {
        _labelSms = [UILabel new];
        [GlobalMethod setLabel:_labelSms widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_LABEL text:@""];
    }
    return _labelSms;
}
- (UIControl *)smsControl{
    if (_smsControl == nil) {
        _smsControl = [UIControl new];
        _smsControl.tag = 3;
        _smsControl.backgroundColor = [UIColor clearColor];
        _smsControl.widthHeight = XY(W(80),W(80));
    }
    return _smsControl;
}
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UIImageView *)codeImg{
    if (_codeImg == nil) {
        _codeImg = [UIImageView new];
        _codeImg.image = [UIImage imageNamed:@"12"];
    }
    return _codeImg;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        [GlobalMethod setLabel:_labelTitle widthLimit:0 numLines:0 fontNum:F(13) textColor:COLOR_LABEL text:@""];
    }
    return _labelTitle;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.wechatImg];
    [self addSubview:self.wechatLabel];
    [self addSubview:self.controlWechat];
    [self addSubview:self.personImg];
    [self addSubview:self.personLabel];
    [self addSubview:self.personControl];
    [self addSubview:self.smsImg];
    [self addSubview:self.labelSms];
    [self addSubview:self.smsControl];
    [self addSubview:self.backView];
    [self.backView addSubview:self.codeImg];
    [self.backView addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.wechatImg.centerXTop = XY(SCREEN_WIDTH/6,W(20));
    
    [GlobalMethod resetLabel:self.wechatLabel text:@"微信好友" widthLimit:0];
    self.wechatLabel.centerXTop = XY(self.wechatImg.centerX,self.wechatImg.bottom+W(10));
    
    self.controlWechat.centerXTop = XY(SCREEN_WIDTH/6,W(20));
    
    self.personImg.centerXTop = XY(SCREEN_WIDTH/2,W(20));
    
    [GlobalMethod resetLabel:self.personLabel text:@"朋友圈" widthLimit:0];
    self.personLabel.centerXTop = XY(self.personImg.centerX,self.personImg.bottom+W(10));

    self.personControl.centerXTop = XY(SCREEN_WIDTH/2,W(20));
    
    self.smsImg.centerXTop = XY(SCREEN_WIDTH/6*5,W(20));
    
    [GlobalMethod resetLabel:self.labelSms text:@"短信" widthLimit:0];
    self.labelSms.centerXTop = XY(self.smsImg.centerX,self.smsImg.bottom+W(10));
    
    self.smsControl.centerXTop = XY(SCREEN_WIDTH/6*5,W(20));
    
    self.backView.widthHeight = XY(SCREEN_WIDTH-W(100), SCREEN_WIDTH-W(100));
    self.backView.leftTop = XY(W(50),self.labelSms.bottom+W(20));
    
    self.codeImg.widthHeight = XY(self.backView.width-W(60), self.backView.width-W(60));
    self.codeImg.leftTop = XY(W(30),W(20));
    
    [GlobalMethod resetLabel:self.labelTitle text:@"扫描二维码，下载小度在家应用" widthLimit:0];
    self.labelTitle.centerXTop = XY(self.backView.width/2,self.codeImg.bottom+W(5));
    
    self.height = self.backView.bottom+W(10);
}

@end
