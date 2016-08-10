//
//  LFNetManager.h
//  5-AFNetworkingWithSession
//
//  Created by qianfeng0 on 16/3/25.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SucessBlock)(id responseObject) ;

typedef void(^Failure)(NSError * error);

@interface LFNetManager : NSObject

/**
 *  获取网络管理的单例
 *
 */
+ (instancetype)sharedManager;

/**
 *  get 请求
 *
 */
- (void)GET:(NSString *)url parameters:(id)parameters SucessBlock:(SucessBlock)block Failure:(Failure)failureBlock;

@end
