//
//  ShowViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/7/12.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ShowViewController.h"
#import "FCTabBarViewController.h"
@interface ShowViewController ()
@property(nonatomic,strong)UIButton * Nextbutton;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UIImageView * BgImage;
@property(nonatomic,strong)UILabel *Namelabel;
@property(nonatomic,strong)UILabel *Phonelabel;
@property(nonatomic,strong)UIView * Bview;
@end

@implementation ShowViewController
-(UIView *)Bview{
    if (!_Bview) {
        _Bview=[[UIView alloc]init];
        _Bview.backgroundColor=[UIColor whiteColor];
        _Bview.clipsToBounds=YES;
        _Bview.layer.cornerRadius=5;
    }return _Bview;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage=[[UIImageView alloc]init];
        _headImage.image=[UIImage imageNamed:@"资源背景头"];
       
    }return _headImage;
}
-(UIImageView *)BgImage{
    if (!_BgImage) {
        _BgImage=[[UIImageView alloc]init];
        _BgImage.image=[UIImage imageNamed:@"资源背景"];

    }return _BgImage;
}
-(UILabel *)Namelabel{
    if (!_Namelabel) {
        _Namelabel=[[UILabel alloc]init];
        if ([self.NickName isEmptyString]) {
            _Namelabel.text=@"";
        }else{
            _Namelabel.text=self.NickName;
        }
        _Namelabel.textAlignment=NSTextAlignmentCenter;
        _Namelabel.textColor=[UIColor blackColor];
        _Namelabel.font=[UIFont systemFontOfSize:15];
    }return _Namelabel;
}
-(UILabel *)Phonelabel{
    if (!_Phonelabel) {
        _Phonelabel=[[UILabel alloc]init];
        _Phonelabel.textAlignment=NSTextAlignmentCenter;
        _Phonelabel.text=self.phoneNum;
        _Phonelabel.textColor=[UIColor blackColor];
        _Phonelabel.font=[UIFont systemFontOfSize:15];
    }return _Phonelabel;
}
-(UIButton *)Nextbutton{
    if (!_Nextbutton) {
        _Nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_Nextbutton setBackgroundColor:UIColorFromHex(0xff9966)];
        _Nextbutton.clipsToBounds=YES;
        _Nextbutton.layer.cornerRadius=20;
        _Nextbutton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_Nextbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_Nextbutton addTarget:self action:@selector(NextbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_Nextbutton setTitle:@"确定" forState:UIControlStateNormal];
        
    }
    return _Nextbutton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"绑定账号";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
   
    
    [self.view addSubview:self.BgImage];
    [self.view addSubview:self.Bview];
    [self.view addSubview:self.headImage];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"绑定后，您可以通过第三方登录，快速登录到该账号";
    label.font=[UIFont systemFontOfSize:15];
    label.numberOfLines=0;
    label.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-130,140,  220, 40);
    [self.Bview addSubview:label];
    
    [self.Bview addSubview:self.Nextbutton];
    [self.Bview addSubview:self.Phonelabel];
    [self.Bview addSubview:self.Namelabel];
    [self SetFrame];
}
-(void)SetFrame{

        
    
    self.BgImage.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT);
    self.Bview.frame=CGRectMake(30, 200, APP_SCREEN_WIDTH-60, APP_SCREEN_HEIGHT-400);
    self.headImage.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-40, 160, 80,80);
    
    self.Namelabel.frame=CGRectMake(0,60,  APP_SCREEN_WIDTH-60, 20);
    self.Phonelabel.frame=CGRectMake(0,90,  APP_SCREEN_WIDTH-60, 20);
    self.Nextbutton.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-120,200,  180, 40);
    
    
    
}
-(void)NextbuttonClick{
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Platform":self.Platform,@"UserId":self.userId,@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Platform":self.Platform,@"UserId":self.userId,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:bindingAccount WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        
        NSLog(@"--第三方登录%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        
        
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            NSString * AccessToken=[NSString stringWithFormat:@"%@",dataDic[@"AccessToken"]];
            NSString * UserToken=[NSString stringWithFormat:@"%@",dataDic[@"UserToken"]];
            [self setValueName:AccessToken withKey:@"AccessToken"];
            [self setValueName:UserToken withKey:@"UserToken"];
            
            FCTabBarViewController *hand=[[FCTabBarViewController alloc]init];
            UIWindow *window=[UIApplication sharedApplication].delegate.window;
            window.rootViewController=hand;
            
        }
        else if ([msgStr isEqualToString:@"0"])
        {
            [self getNewToken];
            
        }
        else if ([msgStr isEqualToString:@"-1"])
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            
        }
        else if ([msgStr isEqualToString:@"-2"])
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            
        }
        else if ([msgStr isEqualToString:@"-3"])
        {
            [self gotoLogin];
            
        }
        else
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            
        }
        
        
    } withfail:^(NSString *errorMsg) {
        
    }];
    
}
-(void)popLeftItemView
{
    [self.navigationController popViewControllerAnimated:YES];
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
