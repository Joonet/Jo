//
//  TripsImageView.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "TripsImageView.h"
#import "UIImageView+WebCache.h"

@implementation TripsImageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI
{
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    view.alpha = 0.5;
    [self addSubview:view];
    
    UILabel * label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.frame = view.bounds;
    label.tag = 11;
    [view addSubview:label];
}

-(void)setNumber:(NSString *)number
{
    _number = number;
    NSString * title = [NSString stringWithFormat:@"%@ 篇游记",number];
    UILabel * lable = (id)[self viewWithTag:11];
    lable.text = title;
}


-(void)setImage_ur:(NSString *)image_ur
{
    _image_ur = image_ur;
    [self sd_setImageWithURL:[NSURL URLWithString:image_ur]];
}


@end
