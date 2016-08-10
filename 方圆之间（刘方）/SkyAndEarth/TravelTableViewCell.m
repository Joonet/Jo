//
//  TravelTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/15.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "TravelTableViewCell.h"
#import "UIImageView+WebCache.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface TravelTableViewCell ()

@property (nonatomic,strong)UIImageView *pictureView;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *dateLabel;

@property (nonatomic,strong)UIImageView *backgroundLabel;

@property (nonatomic,strong)UIImageView *headView;

@end

@implementation TravelTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backgroundLabel = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init];
        _dateLabel = [[UILabel alloc] init];
        _pictureView = [[UIImageView alloc] init];
        _headView = [[UIImageView alloc] init];
        
        _backgroundLabel.image = [UIImage imageNamed:@"CustomBarBackground"];
        _headView.layer.borderWidth = 2;
        _headView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _headView.layer.cornerRadius = 12;
        _headView.layer.masksToBounds = YES;
        
        [_backgroundLabel addSubview:_titleLabel];
        [_backgroundLabel addSubview:_dateLabel];
        [_pictureView addSubview:_backgroundLabel];
        [_pictureView addSubview:_headView];
        [self.contentView addSubview:_pictureView];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat topGap = 8;
    CGFloat leftGap = 12;
    _pictureView.frame = CGRectMake(leftGap, topGap/2, WIDTH-2*leftGap, 0.58*WIDTH+10-topGap);
    _titleLabel.frame = CGRectMake(leftGap, leftGap, WIDTH-4*leftGap, 20);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _dateLabel.frame = CGRectMake(leftGap, 3.5*leftGap, WIDTH-4*leftGap, 15);
    _dateLabel.textColor = [UIColor whiteColor];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    _backgroundLabel.frame = CGRectMake(0, 0, WIDTH-2*leftGap, 100);
    _headView.frame = CGRectMake(leftGap, 0.58*WIDTH-leftGap-40, 40, 40);
}

- (void)configCellWithTravelModel:(TravelModel *)model{
    _titleLabel.text = model.name;
    if (model.start_date != NULL) {
        _dateLabel.text = [NSString stringWithFormat:@"%@/%@天,%@图",model.start_date,model.days,model.photos_count];
    }else{
        _dateLabel.text = [NSString stringWithFormat:@"%@天,%@图",model.days,model.photos_count];
    }
    [_headView sd_setImageWithURL:[NSURL URLWithString:model.userImage] placeholderImage:[UIImage imageNamed:@"tabbar_setting"]];
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
