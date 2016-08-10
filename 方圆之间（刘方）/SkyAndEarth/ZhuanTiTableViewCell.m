//
//  ZhuanTiTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/22.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "ZhuanTiTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ZhuanTiTableViewCell ()

@property (nonatomic,strong)UIImageView *pictureImage;
@property (nonatomic,strong)UIImageView *backgroundImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *nameLabel;

@end

@implementation ZhuanTiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _pictureImage = [[UIImageView alloc] init];
        _backgroundImage = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init];
        _nameLabel = [[UILabel alloc] init];
        
        _backgroundImage.image = [UIImage imageNamed:@"ArticleCoverMask@3x"];
        
        [_backgroundImage addSubview:_titleLabel];
        [_backgroundImage addSubview:_nameLabel];
        [_pictureImage addSubview:_backgroundImage];
        [self.contentView addSubview:_pictureImage];
    }
    return self;
}

#define WIDTH [UIScreen mainScreen].bounds.size.width


- (void)layoutSubviews{
    CGFloat topGap = 4;
    CGFloat leftGap = 10;
    _pictureImage.frame = CGRectMake(leftGap, topGap, WIDTH - 2*leftGap, 0.58*(WIDTH - 2*leftGap));
    _backgroundImage.frame = CGRectMake(0, _pictureImage.frame.size.height-60, _pictureImage.frame.size.width, 60);
    _titleLabel.frame = CGRectMake(leftGap, leftGap, WIDTH-4*leftGap, 20);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor whiteColor];
    _nameLabel.frame = CGRectMake(leftGap, 30, WIDTH-4*leftGap, 20);
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor whiteColor];
}

- (void)layoutCellWithModel:(SubjectModel *)model{
    [_pictureImage sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _titleLabel.text = model.title;
    _nameLabel.text = model.name;
}


@end
