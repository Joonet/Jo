//
//  SubjectModel.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/18.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel

+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ZTid"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
