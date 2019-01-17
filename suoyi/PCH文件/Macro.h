//
//  Macro.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//weak_self宏定义
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong self = weakSelf;

#define isIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define isIphone5  ([UIScreen mainScreen].bounds.size.width == 320)
#define isIphone6  ([UIScreen mainScreen].bounds.size.width == 375)
#define isIphone6p ([UIScreen mainScreen].bounds.size.width == 414)
#define isIphoneXSERIES  ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NAVIGATIONBAR_HEIGHT (64.0f+(isIphoneXSERIES?24.0f:0.0f)) //导航条的高度
#define TABBAR_HEIGHT        (isIphoneXSERIES?83.0f:49.0f)  //工具栏高度
#define STATUSBAR_HEIGHT     (isIphoneXSERIES?44.0f:20.0f) //状态栏高度

#define W(n)  ((n)* [UIScreen mainScreen].bounds.size.width / 375.0f)
#define F(n)  (([UIScreen mainScreen].bounds.size.width == 320)?(n-1):([UIScreen mainScreen].bounds.size.width == 375)?(n):([UIScreen mainScreen].bounds.size.width == 414)?(n+1):(n+2))
#define H(n)  (n*[UIScreen mainScreen].bounds.size.height / 667.0f)

//判断
#define isStr(T) ((T) && [(T) isKindOfClass:[NSString class]] && (T).length >0)
#define isStrIsValidDou(T) ((T) && [(T) isKindOfClass:[NSString class]] && [(T) doubleValue])
#define isDou(T) ([(T) doubleValue])
#define isAry(T) ((T) && [(T) isKindOfClass:[NSArray class]] && (T).count > 0)
#define isNum(T) ((T) && [(T) isKindOfClass:[NSNumber class]])
#define isDic(T) ((T) && [(T) isKindOfClass:[NSDictionary class]] && [(T) count] >0)

//解包
#define UnPackStr(T)   (((T)&&([(T) isKindOfClass:NSString.class]||[(T) isKindOfClass:NSNumber.class]))?(T):@"")
//封装
#define strDotF(T) [NSString stringWithFormat:@"%.f",(T)]
#define strF(T) [NSString stringWithFormat:@"%lf",(T)]
#define strDot2F(T) [NSString stringWithFormat:@"%.2f",(T)]

//颜色
#define COLOR_TABBAR_SELECT   [UIColor colorWithHexString:@"#46BC62"]
#define COLOR_TABBAR_UNSELECT [UIColor colorWithHexString:@"#7A7E81"]
#define COLOR_NAV_COLOR       [UIColor colorWithHexString:@"#46BC62"]
#define COLOR_GREEN           [UIColor colorWithHexString:@"#00aa98"]
#define COLOR_LABEL           [UIColor colorWithHexString:@"#333333"]
#define COLOR_DETAIL          [UIColor colorWithHexString:@"#666666"]
#define COLOR_BACKGROUND      [UIColor colorWithHexString:@"#EFEFF4"]
#define COLOR_LINE            [UIColor colorWithHexString:@"#E0E0E0"]

#define UIColorFromHexRGB(rgbValue)  ^(){\
unsigned int hexNumber;\
sscanf([[rgbValue stringByReplacingOccurrencesOfString:@"#" withString:@"0x"] cStringUsingEncoding:NSUTF8StringEncoding], "%x", &hexNumber);\
return [UIColor colorWithRed:((float)((hexNumber & 0xFF0000) >> 16))/255.0 green:((float)((hexNumber & 0xFF00) >> 8))/255.0 blue:((float)(hexNumber & 0xFF))/255.0 alpha:1.0];\
}()

//默认图片
#define IMAGE_HEAD_DEFAULT    @"默认"


//Tag
#define TAG_LINE 371  //要移除的横线
#define TAG_KEYBOARD 372

//request
#define RESPONSE_DATA @"datas"//网络请求datas
#define RESPONSE_MESSAGE @"msg"//网络请求message
#define RESPONSE_CODE @"code"//网络请求提示码
#define RESPONSE_CODE_200 @(200)//请求成功
#define RESPONSE_CODE_NEGATIVE100 @(11001)//重新登陆
#define TIME_REQUEST_OUT 8








#endif /* Macro_h */
