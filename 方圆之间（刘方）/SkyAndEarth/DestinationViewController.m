//
//  DestinationViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/13.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DestinationViewController.h"
#import "SkyAndEarth.h"
#import "DestinationModel.h"
#import "DestinationCollectionViewCell.h"
#import "DestinationDetailViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"
#import "AFNetworking.h"
#import "MBProgressHUD+Add.h"

@interface DestinationViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong)UICollectionView *collectionView ;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *destinationsSource;

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray new];
    _destinationsSource = [NSMutableArray new];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCollectionView];
    [MBProgressHUD showMessag:@"努力加载中" toView:_collectionView];
    [self loadDataSource];
}

- (void)loadDataSource{
    NSData *cacheeData = [JWCache objectForKey:Destination_Url];
    if (cacheeData) {
        [MBProgressHUD hideAllHUDsForView:_collectionView animated:YES];
        NSError *error = nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:&error];
        for (NSDictionary *dic in arr) {
            NSMutableArray *dataArray = dic[@"destinations"];
            for (NSDictionary *dict in dataArray) {
                DestinationsModel *model = [[DestinationsModel alloc] initWithDictionary:dict error:&error];
                [_destinationsSource addObject:model];
            }
        }
        [self.collectionView reloadData];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy = securityPolicy;
        [manager.securityPolicy setAllowInvalidCertificates:YES];
        
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [manager GET:Destination_Url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD hideAllHUDsForView:_collectionView animated:YES];
            NSError *error = nil;
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            for (NSDictionary *dic in arr) {
                NSMutableArray *dataArray = dic[@"destinations"];
                for (NSDictionary *dict in dataArray) {
                    DestinationsModel *model = [[DestinationsModel alloc] initWithDictionary:dict error:&error];
                    [_destinationsSource addObject:model];
                }
            }
            [JWCache setObject:responseObject forKey:Destination_Url];
            [self.collectionView reloadData];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求失败%@",error);
        }];

    }
}

#define screenWidth() [UIScreen mainScreen].bounds.size.width

- (UICollectionViewLayout *)createLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat padding = 5;
    CGFloat itemsWidth = screenWidth()/2-8;
    
    layout.itemSize = CGSizeMake(itemsWidth, itemsWidth*3/2);
    layout.sectionInset = UIEdgeInsetsMake(padding,padding/2,padding,padding/2);
    
    
    return layout;
}

- (void)createCollectionView{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[self createLayout]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DestinationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DestinationCollectionViewCell"];
    [self.view addSubview:_collectionView];
}


#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _destinationsSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DestinationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DestinationCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    DestinationsModel *model = _destinationsSource[indexPath.row];
    [cell layoutWithModel:model];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DestinationsModel *model = _destinationsSource[indexPath.row];
    DestinationDetailViewController *dvc = [[DestinationDetailViewController alloc] init];
    dvc.destinationId = model.Did;
    dvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
