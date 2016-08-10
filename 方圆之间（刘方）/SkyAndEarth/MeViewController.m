//
//  MeViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/13.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "MeViewController.h"
#import "DBManager.h"
#import "MYCollectionTableViewCell.h"
#import "TravelNoteDetailViewController.h"

@interface MeViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) UIImageView *nothingImageView;

@property (nonatomic,strong) UILabel *tipsLabel;

@property (nonatomic,strong) UIImageView *tipImageView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    self.navigationItem.title = @"我的收藏";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getdataFromDBmanager];
    self.navigationController.navigationBarHidden = NO;
}

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
- (void)getdataFromDBmanager{
    NSArray *models = [[DBManager sharedManager] readModels];
    _dataSource = models;
    if (_nothingImageView == nil) {
        _nothingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EmptyPlaceholder"]];
    }
    
    _nothingImageView.contentMode = UIViewContentModeCenter;
    if (_tipImageView == nil) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, HEIGHT-100, 90, 50)];
    }
    if (_tipsLabel == nil) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, HEIGHT-130, 200, 50)];
    }
    _tipsLabel.adjustsFontSizeToFitWidth = YES;
    _tipsLabel.text = @"快去收藏自己喜欢的游记吧~";
    _tipsLabel.textColor = [UIColor lightGrayColor];
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipImageView.image = [UIImage imageNamed:@"jiantoutou"];
    if (_dataSource.count == 0) {
        _tableView.backgroundView = _nothingImageView;
        [self.view addSubview:_tipsLabel];
        [self.view addSubview:_tipImageView];
    }else {
        _tableView.backgroundView = nil;
        [_tipImageView removeFromSuperview];
        [_tipsLabel removeFromSuperview];
    }
    [_tableView reloadData];

}

-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identidier=@"cellId";
    MYCollectionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[MYCollectionTableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identidier];
        // 设置选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.model = _dataSource[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.width*0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelModel *model = _dataSource[indexPath.row];
    TravelNoteDetailViewController *vc = [[TravelNoteDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.idStr = model.travelId;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
