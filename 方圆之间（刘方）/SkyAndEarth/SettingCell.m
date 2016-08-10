//
//  SettingCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/5/4.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SettingCell.h"
#import "UIView+Common.h"

@interface SettingCell ()

{
    UIImageView *_image;
    UIImageView *_imageView;
    UILabel *_label1;
    UILabel *_label2;
}

@end

@implementation SettingCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _label1 = [UILabel new];
        _label1.font = [UIFont systemFontOfSize:15];
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_label1];
        if ([reuseIdentifier isEqualToString:@"cell0"]||[reuseIdentifier isEqualToString:@"cell1"]||[reuseIdentifier isEqualToString:@"cell2"]) {
            _image = [UIImageView new];
            _image.image = [UIImage imageNamed:@"comment_arrow"];
            [self.contentView addSubview:_image];
        }else{
            _label2 = [UILabel new];
            _label2.font = [UIFont systemFontOfSize:15];
            _label2.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_label2];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat gap = 15;
    _imageView.frame = CGRectMake(gap, gap, height(self.contentView)-2*gap, height(self.contentView)-2*gap);
    _label1.frame = CGRectMake(maxX(_imageView)+10, 0, 100, height(self.contentView));
    _label2.frame = CGRectMake(width(self.contentView)-120, 0, 100, height(self.contentView));
    _image.frame = CGRectMake(width(self.contentView)-30, (height(self.contentView)-10)/2, 10, 10);
}

-(void)setDataWithTitle:(NSString *)string  Title2:(CGFloat)str imageName:(NSString *)image{
    _label1.text = string;
    _label2.text = [NSString stringWithFormat:@"%.2fM缓存",str];
    _imageView.image = [UIImage imageNamed:image];
}

@end
