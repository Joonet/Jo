//
//  DestinationDetailTableViewCell.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/18.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DestinationDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DestinationDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutCellWithModel:(DeatinatneDetailModel *)model{
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    NSString *titleStr = [NSString stringWithFormat:@"%@  %@",model.name_zh_cn,model.name_en];
    self.titleLabel.text = titleStr;
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (IBAction)xingcheng:(id)sender {
    self.xingchengBtn.tag = 10;
    _button(_xingchengBtn.tag);
//    NSLog(@"666");
}
- (IBAction)lvxingdi:(id)sender {
    self.lvxingdiBtn.tag = 20;
    _button(_lvxingdiBtn.tag);
//    NSLog(@"888");
}


@end
