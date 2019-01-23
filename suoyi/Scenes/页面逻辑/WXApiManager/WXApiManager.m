//
//  WXApiManager.m
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/7/14.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import "WXApiManager.h"


@implementation WXApiManager
+ (void)registerApp{
    //注册微信
   [WXApi registerApp:WXAPPID];

}
#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        payResoult = @"支付";
        if (resp.errCode == WXSuccess) {
            [self checkPayStatus];
        }
        
    }else if ([resp isKindOfClass:[SendAuthResp class]])
    {
        payResoult = @"绑定";
        if (resp.errCode == WXSuccess) {
            SendAuthResp * res = (SendAuthResp*)resp;
            if (res.code && self.WXPayBindBack)
            {
                self.WXPayBindBack(res.code);
            }
        }
    }else if ([resp isKindOfClass:[SendMessageToWXResp class]]){
        payResoult = @"分享";
    }
    [GlobalMethod showAlert:[self getTipStringWXErrCode:resp tipString:payResoult]];
    if (resp.errCode!=0 && self.WXPayBack) {
        self.WXPayBack(resp.errCode);
    }
}

-(NSString *)getTipStringWXErrCode:(BaseResp *)resp  tipString:(NSString *)typeStr{
    NSString *resoult = [NSString stringWithFormat:@"errcode:%d",resp.errCode];
    switch (resp.errCode) {
        case WXSuccess:{
            resoult = [NSString stringWithFormat:@"%@成功!",UnPackStr(typeStr)] ;
        }
            break;
        case WXErrCodeCommon:
            resoult = [NSString stringWithFormat:@"%@结果:失败!",UnPackStr(typeStr)];
            break;
        case WXErrCodeUserCancel:
            resoult = [NSString stringWithFormat:@"用户已经退出%@!",UnPackStr(typeStr)];
            break;
        case WXErrCodeSentFail:
            resoult = @"发送失败";
            break;
        case WXErrCodeAuthDeny:
            resoult = @"授权失败";
            break;
        case WXErrCodeUnsupport:
            resoult = @"微信不支持";
            break;
        default:
            resoult = [NSString stringWithFormat:@"%@结果：失败！retcode = %d, retstr = %@",UnPackStr(typeStr),resp.errCode,resp.errStr];
            break;
    }
    return resoult;
    
}



-(void)checkPayStatus{
    
}

- (void)onReq:(BaseReq *)req {

    
}
//
//- (void)WXPayFrom:(ModelWXApiReq *)model{
//        //需要创建这个支付对象
//        PayReq *req   = [[PayReq alloc] init];
//        //由用户微信号和AppID组成的唯一标识，用于校验微信用户
//        req.openID = UnPackStr(model.appid);
//
//        // 商家id，在注册的时候给的
//        req.partnerId =UnPackStr(model.partnerid);
//
//        // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
//        req.prepayId  = UnPackStr(model.prepayid);
//
//        // 根据财付通文档填写的数据和签名
//        //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
//        req.package   = UnPackStr(model.package);
//
//        // 随机编码，为了防止重复的，在后台生成
//        req.nonceStr  = UnPackStr(model.noncestr);
//
//        // 这个是时间戳，也是在后台生成的，为了验证支付的
//        NSString * stamp = UnPackStr(model.timestamp);
//        req.timeStamp = stamp.intValue;
//
//        // 这个签名也是后台做的
//        req.sign = UnPackStr(model.sign);
//        //发送请求到微信，等待微信返回onResp
//        BOOL isSucces=[WXApi sendReq:req];
//        NSLog(@"isSucces === %d",isSucces);
//}

-(void)callWXClient:(void(^)(void))block{
    if ([WXApi isWXAppInstalled]) {
        if ([WXApi isWXAppSupportApi]) {
            if (block) {
                block();
            }
        }else{
            [GlobalMethod showAlert:@"请安装最新版微信客户端"];
        }
    }else{
        [GlobalMethod showAlert:@"请安装微信客户端后支付"];
    }
}

#pragma mark -绑定微信
-(void)bindingWX:(void (^)(NSString *))block{
    self.WXPayBindBack = block;
    //绑定微信
    [self callWXClient:^{
        SendAuthReq* req =[[SendAuthReq alloc ] init];
        req.scope = @"snsapi_userinfo" ;
        req.state = @"所依";
        [WXApi sendReq:req];
    }];
}
@end
