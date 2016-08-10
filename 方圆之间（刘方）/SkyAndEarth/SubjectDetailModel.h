//
//  SubjectDetailModel.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/21.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JSONModel.h"

@protocol  ArticleSectionsModel
@end

@interface ArticleSectionsModel : JSONModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *ZTDdescription;
@property (nonatomic, copy)NSString *NoteTripId;
@property (nonatomic, copy)NSString *NoteTripName;
@property (nonatomic, copy)NSString *NoteUserName;
@property (nonatomic, copy)NSString *AttractionName;
@property (nonatomic,copy)NSString *image_height;
@property (nonatomic,copy)NSString *image_width;
@end


@interface SubjectDetailModel : JSONModel
@property (nonatomic, copy)NSString *ZTDid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image_url;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSMutableArray <ArticleSectionsModel>*article_sections;
@end
