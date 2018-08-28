//
//  FCLoginViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/4.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "FCLoginViewController.h"
#import "HandAViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "FCTabBarViewController.h"
#import "ThirdLoginViewController.h"
#import "SeviceViewController.h"
#import "WXApi.h"
@interface FCLoginViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate,WXApiDelegate,TencentSessionDelegate>{
     TencentOAuth *tencentOAuth;
    NSArray *permissions;
}
@property(nonatomic,strong)UIImageView*bgView;
@property(nonatomic,strong)UITextField * phoneTF;
@property(nonatomic,strong)UITextField * pwTF;
@property(nonatomic,strong)UIButton * Phonebutton;
@property(nonatomic,strong)UIButton * registerLabel;
@property(nonatomic,strong)UIButton * QQbutton;
@property(nonatomic,strong)UIButton * WXbutton;
@property(nonatomic,strong)UIButton * FGbutton;


//
@end

@implementation FCLoginViewController

-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
       
    }
    return _bgView;
}
-(UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF=[[UITextField alloc]init];
        _phoneTF.placeholder=@"请输入手机号";
        _phoneTF.backgroundColor=UIColorFromHex(0xf7f7f7);
        _phoneTF.layer.cornerRadius=2;
        _phoneTF.clipsToBounds=YES;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 15)];
        [_phoneTF setLeftView:leftView];
        _phoneTF.leftViewMode = UITextFieldViewModeAlways;
        _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phoneTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _phoneTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _phoneTF;
}
-(UITextField *)pwTF{
    if (!_pwTF) {
        _pwTF=[[UITextField alloc]init];
        _pwTF.placeholder=@"请输入密码";
        _pwTF.backgroundColor=UIColorFromHex(0xf7f7f7);
        _pwTF.layer.cornerRadius=2;
        _pwTF.clipsToBounds=YES;
        _pwTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_pwTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _pwTF.secureTextEntry=YES;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 15)];
        [_pwTF setLeftView:leftView];
        _pwTF.leftViewMode = UITextFieldViewModeAlways;
        _pwTF.delegate=self;
        _pwTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _pwTF;
}
-(UIButton *)Phonebutton{
    if (!_Phonebutton) {
        _Phonebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        _Phonebutton.clipsToBounds=YES;
        _Phonebutton.layer.cornerRadius=4;
        _Phonebutton.backgroundColor=UIColorFromHex(0xff9966);
        _Phonebutton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_Phonebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_Phonebutton addTarget:self action:@selector(PhonebuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_Phonebutton setTitle:@"登录" forState:UIControlStateNormal];
        
    }
    return _Phonebutton;
}
-(UIButton *)registerLabel{
    if (!_registerLabel) {
        _registerLabel=[UIButton buttonWithType:UIButtonTypeCustom];
        [_registerLabel setTitle:@"注册账号" forState:UIControlStateNormal];
        [_registerLabel setTitleColor:UIColorFromHex(0x3980b3) forState:UIControlStateNormal];
        _registerLabel.titleLabel.font=[UIFont systemFontOfSize:13];
        _registerLabel.titleLabel.textAlignment=NSTextAlignmentRight;
        _registerLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_registerLabel addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerLabel;
}

//-(UIButton *)QQbutton{
//    if (!_QQbutton) {
//
//
//    }
//    return _QQbutton;
//}
//-(UIButton *)WXbutton{
//    if (!_WXbutton) {
//        _WXbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//
//        _WXbutton.clipsToBounds=YES;
//        _WXbutton.layer.cornerRadius=25;
//        [_WXbutton addTarget:self action:@selector(WXbuttonClick) forControlEvents:UIControlEventTouchUpInside];
//        [_WXbutton setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
//    }return _WXbutton;
//}
-(UIButton *)FGbutton{
    if (!_FGbutton) {
        _FGbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_FGbutton addTarget:self action:@selector(FGButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_FGbutton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _FGbutton.titleLabel.font=[UIFont systemFontOfSize:13];
        [_FGbutton setTitleColor:UIColorFromHex(0x3980b3) forState:UIControlStateNormal];
        _FGbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        
    }return _FGbutton;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *phone=[self objectValueWith:@"phone"];
    NSString *password=[self objectValueWith:@"password"];
    if (phone.length<11) {
        
    }else{
        self.phoneTF.text=phone;
        self.pwTF.text=password;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1106874265"andDelegate:self];
    permissions= [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil ];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.phoneTF];
    [self.view addSubview:self.pwTF];
    [self.view addSubview:self.Phonebutton];
    [self.view addSubview:self.registerLabel];
//    [self.view addSubview:self.QQbutton];
    [self.view addSubview:self.WXbutton];
    [self.view addSubview:self.FGbutton];
   
    NSString *deviceType = [UIDevice currentDevice].model;
    NSLog(@"--%@",deviceType);
    
    if ([deviceType isEqualToString:@"iPhone"])
    {
        if ([TencentOAuth iphoneQQInstalled])
        {
            [self createOtherUI];
        }
        else
        {
            [self createOtherUI1];
        }
        
    }
    else
    {
        if ([TencentOAuth iphoneQQInstalled]&&[WXApi isWXAppInstalled]) {
            [self createOtherUI];
        }
        else if([TencentOAuth iphoneQQInstalled]&&![WXApi isWXAppInstalled]){
            [self createOtherUI2];
        }
        else if(![TencentOAuth iphoneQQInstalled]&&[WXApi isWXAppInstalled])
        {
            [self createOtherUI1];
        }
        else{
            
        }
    }
    
   
    
    
    [self SetFrame];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatDidLoginNotification:) name:@"wechatDidLoginNotification" object:nil];

    

    
}
-(void)wechatDidLoginNotification:(NSNotification*)notification{
    NSString *code= notification.userInfo[@"code"];
    [self thirdPartyLogin:code];
}
- (void)thirdPartyLogin:(NSString *)code
{
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Platform":@"WeChat",@"Code":code,@"AccessToken":AccessToken,@"Device":[NSString deviceModelName]};
    NSString *string=[self createSign:dic];
    NSDictionary *param=@{@"Platform":@"WeChat",@"Code":code,@"Sign":string,@"Device":[NSString deviceModelName]};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:thirdPartyLogin WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"-weixin-%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            NSString * falseStr=[NSString stringWithFormat:@"%@",dataDic[@"HasPhoneNumber"]];
            NSString * AccessToken=[NSString stringWithFormat:@"%@",dataDic[@"AccessToken"]];
            NSString * UserToken=[NSString stringWithFormat:@"%@",dataDic[@"UserToken"]];
            [self setValueName:AccessToken withKey:@"AccessToken"];
            [self setValueName:UserToken withKey:@"UserToken"];
            
            if ([falseStr isEqualToString:@"FALSE"]) {
                ThirdLoginViewController *third=[[ThirdLoginViewController alloc]init];
                third.Platform=@"WeChat";
                [self.navigationController pushViewController:third animated:YES];
            }else{
                FCTabBarViewController *hand=[[FCTabBarViewController alloc]init];
                
                UIWindow *window=[UIApplication sharedApplication].delegate.window;
                window.rootViewController=hand;
            }
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


-(void)createOtherUI{
   
    
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"-第三方账号登录-";
    label.font=[UIFont systemFontOfSize:13];
    label.frame=CGRectMake(0, APP_SCREEN_HEIGHT/2.0+150, APP_SCREEN_WIDTH, 30);
    label.textColor=[UIColor lightGrayColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
   
    _WXbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    _WXbutton.frame=CGRectMake(self.view.frame.size.width/2.0+20, APP_SCREEN_HEIGHT/2.0+190, 50, 50);
    _WXbutton.clipsToBounds=YES;
    _WXbutton.layer.cornerRadius=25;
    [_WXbutton addTarget:self action:@selector(WXbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_WXbutton setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [self.view addSubview:_WXbutton];
    
    _QQbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    _QQbutton.clipsToBounds=YES;
    _QQbutton.layer.cornerRadius=25;
    [_QQbutton setBackgroundImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    [_QQbutton addTarget:self action:@selector(QQbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    _QQbutton.frame=CGRectMake(self.view.frame.size.width/2.0-70, APP_SCREEN_HEIGHT/2.0+190, 50, 50);
    [self.view addSubview:_QQbutton];
    
}
-(void)createOtherUI1{
    
    
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"-第三方账号登录-";
    label.font=[UIFont systemFontOfSize:13];
    label.frame=CGRectMake(0, APP_SCREEN_HEIGHT/2.0+150, APP_SCREEN_WIDTH, 30);
    label.textColor=[UIColor lightGrayColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    _WXbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    _WXbutton.frame=CGRectMake(self.view.frame.size.width/2.0-25, APP_SCREEN_HEIGHT/2.0+190, 50, 50);
    _WXbutton.clipsToBounds=YES;
    _WXbutton.layer.cornerRadius=25;
    [_WXbutton addTarget:self action:@selector(WXbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_WXbutton setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [self.view addSubview:_WXbutton];
    
}
-(void)createOtherUI2{
    
    
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"-第三方账号登录-";
    label.font=[UIFont systemFontOfSize:13];
    label.frame=CGRectMake(0, APP_SCREEN_HEIGHT/2.0+150, APP_SCREEN_WIDTH, 30);
    label.textColor=[UIColor lightGrayColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
//    _WXbutton=[UIButton buttonWithType:UIButtonTypeCustom];
//    _WXbutton.frame=CGRectMake(self.view.frame.size.width/2.0+20, APP_SCREEN_HEIGHT/2.0+190, 50, 50);
//    _WXbutton.clipsToBounds=YES;
//    _WXbutton.layer.cornerRadius=25;
//    [_WXbutton addTarget:self action:@selector(WXbuttonClick) forControlEvents:UIControlEventTouchUpInside];
//    [_WXbutton setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
//    [self.view addSubview:_WXbutton];
    
    _QQbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    _QQbutton.clipsToBounds=YES;
    _QQbutton.layer.cornerRadius=25;
    [_QQbutton setBackgroundImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    [_QQbutton addTarget:self action:@selector(QQbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    _QQbutton.frame=CGRectMake(self.view.frame.size.width/2.0-25, APP_SCREEN_HEIGHT/2.0+190, 50, 50);
    [self.view addSubview:_QQbutton];
    
}
-(void)SetFrame{
    if (ISiPhoneX) {
         _bgView.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-60, 120, 120, 120);
    }else{
         _bgView.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-60, 70, 120, 120);
    }
   
    _phoneTF.frame=CGRectMake(20, APP_SCREEN_HEIGHT/2.0-50, APP_SCREEN_WIDTH-40, 40);
    _pwTF.frame=CGRectMake(20, APP_SCREEN_HEIGHT/2.0, APP_SCREEN_WIDTH-40, 40);
    _Phonebutton.frame=CGRectMake(20, APP_SCREEN_HEIGHT/2.0+60, self.view.bounds.size.width-40, 40);
    _registerLabel.frame=CGRectMake(APP_SCREEN_WIDTH-120, APP_SCREEN_HEIGHT/2.0+100, 100, 40);
    _FGbutton.frame=CGRectMake(20, APP_SCREEN_HEIGHT/2.0+100, 100, 40);
    
//
  
   
}
-(void)PhonebuttonClick{
    
    [self.view endEditing:YES];
    if (_phoneTF.text.length==0) {
        [self showMessage:@"请输入手机号"];
        return;
        
    }
    if (_pwTF.text.length==0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    if (![_phoneTF.text checkPhoneNo]) {
        [self showMessage:@"请输入正确的手机号码"];
        return;
    }
   
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"PhoneNumber":_phoneTF.text,@"UserPassword":_pwTF.text,@"AccessToken":AccessToken,@"Device":[NSString deviceModelName]};
    NSString *string=[self createSign:dic];
    NSDictionary *param=@{@"PhoneNumber":_phoneTF.text,@"UserPassword":_pwTF.text,@"Sign":string,@"Device":[NSString deviceModelName]};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:login WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"--%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            NSString * AccessToken=[NSString stringWithFormat:@"%@",dataDic[@"AccessToken"]];
            NSString * UserToken=[NSString stringWithFormat:@"%@",dataDic[@"UserToken"]];
            [self setValueName:AccessToken withKey:@"AccessToken"];
            [self setValueName:UserToken withKey:@"UserToken"];
            [self setValueName:self->_phoneTF.text withKey:@"phone"];
            [self setValueName:self->_pwTF.text withKey:@"password"];
            [FCAppInfo shareManager].deviceToken=@"123";
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
-(void)buttonClick{
    RegisterViewController*registerVC=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
-(void)QQbuttonClick{
    [tencentOAuth authorize:permissions inSafari:NO];
    
}
//登陆完成调用
- (void)tencentDidLogin
{
    
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        //        [tencentOAuth getUserInfo];
        [self QQPartyLogin:tencentOAuth.accessToken withopenId:tencentOAuth.openId];
    }
    else
    {
        NSLog(@"--登录不成功 没有获取accesstoken");
    }
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencentDidNotLogin");
    if (cancelled)
    {
        NSLog(@"用户取消登录");
    }else{
        NSLog(@"登录失败");
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
    
}
//-(void)getUserInfoResponse:(APIResponse *)response
//{
//    NSLog(@"respons:%@",response.jsonResponse);
//}

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    // incrAuthWithPermissions是增 授权时需要调 的登录接
    // permissions是需要增 授权的权限 表
    [tencentOAuth incrAuthWithPermissions:permissions];
    // 返回NO表明 需要再回传未授权API接 的原始请求结果;否则可以返回YES return NO;
    return NO;
}
//增 授权成功时，会通过tencentDidUpdate:协议接 通知第三 应 :
- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
    NSLog(@"增 授权完成");
    if (tencentOAuth.accessToken&& 0 != [tencentOAuth.accessToken length])
    {
        // 在这 第三 应 需要 新  维护的token及有效期限等信息
        // **务必在这 检查 户的openid是否有变 ，变 需重新拉取 户的资 等信息** _labelAccessToken.text = tencentOAuth.accessToken;
        
    }
    else
    {
        NSLog(@"增 授权 成功，没有获取accesstoken");
    }
    
}
//增 授权失败时，会通过tencentFailedUpdate:协议接 通知第三 应 :
- (void)tencentFailedUpdate:(UpdateFailType)reason
{
    switch (reason) { case kUpdateFailNetwork: {
        NSLog(@"增 授权失败，  络连接，请设置 络");
        
        break; }
        case kUpdateFailUserCancel: {
            NSLog(@"增 授权失败， 户取消授权");
            break; }
        case kUpdateFailUnknown: default:
        {
            NSLog(@"增 授权失败，未知错误");
            break; }
    }
    
}
- (void)QQPartyLogin:(NSString *)accesstoken withopenId:(NSString*)openid
{
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Platform":@"QQ",@"QQAccessToken":accesstoken,@"QQOpenId":openid,@"AccessToken":AccessToken,@"Device":[NSString deviceModelName]};
    NSString *string=[self createSign:dic];
    NSDictionary *param=@{@"Platform":@"QQ",@"QQAccessToken":accesstoken,@"QQOpenId":openid,@"Sign":string,@"Device":[NSString deviceModelName]};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:thirdPartyLogin WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"-qq-%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            NSString * falseStr=[NSString stringWithFormat:@"%@",dataDic[@"HasPhoneNumber"]];
            NSString * AccessToken=[NSString stringWithFormat:@"%@",dataDic[@"AccessToken"]];
            NSString * UserToken=[NSString stringWithFormat:@"%@",dataDic[@"UserToken"]];
            [self setValueName:AccessToken withKey:@"AccessToken"];
            [self setValueName:UserToken withKey:@"UserToken"];
            if ([falseStr isEqualToString:@"FALSE"]) {
                ThirdLoginViewController *third=[[ThirdLoginViewController alloc]init];
                third.Platform=@"QQ";
                [self.navigationController pushViewController:third animated:YES];
            }else{
                FCTabBarViewController *hand=[[FCTabBarViewController alloc]init];
                
                UIWindow *window=[UIApplication sharedApplication].delegate.window;
                window.rootViewController=hand;
            }
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
-(void)WXbuttonClick{
     SendAuthReq *req = [[SendAuthReq alloc] init];
     req.scope = @"snsapi_userinfo";
     req.state = @"1";
    if ([WXApi isWXAppInstalled]) {
        [WXApi sendReq:req];
    }else{
        [WXApi sendAuthReq:req viewController:self delegate:self];
    }
   
    
}
-(void)FGButtonClick{
    ForgetViewController *forget=[[ForgetViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
   
}
-(void)tap:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
@end
