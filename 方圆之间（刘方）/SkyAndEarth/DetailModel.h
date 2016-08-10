//
//  DetailModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/16.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@protocol  Trip_Days<NSObject>
@end
@protocol NotesModel <NSObject>
@end
@protocol Nodes <NSObject>
@end

@interface NotesModel : JSONModel


@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *photoUrl;
@property (nonatomic,copy) NSString *image_height;
@property (nonatomic,copy) NSString *image_width;

@end

@interface Trip_Days : JSONModel

@property (nonatomic,copy) NSString *day;
@property (nonatomic,copy) NSString *trip_date;
@property (nonatomic,copy) NSString *tripId;
@property (nonatomic,copy) NSMutableArray <Nodes>*nodes;

@end

@interface DetailModel : JSONModel
@property (nonatomic,copy)NSString * start_date;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * userImage;
@property (nonatomic,copy)NSString *front_cover_photo_url;
@property (nonatomic,copy)NSMutableArray <Trip_Days>*trip_days;

@end

@interface Nodes : JSONModel
@property (nonatomic,copy) NSMutableArray <NotesModel> *notes;
@end
