//
//  JVCFeedbackController.h
//  CloudSEENew
//
//  Created by Joey on 16/6/21.
//  Copyright © 2016年 baoym. All rights reserved.
//

#import "BaseTableVC.h"
//view
#import "PlaceHolderTextView.h"

@interface LDFeedbackController : BaseTableVC

@end


@interface FeedbackHeaderView : UIView<UITextViewDelegate>
//属性

@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelTip;
@property (strong, nonatomic) PlaceHolderTextView *textView;

#pragma mark 刷新view
- (void)resetView;
@end


@interface FeedbackFooterView : UIView<UITextFieldDelegate>
//属性

@property (strong, nonatomic) UILabel *labelTitle;
@property (nonatomic,strong) UITextField*textfield;
@property (strong, nonatomic) UILabel *labelTip;
#pragma mark 刷新view
- (void)resetView;
@end
