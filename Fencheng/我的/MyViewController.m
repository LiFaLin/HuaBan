//
//  MyViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/8.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "MyViewController.h"
#import "FCLoginViewController.h"
#import "PersonViewController.h"
#import "FCTabBarViewController.h"
#import "MyTableViewCell.h"
#import "AboutViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * NameNumberArr;
    NSMutableArray * DetailNumberArr;
    NSString* nickName;
    NSString * Photo_Small;
}
@property(nonatomic,strong)UITableView * PersonTableView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UIImageView * headjq;
@property(nonatomic,strong)UILabel *Namelabel;
@property(nonatomic,strong)UIButton * LoginButton;
@property(nonatomic,strong)UIButton * LogoutButton;
@property(nonatomic,strong)NSString*banben;
@end

@implementation MyViewController
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage=[[UIImageView alloc]init];
        _headImage.image=[UIImage imageNamed:@"xiaoxiongtou"];
        _headImage.layer.cornerRadius=30;
        _headImage.clipsToBounds=YES;
    }return _headImage;
}
-(UILabel *)Namelabel{
    if (!_Namelabel) {
        _Namelabel=[[UILabel alloc]init];
        _Namelabel.text=@"未登录";
        _Namelabel.textColor=[UIColor whiteColor];
        _Namelabel.font=[UIFont systemFontOfSize:15];
    }return _Namelabel;
}
-(UIImageView *)headjq{
    if (!_headjq) {
        _headjq=[[UIImageView alloc]init];
        _headjq.image=[UIImage imageNamed:@"headerjq"];
    }return _headjq;
}
-(UIButton *)LoginButton{
    if (!_LoginButton) {
        _LoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_LoginButton addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
        
    }return _LoginButton;
}
-(UIButton *)LogoutButton{
    if (!_LogoutButton) {
        _LogoutButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_LogoutButton addTarget:self action:@selector(LogoutButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_LogoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_LogoutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_LogoutButton setBackgroundColor:[UIColor whiteColor]];
    }return _LogoutButton;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [self isdenglu];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColorFromRGBA(245, 245, 245, 1);
    

    //颜色的渲染
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)UIColorFromHex(0xff9966).CGColor, (__bridge id)UIColorFromHex(0xff4d51).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    [self.view.layer addSublayer:gradientLayer];
    
    
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.Namelabel];
    [self.view addSubview:self.headjq];
    [self.view addSubview:self.LoginButton];
    [self.view addSubview:self.LogoutButton];
    [self setFrame];
    
//    NameNumberArr=[NSMutableArray arrayWithCapacity:0];
    DetailNumberArr=[NSMutableArray arrayWithCapacity:0];
    
//    NSArray *arr=@[@"关于"];
    
//    NameNumberArr=[NSMutableArray arrayWithArray:arr];
    
    _PersonTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, APP_SCREEN_WIDTH, 120) style:UITableViewStylePlain];
    _PersonTableView.delegate=self;
    _PersonTableView.dataSource=self;
    _PersonTableView.rowHeight=70;
    _PersonTableView.scrollEnabled=NO;
    _PersonTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    _PersonTableView.separatorStyle=UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_PersonTableView];
    [self.PersonTableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
   
    
    
    
}
-(void)setFrame{
    self.headImage.frame=CGRectMake(30, 70, 60, 60);
    self.Namelabel.frame=CGRectMake(110, 0, 200, 200);
    self.headjq.frame=CGRectMake(APP_SCREEN_WIDTH-30, 200/2.0-7, 8, 14);
    self.LoginButton.frame=CGRectMake(0, 0, APP_SCREEN_WIDTH, 200);
    self.LogoutButton.frame=CGRectMake(0, 460, APP_SCREEN_WIDTH, 40);
}
-(void)loginButton{
    

    NSString *UserToken= [self objectValueWith:@"UserToken"];
    if (UserToken.length<10) {
        FCLoginViewController *fc=[[FCLoginViewController alloc]init];
        FCNavViewController *nav=[[FCNavViewController alloc]initWithRootViewController:fc];
        UIWindow *window=[[UIApplication sharedApplication]delegate].window;
        window.rootViewController=nav;
    }
    else{
        PersonViewController *person=[[PersonViewController alloc]init];
        [self.navigationController pushViewController:person animated:YES];
    }
   
    
}
-(void)isdenglu{
     NSString *UserToken= [self objectValueWith:@"UserToken"];
    if (UserToken.length<10) {
        
    }
    else{
        [self loadUserInfo];
    }
}
-(void)loadUserInfo{
//    [self getNewToken];
    [DetailNumberArr removeAllObjects];
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
   
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:getUserInfo WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"获取用户信息%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            NSDictionary *dataDic1=[dataDic objectForKey:@"UserInfo"];
            self->_banben=dataDic[@"iPhoneClientVersion"];
            self->nickName=[NSString stringWithFormat:@"%@",dataDic1[@"Nickname"]];
            self->Photo_Small=[NSString stringWithFormat:@"%@",dataDic1[@"Photo_Small"]];
            NSString *phone=[NSString stringWithFormat:@"%@",dataDic1[@"PhoneNumber"]];
            if ([self->nickName isEmptyString]) {
               self->_Namelabel.text= [phone replacePhone];
            }else{
                self->_Namelabel.text=self->nickName;
            }
            if ([self->Photo_Small isEmptyString]) {
                self->_headImage.image=[UIImage imageNamed:@"xiaoxiongtou"];
            }else{
                [self->_headImage sd_setImageWithURL:[NSURL URLWithString:self->Photo_Small] placeholderImage:[UIImage imageNamed:@""]];
            }
            
            
//            self->_LogoutButton.hidden=NO;
            [self.PersonTableView reloadData];
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


#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
        return 1;
  
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
        MyTableViewCell *Ocell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyTableViewCell class])];
        Ocell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.section==0)
        {
          NSString *name=@"我的呈记";
          Ocell.nameLabel.text=name;
        }
        else
        {
//          NSString *name=[NSString stringWithFormat:@"%@",NameNumberArr[indexPath.row]];
            if ([self.banben compare:app_Version options:NSCaseInsensitiveSearch]>0){
                Ocell.rightImage1.hidden=NO;
            }else{
                 Ocell.rightImage1.hidden=YES;
            }
          Ocell.nameLabel.text=@"关于";
        }
    
        
    
        
        return Ocell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        //返回的是呈记
        self.navigationController.tabBarController.selectedIndex=0;
    }else{
        AboutViewController * ab=[[AboutViewController alloc]init];
        ab.banben=self.banben;
        [self.navigationController pushViewController:ab animated:YES];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]init];
    
    headerView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1);
    
    return headerView;
    
}
#pragma 退出登录
-(void)LogoutButtonClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *AccessToken= [self objectValueWith:@"AccessToken"];
        
        if (AccessToken.length<1) {
            AccessToken=@"12123456789878765453423456789876";
        }
        NSDictionary *dic=@{@"AccessToken":AccessToken};
        
        NSString *string= [self createSign:dic];
        
        NSDictionary *param=@{@"Sign":string};
        [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:logout WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
            
            
        } withfail:^(NSString *errorMsg) {
            
        }];
        FCLoginViewController *fc=[[FCLoginViewController alloc]init];
        FCNavViewController *nav=[[FCNavViewController alloc]initWithRootViewController:fc];
        UIWindow *window=[[UIApplication sharedApplication]delegate].window;
        window.rootViewController=nav;
        
    }];
    UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
       
    }];
    [alertController addAction:confirm];
    [alertController addAction:cance];
    [self presentViewController:alertController animated:YES completion:nil];
   
}
#pragma 当code=0的时候重新获取token，并且监听返回时，重新加载该方法。 对应的pama或者type可以用fcappinfo里面进行配置。
-(void)getSecond{
    [self loadUserInfo];
}
@end
