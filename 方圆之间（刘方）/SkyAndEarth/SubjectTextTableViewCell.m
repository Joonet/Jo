//
//  SubjectTextTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/21.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SubjectTextTableViewCell.h"

@interface SubjectTextTableViewCell ()

@property (nonatomic,strong)UILabel *descriptionLabel;

@end

@implementation SubjectTextTableViewCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _descriptionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_descriptionLabel];
    }
    return self;
}

#define Gaping 10

- (void)layoutTextCellWithModel:(ArticleSectionsModel *)model{
    NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [model.ZTDdescription boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
    _descriptionLabel.frame = CGRectMake(Gaping, Gaping, [UIScreen mainScreen].bounds.size.width-20, rect.size.height);
    _descriptionLabel.text = model.ZTDdescription;
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont systemFontOfSize:13];
}

@end
