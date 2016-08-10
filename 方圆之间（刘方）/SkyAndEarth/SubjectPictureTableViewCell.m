//
//  SubjectPictureTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/21.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SubjectPictureTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface SubjectPictureTableViewCell ()

@property (nonatomic,strong) UIImageView *pictureImage;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) UILabel *tripTitleLabel;
@property (nonatomic,strong) UILabel *userNameLabel;

@end

@implementation SubjectPictureTableViewCell

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
        _backImage = [[UIImageView alloc] init];
        _descriptionLabel = [[UILabel alloc] init];
        _tripTitleLabel = [[UILabel alloc] init];
        _userNameLabel = [[UILabel alloc] init];
        
        _backImage.image = [UIImage imageNamed:@"ArticleCoverMask@3x"];
        [_backImage addSubview:_tripTitleLabel];
        [_backImage addSubview:_userNameLabel];
        [_pictureImage addSubview:_backImage];
        [self.contentView addSubview:_pictureImage];
        [self.contentView addSubview:_descriptionLabel];
    }
    return self;
}

#define WIDTH [UIScreen mainScreen].bounds.size.width

- (void)layoutPictureWithModel:(ArticleSectionsModel *)model{
    CGFloat topGap = 4;
    CGFloat leftGap = 10;
    _pictureImage.frame = CGRectMake(leftGap, topGap, WIDTH-2*leftGap, (WIDTH-2*leftGap)*[model.image_height floatValue]/[model.image_width floatValue]);
    _backImage.frame = CGRectMake(0, _pictureImage.frame.size.height-60, _pictureImage.frame.size.width, 60);
    _tripTitleLabel.frame = CGRectMake(leftGap, leftGap, WIDTH-4*leftGap, 20);
    _tripTitleLabel.font = [UIFont systemFontOfSize:15];
    _tripTitleLabel.textColor = [UIColor whiteColor];
    _userNameLabel.frame = CGRectMake(leftGap, 30, WIDTH-4*leftGap, 20);
    _userNameLabel.font = [UIFont systemFontOfSize:13];
    _userNameLabel.textColor = [UIColor whiteColor];
    NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [model.ZTDdescription boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
    _descriptionLabel.frame = CGRectMake(leftGap, CGRectGetMaxY(_pictureImage.frame)+topGap, WIDTH-20, rect.size.height);
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont systemFontOfSize:13];
    [_pictureImage sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _tripTitleLabel.text = model.NoteTripName;
    _userNameLabel.text = model.NoteUserName;
    _descriptionLabel.text = model.ZTDdescription;
}

@end
