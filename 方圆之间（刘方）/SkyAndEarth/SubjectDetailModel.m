//
//  SubjectDetailModel.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/21.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SubjectDetailModel.h"

@implementation ArticleSectionsModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"ZTDdescription",@"note.trip_id":@"NoteTripId",@"note.trip_name":@"NoteTripName",@"note.user_name":@"NoteUserName",@"attraction.name":@"AttractionName"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}


@end

@implementation SubjectDetailModel
+(JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"ZTDid"}];
}
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

