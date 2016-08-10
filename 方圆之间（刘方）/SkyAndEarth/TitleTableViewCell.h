//
//  TitleTableViewCell.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/21.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectDetailModel.h"

@interface TitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)layoutTitleCellWithModel:(SubjectDetailModel *)model;

@end
