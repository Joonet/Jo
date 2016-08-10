//
//  ImageScrollowViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/22.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "ImageScrollowViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Add.h"

@interface ImageScrollowViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic,strong) UILabel *saveLabel;

@property (nonatomic) NSInteger numberOfTap;

@end

@implementation ImageScrollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _numberOfTap = 0;
    _imageView = [[UIImageView alloc] init];
    _btn = [[UIButton alloc] init];
    _saveLabel = [[UILabel alloc] init];
    _saveLabel.userInteractionEnabled = YES;
    [self createScrollView];
}

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

- (void)createScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _btn.frame = CGRectMake(WIDTH-25, 5, 20, 20);
    [_btn setTitle:@"+" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(saveImagetoPhone) forControlEvents:UIControlEventTouchUpInside];
    _btn.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:_btn];
    
    _saveLabel.frame = CGRectMake(WIDTH-150, 25, 150, 30);
    _saveLabel.backgroundColor = [UIColor whiteColor];
    _saveLabel.text = @"保存到手机";
    _saveLabel.font = [UIFont systemFontOfSize:13];
    _saveLabel.hidden = YES;
    UITapGestureRecognizer *Labeltap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveImage)];
    [_saveLabel addGestureRecognizer:Labeltap];
    [_scrollView addSubview:_saveLabel];
    
    _scrollView.userInteractionEnabled = YES;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissVC)];
    [_scrollView addGestureRecognizer:tap];
    [_scrollView addSubview:_imageView];
    CGFloat imageY = HEIGHT/2 - WIDTH*[_image_height floatValue]/[_image_width floatValue]/2;
    _imageView.frame = CGRectMake(0, imageY, WIDTH, WIDTH*[_image_height floatValue]/[_image_width floatValue]);
    _scrollView.backgroundColor = [UIColor blackColor];
    

    [self.view addSubview:_scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)dismissVC{
    if (!_saveLabel.hidden) {
        _saveLabel.hidden = !_saveLabel.hidden;
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}



- (void)saveImagetoPhone{
    _numberOfTap++;
    if (_numberOfTap%2) {
        _saveLabel.hidden = NO;
    }else{
        _saveLabel.hidden = YES;
    }
}

- (void)saveImage{
    _saveLabel.hidden = YES;
    _numberOfTap++;
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
    [MBProgressHUD showMessag:message toView:_scrollView];
    
    [MBProgressHUD hideAllHUDsForView:_scrollView animated:YES];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
