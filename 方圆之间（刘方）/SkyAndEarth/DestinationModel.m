//
//  DestinationModel.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/17.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationsModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Did"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation DestinationModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end