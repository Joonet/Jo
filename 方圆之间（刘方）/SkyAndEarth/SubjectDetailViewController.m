//
//  SubjectDetailViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/20.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SubjectDetailViewController.h"
#import "SkyAndEarth.h"
#import "AFNetworking.h"
#import "SubjectDetailModel.h"
#import "SubjectTextTableViewCell.h"
#import "TitleTableViewCell.h"
#import "SubjectPictureTableViewCell.h"
#import "TravelNoteDetailViewController.h"
#import "ImageScrollowViewController.h"
#import "TravelModel.h"
#import "JWCache.h"
#import "NSString+Tools.h"
#import "MBProgressHUD+Add.h"

@interface SubjectDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)SubjectDetailModel *model;


@end

@implementation SubjectDetailViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    [self createTableView];
    [MBProgressHUD showMessag:@"努力加载中" toView:_tableView];
    [self loadDataSource];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataSource{
    NSString *urlStr = [NSString stringWithFormat:subjectDetailUrl,_subjectId];
//    NSLog(@"%@",urlStr);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    NSData *cacheeData = [JWCache objectForKey:MD5(urlStr)];
    if (cacheeData) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:cacheeData options:NSJSONReadingMutableContainers error:nil];
        _model = [[SubjectDetailModel alloc] initWithDictionary:dic error:nil];
        [_dataSource addObject:_model];
        NSArray *arr = dic[@"article_sections"];
        for (NSDictionary *dict in arr) {
            ArticleSectionsModel *model = [[ArticleSectionsModel alloc] initWithDictionary:dict error:nil];
            [_dataSource addObject:model];
        }
        [self.tableView reloadData];
    }else{
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _model = [[SubjectDetailModel alloc] initWithDictionary:dic error:nil];
        [_dataSource addObject:_model];
        NSArray *arr = dic[@"article_sections"];
        for (NSDictionary *dict in arr) {
            ArticleSectionsModel *model = [[ArticleSectionsModel alloc] initWithDictionary:dict error:nil];
            [_dataSource addObject:model];
        }
        [JWCache setObject:responseObject forKey:MD5(urlStr)];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
        [MBProgressHUD hideAllHUDsForView:_tableView animated:NO];
    }];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"TitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"TitleTableViewCell"];
    [_tableView registerClass:[SubjectTextTableViewCell class] forCellReuseIdentifier:@"SubjectTextTableViewCell"];
    [_tableView registerClass:[SubjectPictureTableViewCell class] forCellReuseIdentifier:@"SubjectPictureTableViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - 协议方法



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        SubjectDetailModel *model = _dataSource[indexPath.row];
        [cell layoutTitleCellWithModel:model];
        return cell;
    }else{
        ArticleSectionsModel *model = _dataSource[indexPath.row];
        if (model.image_url.length >10) {
            SubjectPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectPictureTableViewCell" forIndexPath:indexPath];
            [cell layoutPictureWithModel:model];
            return cell;
        }else{
            SubjectTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectTextTableViewCell" forIndexPath:indexPath];
            [cell layoutTextCellWithModel:model];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [UIScreen mainScreen].bounds.size.width*81/160;
    }else{
        ArticleSectionsModel *model = _dataSource[indexPath.row];
        if (model.image_url.length >10) {
            NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
            CGRect rect = [model.ZTDdescription boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
            return [model.image_height floatValue]/[model.image_width floatValue]*([UIScreen mainScreen].bounds.size.width - 20) + 8 +rect.size.height+10;
        }else{
            NSDictionary * arr = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
            CGRect rect = [model.ZTDdescription boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arr context:nil];
            return rect.size.height+10;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SubjectDetailModel *model = _dataSource[indexPath.row];
    }else{
        ArticleSectionsModel *model = _dataSource[indexPath.row];
        if (model.image_url) {
            if (model.NoteTripId) {
                TravelNoteDetailViewController *vc = [[TravelNoteDetailViewController alloc] init];
                TravelModel *travelModel = [[TravelModel alloc] init];
                travelModel.travelId = model.NoteTripId;
                travelModel.name = model.NoteTripName;
                travelModel.start_date = @"1970";
                travelModel.days = @"8";
                travelModel.photos_count = @"66";
                travelModel.userImage = model.NoteUserName;
                travelModel.front_cover_photo_url = model.image_url;
                vc.idStr = model.NoteTripId;
                vc.model = travelModel;
                [self.navigationController pushViewController:vc animated:YES];
            }else if(model.image_url.length >10){
                ImageScrollowViewController *svc = [[ImageScrollowViewController alloc] init];
                svc.image_url = model.image_url;
                svc.image_height = model.image_height;
                svc.image_width = model.image_width;
                NSLog(@"专题模型%@",model);
                [self presentViewController:svc animated:NO completion:nil];
            }
        }
    }
}


@end
