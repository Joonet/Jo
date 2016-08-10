//
//  TravelNoteDetailViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/16.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "TravelNoteDetailViewController.h"
#import "LFNetManager.h"
#import "SkyAndEarth.h"
#import "AFNetworking.h"
#import "DetailModel.h"
#import "DetailTableViewCell.h"
#import "PictureTableViewCell.h"
#import "ImageScrollowViewController.h"
#import "DBManager.h"
#import "MBProgressHUD+Add.h"
#import "JWCache.h"
#import "NSString+Tools.h"

@interface TravelNoteDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) UIImageView *navImage;
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIImageView *bnavImage;
@property (nonatomic,strong) UIButton *favoriteBtn;

@end

@implementation TravelNoteDetailViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
     [self createTableView];
    [MBProgressHUD showMessag:@"努力加载中" toView:_tableView];
    [self loadDataSource];
    [self createNavView];
}

#define WIDTH [UIScreen mainScreen].bounds.size.width

- (void)createNavView{
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    
    _navImage = [[UIImageView alloc] init];
    _navImage.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-40, 25, 35, 40);
    _bnavImage = [[UIImageView alloc] init];
    _bnavImage.frame = CGRectMake(3, 27, 35, 35);
    _bnavImage.layer.cornerRadius = 15;
    _bnavImage.layer.masksToBounds = YES;
    _bnavImage.backgroundColor = BLUECOLOR;
    [_navView addSubview:_bnavImage];
    _navImage.layer.cornerRadius = 15;
    _navImage.layer.masksToBounds = YES;
    _navImage.backgroundColor = BLUECOLOR;
    [_navView addSubview:_navImage];
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(5, 30, 30, 30);
    [_backButton setImage:[[UIImage imageNamed:@"ic_nav_left_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(touchBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backButton];
    
    _favoriteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _favoriteBtn.frame = CGRectMake(WIDTH - 35, 35, 25, 25);
    
    BOOL isExistRecord1 = [[DBManager sharedManager] isExistAppForMid:_model.travelId];
    [self setHeatButton:isExistRecord1];
    [_favoriteBtn addTarget:self action:@selector(touchHeartButton:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_favoriteBtn];
    
    [self.view addSubview:_navView];
}

- (void)touchBackButton:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
//    [[DBManager sharedManager] deleteAll];
}

-(void)touchHeartButton:(UIButton *)button {
    if (_dataSource.count >0) {
        
    BOOL isExistRecord = [[DBManager sharedManager] isExistAppForMid:_model.travelId];
    if (isExistRecord) {
        [[DBManager sharedManager] deleteModelForMid:_model.travelId];
        _favoriteBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _favoriteBtn.alpha= 1.0;
        
    } else {
        [[DBManager sharedManager] insertModel:_model];
        
        [UIView animateWithDuration:0.3 animations:^{
            [_favoriteBtn setBackgroundImage:nil forState:UIControlStateNormal];
            _favoriteBtn.transform = CGAffineTransformMakeScale(2.0, 2.0);
            _favoriteBtn.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_favoriteBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"ic_nav_black_heart_on"] forState:UIControlStateNormal];
            _favoriteBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            _favoriteBtn.alpha= 1.0;
        }];
    }
    BOOL isExistRecord1 = [[DBManager sharedManager] isExistAppForMid:_model.travelId];
    [self setHeatButton:isExistRecord1];
    }
}

- (void)setHeatButton:(BOOL)isFavourete {
    NSString *oFavourete = isFavourete?@"ic_nav_black_heart_on":@"ic_nav_heart_white_off";
    [_favoriteBtn setBackgroundImage:[UIImage imageNamed:oFavourete] forState:UIControlStateNormal];
}

- (void)loadDataSource{

    NSString *deatailUrl = [NSString stringWithFormat:TravelContent_Url,_idStr];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy = securityPolicy;
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
      manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    
    NSData *cacheeData = [JWCache objectForKey:MD5(deatailUrl)];
    if (cacheeData) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:nil];
        NSArray *tripDaysArray = dict[@"trip_days"];
        for (NSDictionary *tripDay in tripDaysArray) {
            NSArray *array = tripDay[@"nodes"];
            for (NSDictionary *nodes in array) {
                NSArray *notes = nodes[@"notes"];
                for (NSDictionary * modelDic in notes) {
                    NotesModel * model=[[NotesModel alloc]initWithDictionary:modelDic error:nil];
                    [_dataSource addObject:model];
                }
            }
        }
        [self.tableView reloadData];
        
        
    }else{
    [manager GET:deatailUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *tripDaysArray = dict[@"trip_days"];
        for (NSDictionary *tripDay in tripDaysArray) {
            NSArray *array = tripDay[@"nodes"];
            for (NSDictionary *nodes in array) {
                NSArray *notes = nodes[@"notes"];
                for (NSDictionary * modelDic in notes) {
                    NotesModel * model=[[NotesModel alloc]initWithDictionary:modelDic error:nil];
                    [_dataSource addObject:model];
                }
            }
        }
        [JWCache setObject:responseObject forKey:MD5(deatailUrl)];
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
        NSLog(@"请求失败%@",error);
    }];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.dataSource = self;
   _tableView.delegate = self;
//    _tableView.backgroundColor = [UIColor cyanColor];
    [_tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[PictureTableViewCell class] forCellReuseIdentifier:@"picCell"];
    [self.view addSubview:_tableView];
}


#pragma mark - 协议方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotesModel *model = _dataSource[indexPath.row];
    if (model.photoUrl) {
        PictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picCell" forIndexPath:indexPath];
        [cell layoutSubviewsWith:model];
        return cell;
    }else{
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell layoutSubviewsWithModel:model];
        return cell;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotesModel *model = _dataSource[indexPath.row];
//    NSLog(@"%@",[model class]);
    if (model.photoUrl) {
        NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect rect = [model.Description boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
        CGFloat height = [model.image_height floatValue]/[model.image_width floatValue]*[UIScreen mainScreen].bounds.size.width;
        return height+rect.size.height+5;
    }else{
        NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect rect = [model.Description boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
        return rect.size.height+10;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NotesModel *model = _dataSource[indexPath.row];
    if (model.photoUrl) {
        ImageScrollowViewController *vc = [[ImageScrollowViewController alloc] init];
        vc.image_url = model.photoUrl;
        vc.image_height = model.image_height;
        vc.image_width = model.image_width;
        [self presentViewController:vc animated:NO completion:nil];
    }
}

@end
