//
//  DestinationModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/17.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@protocol DestinationsModel
@end

@interface DestinationsModel : JSONModel
@property (nonatomic, copy)NSString *Did;
@property (nonatomic, copy)NSString *name_zh_cn;
@property (nonatomic, copy)NSString *name_en;
@property (nonatomic, copy)NSString *poi_count;
@property (nonatomic, copy)NSString *lat;
@property (nonatomic, copy)NSString *lng;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *updated_at;
@end

@interface DestinationModel : JSONModel
@property (nonatomic, copy)NSString *category;
@property (nonatomic, strong)NSMutableArray <DestinationsModel>*destinations;
@end
