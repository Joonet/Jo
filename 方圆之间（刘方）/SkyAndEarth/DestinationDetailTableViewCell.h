//
//  DestinationDetailTableViewCell.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/18.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeatinatneDetailModel.h"

typedef void(^BlockButton)(NSInteger tag);

@interface DestinationDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *xingchengBtn;
@property (weak, nonatomic) IBOutlet UIButton *lvxingdiBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, copy) BlockButton button;

- (void)layoutCellWithModel:(DeatinatneDetailModel *)model;

@end
