//
//  SkyAndEarth.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/13.
//  Copyright © 2016年 刘方. All rights reserved.
//

#ifndef SkyAndEarth_h
#define SkyAndEarth_h



//游记接口
#define TravelNote_Url @"https://chanyouji.com/api/trips/featured.json?page=%ld"

//游记详情接口 %@为游记界面id字段
#define TravelContent_Url @"https://chanyouji.com/api/trips/%@.json%20"
//目的地接口
#define Destination_Url @"https://chanyouji.com/api/destinations.json%20HTTP/"
//目的地详情接口%@为接口id
#define Destination_Content_Url @"https://chanyouji.com/api/destinations/%@.json"
//行程接口
#define XingChengURL @"https://chanyouji.com/api/destinations/plans/%@.json?page=1"

//旅行地接口
#define LvXingDiURL @"http://chanyouji.com/api/destinations/attractions/%d.json?per_page=20&page=%d"

//专题接口
#define subjectUrl @"https://chanyouji.com/api/articles.json?page=%ld"


//专题详情接口
#define subjectDetailUrl @"https://chanyouji.com/api/articles/%@.json"

#define BLUECOLOR [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:0.5]

#endif /* SkyAndEarth_h */
