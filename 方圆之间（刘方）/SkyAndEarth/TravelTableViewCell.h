//
//  TravelTableViewCell.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/15.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelModel.h"

@interface TravelTableViewCell : UITableViewCell

- (void)configCellWithTravelModel:(TravelModel *)model;

@end
