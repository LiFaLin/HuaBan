//
//  AboutViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/28.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *rightImage;  //
@property (nonatomic, strong)UILabel *nameLabel1;
@property (nonatomic, strong)UIImageView *rightImage1;  //
@property (nonatomic, strong)UIImageView *rightImage2;  //
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于纷呈";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    self.view.backgroundColor=UIColorFromRGBA(245, 245, 245, 1);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageNamed:@"logo"];
    imageView.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-20, 150, 40, 40);
    [self.view addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=[NSString stringWithFormat:@"纷呈 v%@",app_Version];
    label.frame=CGRectMake(0, 200, APP_SCREEN_WIDTH, 20);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=[UIColor lightGrayColor];
    [self.view addSubview:label];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(0, 250, APP_SCREEN_WIDTH, 40);
    button.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:button];
    
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.frame=CGRectMake(20, 0, 100, 40);
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.text=@"去评分";
    [button addSubview:_nameLabel];
    
    _rightImage = [[UIImageView alloc] init];
    _rightImage.image=[UIImage imageNamed:@"huisejq"];
    _rightImage.frame=CGRectMake(APP_SCREEN_WIDTH-20, 12, 6, 15);
    [button addSubview:_rightImage];
  
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button1.frame=CGRectMake(0, 291, APP_SCREEN_WIDTH, 40);
    button1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:button1];
    
    _nameLabel1=[[UILabel alloc]init];
    _nameLabel1.frame=CGRectMake(20, 0, 100, 40);
    _nameLabel1.font=[UIFont systemFontOfSize:15];
    _nameLabel1.textColor=[UIColor blackColor];
    _nameLabel1.text=@"版本更新";
    [button1 addSubview:_nameLabel1];
    
    _rightImage2 = [[UIImageView alloc] init];
    
    
    if ([self.banben compare:app_Version options:NSCaseInsensitiveSearch]>0){
        _rightImage2.image=[UIImage imageNamed:@"banben"];
    }else{
       _rightImage2.image=[UIImage imageNamed:@""];
    }
    _rightImage2.frame=CGRectMake(APP_SCREEN_WIDTH-45, 12, 15, 15);
    [button1 addSubview:_rightImage2];
    _rightImage1 = [[UIImageView alloc] init];
    _rightImage1.image=[UIImage imageNamed:@"huisejq"];
    _rightImage1.frame=CGRectMake(APP_SCREEN_WIDTH-20, 12, 6, 15);
    [button1 addSubview:_rightImage1];
    
    
    UILabel *banquan=[[UILabel alloc]init];
    banquan.text=@"Copyright 2018 ©️ IRIETS TEAM";
    banquan.font=[UIFont systemFontOfSize:13];
    banquan.frame=CGRectMake(0, APP_SCREEN_HEIGHT-100, APP_SCREEN_WIDTH, 20);
    banquan.textColor=[UIColor lightGrayColor];
    banquan.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:banquan];
}
-(void)popLeftItemView
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)buttonClick{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/fen-cheng/id1388822569"]];
}

@end
