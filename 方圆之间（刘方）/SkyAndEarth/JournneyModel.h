//
//  JournneyModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@interface JournneyModel : JSONModel

@property (nonatomic,strong) NSString *Description;
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *plan_days_count;
@property (nonatomic,copy) NSString *plan_nodes_count;

@end
