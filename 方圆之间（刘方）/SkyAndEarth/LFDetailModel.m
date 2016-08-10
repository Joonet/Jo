//
//  LFDetailModel.m
//  JSONModel
//
//  Created by qianfeng0 on 16/04/16
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "LFDetailModel.h"
#import "Notes_Likes_Comments.h"
#import "Trip_Days.h"

@implementation LFDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{@"notes_likes_comments" : [Notes_Likes_Comments class], @"trip_days" : [Trip_Days class]};
}

@end
