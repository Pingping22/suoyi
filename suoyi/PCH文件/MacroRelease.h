//
//  MacroRelease.h
//  乐销
//
//  Created by 隋林栋 on 2017/6/16.
//  Copyright © 2017年 ping. All rights reserved.
//

#ifndef MacroRelease_h
#define MacroRelease_h

#pragma mark - 请求URL
#if DEBUG
#define URL_HEAD  @"https://ldyxagapi.vx5.cn"//线上库
#else
#define URL_HEAD  @"https://ldyxagapi.vx5.cn"//线上库
#endif

//图片
#define ImageNationURL @"http://sngj.laodao.so/"

#pragma mark - TestVC开启
#if DEBUG
//#define SLD_TEST //开启，app启动跳转TestVC
#endif

#pragma mark - 网易云信
#define NIMSDK_APPKey @"6798a1acaeadef7819f6b6c018d9c6dd"







//环信 config
#define Hyphenate_AppKey @"ldwl#lx"
#if DEBUG
#define Hyphenate_CerName @"dev"//开发证书名称
#else
#define Hyphenate_CerName @"dis"//发布证书名称
#endif

//二维码生成 前缀
#define KEY_CODE_COMPANY_PRE @"LDCompanyID_"//代理商
#define KEY_CODE_STORE_PRE @"LDStoreID_"//零售商

//聊天自定义属性
#define LX_UserName_Key @"LX_UserName"
#define LX_HeadImage_Key @"LX_HeadImage"

//阿里云文件地址
#define ENDPOINT @"http://oss-cn-qingdao.aliyuncs.com"
#define ENDPOINT_VIDEO @"http://oss-cn-beijing.aliyuncs.com"

#define IMAGEURL_HEAD @"http://image.laodao.so"
//微信 appid
#define WXAPPID @"wx51006542f8d27162"

//微博 appid
#define WEIBOAPPID @"2642916705"

//高德地图
#define MAPID @"c5ec022b475f87ef8aa7d447c4698eac"

//阿里云推送
#define ALICLOUD_PUSH_KEY @"24453809"
#define ALICLOUD_PUSH_SCRECT @"dfff00c012fe805f1c2903df87e5fe7b"

//#define APP_SHARE_DELEGATE_URL @"https://itunes.apple.com/cn/app/老刀营销-代理商版/id1228506725?mt=8"
#define APP_SHARE_DELEGATE_URL @"http://lxapi.vx5.cn/Index.html"
//#define APP_SHARE_STORE_URL @"https://itunes.apple.com/us/app/老刀营销/id1288045748?l=zh&ls=1&mt=8"
#define APP_SHARE_STORE_URL @"http://lxapi.vx5.cn/Index.html"

#define SINA_SHARE_TEXT @"项目上线了，大家都在用，赶紧下载用起来!"

#endif /* MacroRelease_h */
