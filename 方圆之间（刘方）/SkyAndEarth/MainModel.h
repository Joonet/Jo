//
//  MainModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/13.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@interface MainModel : JSONModel

@property (nonatomic,copy) NSString *classname;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *image;

@end
