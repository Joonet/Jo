//
//  xingchengTabelViewCell.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JournneyModel.h"

@interface xingchengTabelViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nodeLabel;

- (void)layoutCellWithModel:(JournneyModel *)model;

@end
