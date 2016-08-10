//
//  LFNetManager.m
//  5-AFNetworkingWithSession
//
//  Created by qianfeng0 on 16/3/25.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "LFNetManager.h"
#import "AFNetworking.h"

@interface LFNetManager ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *afhttpManager;

@end

@implementation LFNetManager

+ (instancetype)sharedManager{
    static LFNetManager * manager = nil;
    static dispatch_once_t onceToken;
//    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LFNetManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化 af 网络管理类
        _afhttpManager = [AFHTTPRequestOperationManager manager];
        NSMutableSet * set = [NSMutableSet setWithSet:_afhttpManager.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        _afhttpManager.responseSerializer.acceptableContentTypes = set;
        [_afhttpManager.securityPolicy setAllowInvalidCertificates:YES];
    }
    return self;
}

- (void)GET:(NSString *)url parameters:(id)parameters SucessBlock:(SucessBlock)block Failure:(Failure)failureBlock{
    [_afhttpManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
}

@end
