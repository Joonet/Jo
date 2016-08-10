//
//  SubjectModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/18.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@interface SubjectModel : JSONModel

@property (nonatomic, copy)NSString *ZTid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *destination_id;

@end
