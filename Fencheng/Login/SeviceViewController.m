//
//  SeviceViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/19.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "SeviceViewController.h"

@interface SeviceViewController (){
    UIWebView *webView;
}

@end

@implementation SeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"服务协议";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    webView=[[UIWebView alloc]init];
    webView.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT);
    [webView setScalesPageToFit:YES];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.fenchengtech.com/fencheng/terms.docx"]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
 
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
