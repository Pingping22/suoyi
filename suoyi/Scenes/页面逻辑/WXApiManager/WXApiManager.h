//
//  WXApiManager.h
//  天下农商渠道版
//
//  Created by 刘京涛 on 2017/7/14.
//  Copyright © 2017年 Sl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
////model
//#import "ModelWXApiReq.h"

typedef NS_ENUM(NSUInteger, ENUM_WXPAY_TYPE) {
    ENUM_WXPAY_TYPE_ORDER,
    ENUM_WXPAY_TYPE_RECHARGE,
    ENUM_WXPAY_TYPE_SEND_REDPACKET,
    ENUM_WXPAY_TYPE_WITHDRAW_SELF,
    ENUM_WXPAY_TYPE_PURCHASE//采购单
};

@interface WXApiManager : NSObject<WXApiDelegate>
@property (nonatomic, strong) NSString * orderID;
@property (nonatomic, copy) void (^WXPayBack)(int);
@property (nonatomic, copy) void (^WXPayBindBack)(NSString *);
@property (nonatomic, assign) ENUM_WXPAY_TYPE type;
//单例
+ (instancetype)sharedManager;
//注册
+ (void)registerApp;
//ModelWXApiReq
//- (void)WXPayFrom:(ModelWXApiReq *)model;
/**
 @param OrderID  个人充值
 */
-(void)getOrderWeiXinPayInfoFromPayRecharge:(NSString *)rechargeID payAmount:(double)amount wxPayBack:(void (^)(int))block;
/**
 获取微信支付商户信息
 @param OrderID 采购单 付款单号
 */
-(void)getOrderWeiXinPayInfoFromPurchaseOrderID:(NSString *)OrderID wxPayBack:(void (^)(int))block;
/**
 @param OrderID 发红包单号
 */
-(void)getOrderWeiXinPayInfoFromPayRedPacked:(NSString *)OrderID wxPayBack:(void (^)(int))block;
/**
 绑定微信

 @param block 回调
 */
-(void)bindingWX:(void (^)(NSString *))block;
@end
