//
//  BtottomGreensView.m
//  乐销
//
//  Created by 隋林栋 on 2017/4/6.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "BottomGreensView.h"


@implementation BottomGreensView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.height = W(60);
        self.width = SCREEN_WIDTH;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)resetWithModels:(NSArray *)aryModelBtn target:(id)target selector:(NSString *)selector{
    [self removeAllSubViews];
    
    UIView * viewGreenBG = [[UIView alloc]initWithFrame:CGRectInset(self.bounds, W(15), W(10))];
    viewGreenBG.backgroundColor = COLOR_GREEN;
    [GlobalMethod setRoundView:viewGreenBG color:[UIColor clearColor] numRound:5 width:0];
    [self addSubview:viewGreenBG];
    
    CGFloat x = 0;
    CGFloat width = viewGreenBG.width/aryModelBtn.count;
    for (int i = 0; i< aryModelBtn.count; i++) {
        ModelBtn * modelBtn  = aryModelBtn[i];
        UIButton * btnModel = [UIButton buttonWithType:UIButtonTypeCustom];
        btnModel.tag = modelBtn.tag;
        [btnModel addTarget:target action:NSSelectorFromString(selector) forControlEvents:UIControlEventTouchUpInside];
        btnModel.backgroundColor = [UIColor clearColor];
        btnModel.titleLabel.font = [UIFont systemFontOfSize:W(18)];
        [btnModel setTitle:modelBtn.title forState:(UIControlStateNormal)];
        btnModel.frame = CGRectMake(x, 0, width, viewGreenBG.height);
        if (i != aryModelBtn.count - 1) {
            [viewGreenBG  addLineFrame:CGRectMake(btnModel.right-1, W(5), 1, viewGreenBG.height - W(10)) color:[UIColor whiteColor]];
        }
        [viewGreenBG addSubview:btnModel];
        x = btnModel.right;
        
    }
    
}

@end
