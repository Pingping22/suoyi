//
//  RequestInstance.m
//  乐销
//
//  Created by 隋林栋 on 2016/12/13.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "RequestInstance.h"

@implementation RequestInstance

+ (RequestInstance *)sharedInstance
{
    static RequestInstance * _instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RequestInstance alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.requestSerializer.timeoutInterval = TIME_REQUEST_OUT;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.requestSerializer setValue:[self testUserAgent] forHTTPHeaderField:@"User-Agent"];
            [self.requestSerializer setValue:@"3" forHTTPHeaderField:@"requestSource"];
            [self.requestSerializer setValue:@"2" forHTTPHeaderField:@"appKey"];
        });
    }
    return self;
}

- (NSString *)testUserAgent
{
    
    NSString * agent = [NSString stringWithFormat:@"lao dao ying xiao dai li shang ban/%@(%@;iOS %@;Scale/%.2f)",[GlobalMethod getVersion],[GlobalMethod LookDeviceName],[UIDevice currentDevice].systemVersion,[UIScreen mainScreen].scale];
  
    return agent;
}

@end
