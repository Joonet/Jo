//
//  TravelModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/14.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@interface TravelModel : JSONModel

/**
 *  游记id
 */
@property (nonatomic,copy) NSString *travelId;
/**
 *  游记名
 */
@property (nonatomic,copy) NSString *name;
/**
 *  开始日期
 */
@property (nonatomic,copy) NSString *start_date;
/**
 *  旅行天数
 */
@property (nonatomic,copy) NSString *days;
/**
 *  图片数
 */
@property (nonatomic,copy) NSString *photos_count;
/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *userImage;
/**
 *  游记大图
 */
@property (nonatomic,copy) NSString *front_cover_photo_url;

@end
