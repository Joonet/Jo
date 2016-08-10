//
//  StarsView.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "StarsView.h"

@implementation StarsView

-(id)init
{
    if (self = [super init]) {
        [self addUI];
    }
    return self;
}


-(void)addUI
{
    //背后的星星和前面的星星
    UIImage * bgImage = [UIImage imageNamed:@"StarsBackground"];
    UIImage * frontImage = [UIImage imageNamed:@"StarsForeground"];
    
    UIImageView * bgImageView = [[UIImageView alloc]init];
    bgImageView.image = bgImage;
    bgImageView.frame = CGRectMake(0, 0, bgImage.size.width, bgImage.size.height);
    [self addSubview:bgImageView];
    
    UIImageView * frontImageView = [[UIImageView alloc]init];
    frontImageView.tag = 1111;
    frontImageView.image = frontImage;
    frontImageView.layer.masksToBounds = YES;
    frontImageView.contentMode = UIViewContentModeScaleAspectFill | UIViewContentModeLeft;
    
    [self addSubview:frontImageView];
    
}

#pragma mark - 重写set方法，设置星级
-(void)setStatrs:(CGFloat)statrs
{
    _statrs = statrs;
    UIImage * frontImage = [UIImage imageNamed:@"StarsForeground"];
    UIImageView  * imageView = (id)[self viewWithTag:1111];
    imageView.frame = CGRectMake(0, 0, statrs*frontImage.size.width/5.0, frontImage.size.height);
}



@end
