//
//  TripsViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "TripsViewController.h"
#import "AFNetworking.h"
#import "SkyAndEarth.h"
#import "TripsModel.h"
#import "xingchengTabelViewCell.h"
#import "TripsTableViewCell.h"
#import "MJRefresh.h"
#import "JWCache.h"
#import "NSString+Tools.h"

@interface TripsViewController ()  <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation TripsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _pageIndex = 1;
    [self loadDataSource];
    [self createTableView];
    [self createRefreshFooter];
    [self createRefreshHeader];
}

- (void)loadDataSource{
    
    NSString *urlStr = [NSString stringWithFormat:LvXingDiURL,[self.tripsId intValue],_pageIndex];
//    NSLog(@"%@",urlStr);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(urlStr)];
    if (cacheeData) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:nil];
        if (_pageIndex == 1) {
            //下拉条件
            [self.tableView.mj_header endRefreshing];
            _dataSource = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                TripsModel *model = [[TripsModel alloc] initWithDictionary:dic error:nil];
                [_dataSource addObject:model];
            }
        }else {
            if (arr.count >= 10) {
                [self.tableView.mj_footer endRefreshing];
                for (NSDictionary *dic in arr) {
                    TripsModel *model = [[TripsModel alloc] initWithDictionary:dic error:nil];
                    [_dataSource addObject:model];
                }
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
        
        [self.tableView reloadData];
    }else{
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"请求成功");
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (_pageIndex == 1) {
            //下拉条件
            [self.tableView.mj_header endRefreshing];
            _dataSource = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                TripsModel *model = [[TripsModel alloc] initWithDictionary:dic error:nil];
                [_dataSource addObject:model];
            }
        }else {
            if (arr.count >= 10) {
                [self.tableView.mj_footer endRefreshing];
                for (NSDictionary *dic in arr) {
                    TripsModel *model = [[TripsModel alloc] initWithDictionary:dic error:nil];
                    [_dataSource addObject:model];
                }
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
       
        [JWCache setObject:responseObject forKey:MD5(urlStr)];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)createRefreshHeader{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageIndex = 1;
        [self loadDataSource];
    }];
}

- (void)createRefreshFooter{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _pageIndex++;
        [self loadDataSource];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

#define BLUECOLOR [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:0.5]

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TripsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.cornerRadius = 15;
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = BLUECOLOR;
    cell.model = _dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripsModel *model = _dataSource[indexPath.row];
    return [model.cellHight floatValue];
}

@end
