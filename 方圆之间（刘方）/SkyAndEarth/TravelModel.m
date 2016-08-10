//
//  TravelModel.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/14.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "TravelModel.h"

@implementation TravelModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"travelId",@"user.image":@"userImage"}];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

@end
