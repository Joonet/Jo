//
//  DestinationCollectionViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/17.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DestinationCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DestinationCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutWithModel:(DestinationsModel *)model{
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.chaneseName.text = model.name_zh_cn;
    self.englishName.text = model.name_en;
    self.destinationCount.text = [NSString stringWithFormat:@"%@旅行地",model.poi_count];
}

@end
