//
//  SubjectViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/13.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SubjectViewController.h"
#import "AFNetworking.h"
#import "SkyAndEarth.h"
#import "ZhuanTiTableViewCell.h"
#import "SubjectModel.h"
#import "MJRefresh.h"
#import "SubjectDetailViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"
#import "MBProgressHUD+Add.h"

@interface SubjectViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) UITableView *tableView;

@property (nonatomic,copy) NSMutableArray *dataSource;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    _pageIndex = 1;
    [self createTableView];
    [MBProgressHUD showMessag:@"努力加载中" toView:_tableView];
    [self createRefreshFooter];
    [self createRefreshHeader];
    [self loadDataSource];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)loadDataSource{
    NSString *urlStr = [NSString stringWithFormat:subjectUrl,_pageIndex];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(urlStr)];
    if (cacheeData) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"%@",arr);
        if (_pageIndex == 1) {
            //下拉条件
            [self.tableView.mj_header endRefreshing];
            _dataSource = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                SubjectModel *model = [[SubjectModel alloc] initWithDictionary:dic error:nil];
                [_dataSource addObject:model];
            }
        }else {
            if (arr.count >= 10) {
                for (NSDictionary *dic in arr) {
                    SubjectModel *model = [[SubjectModel alloc] initWithDictionary:dic error:nil];
                    [_dataSource addObject:model];
                }
                [self.tableView.mj_footer endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.tableView reloadData];
    }else{
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (_pageIndex == 1) {
            //下拉条件
            [self.tableView.mj_header endRefreshing];
            _dataSource = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                SubjectModel *model = [[SubjectModel alloc] initWithDictionary:dic error:nil];
                [_dataSource addObject:model];
            }
        }else {
            if (arr.count >= 10) {
                for (NSDictionary *dic in arr) {
                    SubjectModel *model = [[SubjectModel alloc] initWithDictionary:dic error:nil];
                    [_dataSource addObject:model];
                }
                [self.tableView.mj_footer endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [JWCache setObject:responseObject forKey:MD5(urlStr)];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败");
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
    }];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"SubjectFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"SubjectFirstTableViewCell"];
    [_tableView registerClass:[ZhuanTiTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
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

#pragma mark - 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZhuanTiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    SubjectModel *model = _dataSource[indexPath.row];
    [cell layoutCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return ([UIScreen mainScreen].bounds.size.width-20)*0.58+8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectModel *model = _dataSource[indexPath.row];
    SubjectDetailViewController *dvc = [[SubjectDetailViewController alloc] init];
    dvc.subjectId = model.ZTid;
    dvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
