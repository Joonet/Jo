//
//  TravelNoteDetailViewController.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/16.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelModel.h"


@interface TravelNoteDetailViewController : UIViewController

@property (nonatomic,strong) NSString *idStr;

@property (nonatomic,strong) TravelModel *model;


@end
