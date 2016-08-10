//
//  TitleTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/21.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "TitleTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutTitleCellWithModel:(SubjectDetailModel *)model{
    [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _nameLabel.text = model.name;
    _titleLabel.text = model.title;
}

@end
