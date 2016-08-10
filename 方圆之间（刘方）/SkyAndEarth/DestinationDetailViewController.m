//
//  DestinationDetailViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/18.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "DestinationDetailViewController.h"
#import "SkyAndEarth.h"
#import "AFNetworking.h"
#import "DeatinatneDetailModel.h"
#import "DestinationDetailTableViewCell.h"
#import "JourneyViewController.h"
#import "TripsViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"

@interface DestinationDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation DestinationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self createTableView];
    [self loadDataSource];
}

- (void)loadDataSource{
    NSString *urlStr = [NSString stringWithFormat:Destination_Content_Url,_destinationId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(urlStr)];
    if (cacheeData) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in arr) {
            DeatinatneDetailModel *model = [[DeatinatneDetailModel alloc]initWithDictionary:dic error:nil];
            [_dataSource addObject:model];
        }
        [self.tableView reloadData];
    }else{
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in arr) {
            DeatinatneDetailModel *model = [[DeatinatneDetailModel alloc]initWithDictionary:dic error:nil];
            [_dataSource addObject:model];
        }
        [JWCache setObject:responseObject forKey:MD5(urlStr)];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败%@",error);
    }];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    [self.tableView registerNib:[UINib nibWithNibName:@"DestinationDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"DestinationDetailTableViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DestinationDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DestinationDetailTableViewCell"];
    cell.backgroundColor = [UIColor clearColor];
    DeatinatneDetailModel *model = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell layoutCellWithModel:model];
    cell.button = ^(NSInteger tag){
        switch (tag) {
            case 10:
            {
                JourneyViewController *jvc = [[JourneyViewController alloc] init];
                jvc.journeyId = model.Did;
                [self.navigationController pushViewController:jvc animated:YES];
            }
                break;
                
             case 20:
            {
                TripsViewController *tvc = [[TripsViewController alloc] init];
                tvc.tripsId = model.Did;
                [self.navigationController pushViewController:tvc animated:YES];
            }
                break;
                
            default:
                break;
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.width/2 + [UIScreen mainScreen].bounds.size.width/9;
}

@end
