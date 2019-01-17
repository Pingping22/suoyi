//
//  GlobalData.m
//  lanberProject
//
//  Created by lirenbo on 2018/5/18.
//  Copyright © 2018年 lirenbo. All rights reserved.
//

#import "GlobalData.h"

UINavigationController * GB_Nav = nil;

@implementation GlobalData

@synthesize GB_Key = _GB_Key;
@synthesize GB_UserModel = _GB_UserModel;

#pragma mark - 实现单例
SYNTHESIZE_SINGLETONE_FOR_CLASS(GlobalData);

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化状态栏
        self.statusBarStyle = UIStatusBarStyleLightContent;
    }
    return self;
}

#pragma mark - set get userModel
- (void)setGB_UserModel:(ModelUser *)GB_UserModel{
    [GlobalMethod writeStr:GB_UserModel != nil?[GlobalMethod exchangeModelToJson:GB_UserModel]:@"" forKey:LOCAL_USERMODEL];
    _GB_UserModel = GB_UserModel;
    //保存手机号
    if (isStr(GB_UserModel.accountPhone)) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:GB_UserModel.accountPhone forKey:LOCAL_PHONE];
        [user synchronize];
    }
    if (GB_UserModel) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_SELFMODEL_CHANGE object:nil];
    }
}
- (ModelUser *)GB_UserModel{
    if (_GB_UserModel.number == 0) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_USERMODEL]];
        _GB_UserModel = [ModelUser modelObjectWithDictionary:dicItem];
    }
    return _GB_UserModel;
}
+ (void)saveUserModel{
    [GlobalData sharedInstance].GB_UserModel = [GlobalData sharedInstance].GB_UserModel;
}

#pragma mark - set get key
- (void)setGB_Key:(NSString *)GB_Key{
    [GlobalMethod writeStr:GB_Key!=nil?GB_Key:@"" forKey:LOCAL_KEY];
    _GB_Key = GB_Key;
}
- (NSString*)GB_Key{
    if (!isStr(_GB_Key)){
        _GB_Key = [GlobalMethod readStrFromUser:LOCAL_KEY];
    }
    return _GB_Key;
}

@end
