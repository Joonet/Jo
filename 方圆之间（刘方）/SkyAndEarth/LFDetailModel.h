//
//  LFDetailModel.h
//  JSONModel
//
//  Created by qianfeng0 on 16/04/16
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User,Notes_Likes_Comments,Trip_Days,Nodes,Memo,Notes;

@interface LFDetailModel : NSObject

@property (nonatomic, assign) NSInteger front_cover_photo_id;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, assign) NSInteger serial_next_id;

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, assign) NSInteger updated_at;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, copy) NSString *front_cover_photo_url;

@property (nonatomic, assign) BOOL current_user_favorite;

@property (nonatomic, strong) NSArray<Trip_Days *> *trip_days;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *serial_position;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, assign) NSInteger favorites_count;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, strong) User *user;

@property (nonatomic, copy) NSString *upload_token;

@property (nonatomic, assign) NSInteger likes_count;

@property (nonatomic, copy) NSString *start_date;

@property (nonatomic, strong) NSArray<Notes_Likes_Comments *> *notes_likes_comments;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, assign) BOOL privacy;

@property (nonatomic, copy) NSString *serial_id;

@property (nonatomic, assign) NSInteger photos_count;

@property (nonatomic, assign) NSInteger views_count;

@end