//
//  DestinationDetailModel.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/18.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DeatinatneDetailModel.h"

@implementation ContentsModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation NoteModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"intro.notes":@"notesArray",@"description":@"Ndescription"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation DeatinatneDetailModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Did"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
