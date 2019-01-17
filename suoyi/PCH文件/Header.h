//
//  Header.h
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#ifndef Header_h
#define Header_h

//结构体
struct STRUCT_XY {
    CGFloat horizonX;
    CGFloat verticalY;
};
typedef struct STRUCT_XY STRUCT_XY;
CG_INLINE STRUCT_XY
XY(CGFloat horizonX, CGFloat verticalY)
{
    STRUCT_XY size; size.horizonX = horizonX; size.verticalY = verticalY; return size;
}

//消除 PrExFristor可能导致泄漏，因为它的选择器未知，警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#endif /* Header_h */
