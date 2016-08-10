//
//  PictureTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/20.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "PictureTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface PictureTableViewCell ()

@property (nonatomic,strong)UIImageView *pictureImage;

@property (nonatomic,strong)UILabel *detailLabel;

@end

@implementation PictureTableViewCell

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
        _detailLabel = [[UILabel alloc] init];
    
        [self.contentView addSubview:_pictureImage];
        [self.contentView addSubview:_detailLabel];
    }
    return self;
}

- (void)layoutSubviewsWith:(NotesModel *)model{
    CGFloat height = [model.image_height floatValue]/[model.image_width floatValue]*[UIScreen mainScreen].bounds.size.width;
    _pictureImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    [_pictureImage sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [model.Description boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
    _detailLabel.frame = CGRectMake(10, height, [UIScreen mainScreen].bounds.size.width-20, rect.size.height);
    _detailLabel.font = [UIFont systemFontOfSize:13];
    _detailLabel.numberOfLines = 0;
    _detailLabel.text = model.Description;
}

@end
