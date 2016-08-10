//
//  MainTabBarViewController.m
//  SkyAndEarth
//
//  Created by qianfeng0 on 16/4/13.
//  Copyright © 2016年 刘方. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "TraveNoteViewController.h"
#import "MeViewController.h"
#import "DestinationViewController.h"
#import "SubjectViewController.h"
#import "MainModel.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTabBarViewController];
}

- (void)createTabBarViewController{
    NSArray *dataArray = [self configModelData];
   
    for (MainModel *model in dataArray) {
        LFBaseViewController *bvc = [[NSClassFromString(model.classname) alloc] init];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:bvc];
        bvc.title = model.title;
        bvc.tabBarItem.image = [[UIImage imageNamed:model.image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        bvc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_hl",model.image]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        [[UITabBarItem appearance] setTitleTextAttributes:dic forState:UIControlStateNormal];
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor redColor]];
        [self addChildViewController:nc];
    }
  
}

- (NSArray *)configModelData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tabbar" ofType:@"plist"];
    NSArray *tabBarArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *modelArray = [MainModel arrayOfModelsFromDictionaries:tabBarArray];
    return modelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
