//
//  JourneyViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/19.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "JourneyViewController.h"
#import "SkyAndEarth.h"
#import "AFNetworking.h"
#import "JournneyModel.h"
#import "xingchengTabelViewCell.h"
#import "JWCache.h"
#import "NSString+Tools.h"

@interface JourneyViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation JourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDataSource];
    [self createTableView];
}

- (void)loadDataSource{
    NSString *journeyStr = [NSString stringWithFormat:XingChengURL,self.journeyId];
//    NSLog(@"%@",journeyStr);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(journeyStr)];
    if (cacheeData) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in arr) {
            JournneyModel *model = [[JournneyModel alloc] initWithDictionary:dict error:nil];
            [_dataSource addObject:model];
        }
        [self.tableView reloadData];
        
    }else{
    [manager GET:journeyStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in arr) {
            JournneyModel *model = [[JournneyModel alloc] initWithDictionary:dict error:nil];
            [_dataSource addObject:model];
        }
        [JWCache setObject:responseObject forKey:MD5(journeyStr)];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"xingchengTabelViewCell" bundle:nil] forCellReuseIdentifier:@"xingchengTabelViewCell"];
    [self.view addSubview:_tableView];
}

#pragma mark - 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xingchengTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xingchengTabelViewCell"];
    cell.selected=NO;
    JournneyModel *model = _dataSource[indexPath.row];
    [cell layoutCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JournneyModel *model = _dataSource[indexPath.row];
    NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGRect rect = [model.Description boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
    
    return [UIScreen mainScreen].bounds.size.width/2 + rect.size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
