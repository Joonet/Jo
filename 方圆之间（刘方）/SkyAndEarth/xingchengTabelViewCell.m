//
//  xingchengTabelViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "xingchengTabelViewCell.h"
#import "UIImageView+WebCache.h"

@implementation xingchengTabelViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutCellWithModel:(JournneyModel *)model{
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLabel.text = model.name;
    self.descriptionLabel.text = model.Description;
    self.nodeLabel.text = [NSString stringWithFormat:@"%@/%@个旅游地",model.plan_days_count,model.plan_nodes_count];
}

@end
