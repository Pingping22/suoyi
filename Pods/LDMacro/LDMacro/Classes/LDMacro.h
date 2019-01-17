//
//  LDMacro.h
//  LDMacro
//
//  Created by 隋林栋 on 2018/3/19.
//

#ifndef LDMacro_h
#define LDMacro_h

//weakself strongSelf
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong self = weakSelf;

//screen width height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//nav height
#define NAVIGATIONBAR_HEIGHT (64.0f+(([UIScreen mainScreen].bounds.size.height == 812)?24.0f:0.0f)) //导航条的高度
#define TABBAR_HEIGHT        (([UIScreen mainScreen].bounds.size.height == 812)?83.0f:49.0f)  //工具栏高度
#define STATUSBAR_HEIGHT     (([UIScreen mainScreen].bounds.size.height == 812)?44.0f:20.0f) //状态栏高度

//adapt
#define W(n)  ((n)* [UIScreen mainScreen].bounds.size.width / 375.0f)
#define F(n)  (([UIScreen mainScreen].bounds.size.width == 320)?(n-1):([UIScreen mainScreen].bounds.size.width == 375)?(n):([UIScreen mainScreen].bounds.size.width == 414)?(n+1):(n+2))
#define H(n)  (n*[UIScreen mainScreen].bounds.size.height / 667.0f)

#endif /* LDMacro_h */
