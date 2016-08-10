//
//  TraveNoteViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/13.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "TraveNoteViewController.h"
#import "SkyAndEarth.h"
#import "TravelModel.h"
#import "TravelTableViewCell.h"
#import "MJRefresh.h"
#import "TravelNoteDetailViewController.h"
#import "JWCache.h"
#import "NSString+Tools.h"
#import "AFNetworking.h"


@interface TraveNoteViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation TraveNoteViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray new];
    // Do any additional setup after loading the view.
    [self loadDataSource];
    [self createTableView];
    _pageIndex++;
    [self createRefreshHeader];
    [self createRefreshFooter];
}

- (void)loadDataSource{
    NSString *urlString = nil;
    urlString = [NSString stringWithFormat:TravelNote_Url,self.pageIndex];
     NSData *cacheeData = [JWCache objectForKey:MD5(urlString)];
    if (cacheeData) {
         [self.tableView.mj_header endRefreshing];
         NSError *error = nil;
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:&error];
        if (_pageIndex == 1) {
            [self.tableView.mj_header endRefreshing];
            _dataSource = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                TravelModel *model = [[TravelModel alloc] initWithDictionary:dic error:&error];
                [_dataSource addObject:model];
            }
        }else{
            [self.tableView.mj_footer endRefreshing];
            if (arr.count >=10) {
                for (NSDictionary *dic in arr) {
                    TravelModel *model = [[TravelModel alloc] initWithDictionary:dic error:&error];
                    [_dataSource addObject:model];
                }
            }
        }
        [self.tableView reloadData];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy = securityPolicy;
        [manager.securityPolicy setAllowInvalidCertificates:YES];
        
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error = nil;
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            if (_pageIndex == 1) {
                [self.tableView.mj_header endRefreshing];
                _dataSource = [NSMutableArray new];
                for (NSDictionary *dic in arr) {
                    TravelModel *model = [[TravelModel alloc] initWithDictionary:dic error:&error];
                    [_dataSource addObject:model];
                }
            }else{
                [self.tableView.mj_footer endRefreshing];
                if (arr.count >=10) {
                    for (NSDictionary *dic in arr) {
                        TravelModel *model = [[TravelModel alloc] initWithDictionary:dic error:&error];
                        [_dataSource addObject:model];
                    }
                }
            }
            [JWCache setObject:responseObject forKey:MD5(urlString)];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"请求失败%@",error);
        }];
    }
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

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 0.58*[UIScreen mainScreen].bounds.size.width + 10;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"TravelTableViewCell" bundle:nil] forCellReuseIdentifier:@"TravelTableViewCell"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelTableViewCell *cell = [[TravelTableViewCell alloc] init];
    TravelModel *model = _dataSource[indexPath.row];
    [cell configCellWithTravelModel:model];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelModel *model = _dataSource[indexPath.row];
    TravelNoteDetailViewController *vc = [[TravelNoteDetailViewController alloc] init];
    vc.idStr = model.travelId;
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
