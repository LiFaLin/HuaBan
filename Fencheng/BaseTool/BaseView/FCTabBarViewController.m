//
//  FCTabBarViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/5.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "FCTabBarViewController.h"
#import "FCNavViewController.h"
#import "cengjiViewController.h"
#import "HuabuViewController.h"
#import "MyViewController.h"
@interface FCTabBarViewController ()

@end

@implementation FCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].tintColor = [UIColor redColor];
    
    cengjiViewController *cj=[[cengjiViewController alloc]init];
    FCNavViewController*nav1=[[FCNavViewController alloc]initWithRootViewController:cj];
    cj.navigationItem.title=@"我的呈记";
    cj.tabBarItem.title=@"呈记";
    cj.tabBarItem.image = [UIImage imageNamed:@"底部11"];
    cj.tabBarItem.selectedImage=[[UIImage imageNamed:@"底部1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HuabuViewController *huabu=[[HuabuViewController alloc]init];
    FCNavViewController*nav11=[[FCNavViewController alloc]initWithRootViewController:huabu];
    huabu.navigationItem.title=@"选择画布";
    huabu.tabBarItem.image = [[UIImage imageNamed:@"底部2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    huabu.tabBarItem.selectedImage=[[UIImage imageNamed:@"底部2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置图片位置
    huabu.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    MyViewController*jfdh=[[MyViewController alloc]init];
    FCNavViewController*nav2=[[FCNavViewController alloc]initWithRootViewController:jfdh];
    
    jfdh.tabBarItem.title=@"我的";
    jfdh.tabBarItem.image = [UIImage imageNamed:@"底部31"];
    jfdh.tabBarItem.selectedImage=[[UIImage imageNamed:@"底部3"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSArray *arr=[NSArray arrayWithObjects:nav1,nav11,nav2, nil];
    self.viewControllers=arr;
    
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
