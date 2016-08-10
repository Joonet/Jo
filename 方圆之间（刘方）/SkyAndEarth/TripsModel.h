//
//  TripsModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@interface TripsModel : JSONModel

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *user_score;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *description_summary;
@property (nonatomic,copy) NSString * attraction_trips_count;
@property (nonatomic) NSString *  cellHight;
@end
