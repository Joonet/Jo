//
//  DestinationCollectionViewCell.h
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/17.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationModel.h"

@interface DestinationCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *chaneseName;
@property (weak, nonatomic) IBOutlet UILabel *englishName;
@property (weak, nonatomic) IBOutlet UILabel *destinationCount;

- (void)layoutWithModel:(DestinationsModel *)model;

@end
