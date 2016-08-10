//
//  SettingViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/5/4.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "JWCache.h"
#import "UIImageView+WebCache.h"
#import "UIView+Common.h"
#import "GiFHUD.h"
#import "MeViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *_titleArr;
    NSArray *_imageArr;
    CGFloat _fileSize;
    UIView *_view1;
    UITextView *_text2;
}

@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    _fileSize = [JWCache fileSize] + ([[SDImageCache sharedImageCache] getSize]/(1024.0*1024.0));
    //_fileCount.text = [NSString stringWithFormat:@"%.2fM缓存",_fileSize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = @[@"关于我们",@"意见反馈",@"我的收藏",@"清空缓存"];
    _imageArr = @[@"ic_more_about",@"ic_more_feedback",@"ic_more_notification",@"ic_more_action_clean_cache"];
    self.navigationItem.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self createViews];
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)createViews{
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, height(self.view), width(self.view), 230)];
    //    _view1.backgroundColor = [UIColor colorWithRed:230/255.0 green:232/255.0 blue:239/255.0 alpha:1.0];
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, width(_view1)-20, 190)];
    text.text = @"这是一款走心的游记类App。那些一生难得一见的美景怎么忍心让它们只存在于我们的内存里，10分钟写出漂亮的游记。有时，生命只是一组镜头，旅途中匆匆而过的行人，你会从相片和文字中看到过去的样子，然后继续踏上旅途。\n合作联系：QQ1102253945";
    text.font = [UIFont systemFontOfSize:15];
    text.textColor = [UIColor grayColor];
    text.numberOfLines = 0;
    
    text.backgroundColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake((width(_view1)-60)/2, height(_view1)-30, 60, 30);
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(showView1) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:button1];
    [_view1 addSubview:text];
    [self.view addSubview:_view1];
}

-(void)showView1{
    [UIView animateWithDuration:0.5 animations:^{
        _view1.transform = CGAffineTransformIdentity;
    }];
    
}

#pragma mark - 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger num = indexPath.row;
    static NSString *identifier = nil;
    switch (num) {
        case 0:
            identifier = @"cell0";
            break;
        
        case 1:
            identifier = @"cell1";
            break;
         
        case 2:
            identifier = @"cell2";
            break;
        
        case 3:
            identifier = @"cell3";
            break;
            
        default:
            break;
    }
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setDataWithTitle:_titleArr[indexPath.row] Title2:_fileSize imageName:_imageArr[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger num = indexPath.row;
    switch (num) {
        case 0:
        {
            [UIView animateWithDuration:0.5 animations:^{
                _view1.transform = CGAffineTransformMakeTranslation(0, -height(self.view)+64);
            }];
        }
            
            break;
            
        case 1:
        {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入您宝贵的意见" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入200字以内......";
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self performSelector:@selector(thankView) withObject:nil afterDelay:1.5];
                [GiFHUD showWithOverlay];
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:action1];
            [alertController addAction:action2];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
            
            
            break;
        case 2:
        {
            MeViewController *vc = [[MeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3:
        {
            [JWCache resetCache];
            [[SDImageCache sharedImageCache] clearDisk];
            _fileSize = 0;
            [_tableView reloadData];
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:@"缓存清理成功" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [controller addAction:action];
            
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        
        default:
            break;
    }
}

-(void)thankView{
    [GiFHUD dismiss];
    _text2.text = @"";
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"已发送" message:@"感谢您的反馈，我们会做的更好！" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:action];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end
