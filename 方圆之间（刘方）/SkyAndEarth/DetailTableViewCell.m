//
//  DetailTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/20.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell ()

@property (nonatomic,strong)UILabel *descriptionLabel;

@end

@implementation DetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _descriptionLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_descriptionLabel];
    }
    return self;
}

#define Gaping 10

- (void)layoutSubviewsWithModel:(NotesModel *)model{
    NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [model.Description boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
    _descriptionLabel.frame = CGRectMake(Gaping, Gaping, [UIScreen mainScreen].bounds.size.width-20, rect.size.height);
    _descriptionLabel.text = model.Description;
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont systemFontOfSize:13];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
