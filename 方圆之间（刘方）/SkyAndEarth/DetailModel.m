//
//  DetailModel.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/16.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"user.image":@"userImage"}];
}
@end

@implementation Trip_Days

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"tripId"}];
}
@end

@implementation Nodes

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"":@""}];
}
@end

@implementation NotesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"photo.url":@"photoUrl",@"photo.image_height":@"image_height",@"photo.image_width":@"image_width",@"description":@"Description"}];
}
@end

