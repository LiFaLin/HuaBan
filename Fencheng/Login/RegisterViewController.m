//
//  RegisterViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/4.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "RegisterViewController.h"
#import "HandAViewController.h"
#import "FCTabBarViewController.h"
#import "SeviceViewController.h"
#import "RegisterView.h"
@interface RegisterViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>{
    NSString * isSelected;
}
@property(nonatomic,strong)UIButton*backButton;
@property(nonatomic,strong)UIImageView*bgView;
@property(nonatomic,strong)UITextField * phoneTF;
@property(nonatomic,strong)UITextField * pwTF;
@property(nonatomic,strong)UITextField * sureTF;
@property(nonatomic,strong)UITextField * yzmTF;
@property(nonatomic,strong)UIButton *SureBT;
@property(nonatomic,strong)UIButton *serviceBT;
@property(nonatomic,strong)UIButton * Nextbutton;
@property(nonatomic,strong)UIImageView *gouImage;
@property(nonatomic,strong)RegisterView *regisView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
@property(nonatomic,strong)UIButton * button;
@end

@implementation RegisterViewController
//-(RegisterView *)regisView{
//    if (!_regisView) {
//        _regisView=[[RegisterView alloc]init];
//        _regisView.frame=self.view.frame;
//        _regisView.delegate=self;
//    }
//    return _regisView;
//}
//-(UIButton *)backButton{
//    if (!_backButton) {
//        _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        [_backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//        [_backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//
//
//    }
//    return _backButton;
//}
-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        
        
    }
    return _bgView;
}
-(UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF=[[UITextField alloc]init];
        _phoneTF.placeholder=@"请输入手机号";
        _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phoneTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _phoneTF.delegate=self;
        _phoneTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _phoneTF;
}
-(UITextField *)pwTF{
    if (!_pwTF) {
        _pwTF=[[UITextField alloc]init];
        _pwTF.placeholder=@"请输入密码,至少6位";
        _pwTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_pwTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _pwTF.delegate=self;
        _pwTF.secureTextEntry=YES;
        _pwTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _pwTF;
}
-(UITextField *)sureTF{
    if (!_sureTF) {
        _sureTF=[[UITextField alloc]init];
        _sureTF.placeholder=@"确认密码";
        _sureTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_sureTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _sureTF.delegate=self;
        _sureTF.secureTextEntry=YES;
        _sureTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _sureTF;
}
-(UITextField *)yzmTF{
    if (!_yzmTF) {
        _yzmTF=[[UITextField alloc]init];
        _yzmTF.placeholder=@"输入验证码";
        _yzmTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_yzmTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _yzmTF.delegate=self;
        _yzmTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _yzmTF;
}
-(UIImageView *)gouImage{
    if (!_gouImage) {
        _gouImage=[[UIImageView alloc]init];
        _gouImage.image=[UIImage imageNamed:@"weixuanzhong"];
        _gouImage.clipsToBounds=YES;
        _gouImage.layer.cornerRadius=7.5;
        
    }return _gouImage;
}
-(UIButton *)SureBT{
    if (!_SureBT) {
        _SureBT=[UIButton buttonWithType:UIButtonTypeCustom];
        _SureBT.titleLabel.font=[UIFont systemFontOfSize:13];
        _SureBT.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
        [_SureBT setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_SureBT addTarget:self action:@selector(SurebuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_SureBT setTitle:@"我已阅读并接受" forState:UIControlStateNormal];
        
    }
    return _SureBT;
}
-(UIButton *)serviceBT{
    if (!_serviceBT) {
        _serviceBT=[UIButton buttonWithType:UIButtonTypeCustom];
        _serviceBT.titleLabel.font=[UIFont systemFontOfSize:13];
        _serviceBT.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
        [_serviceBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_serviceBT addTarget:self action:@selector(FWbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_serviceBT setTitle:@"服务条款" forState:UIControlStateNormal];
        
    }
    return _serviceBT;
}
-(UIButton *)Nextbutton{
    if (!_Nextbutton) {
        _Nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_Nextbutton setBackgroundColor:UIColorFromHex(0xff9966)];
        _Nextbutton.clipsToBounds=YES;
        _Nextbutton.layer.cornerRadius=4;
        _Nextbutton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_Nextbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_Nextbutton addTarget:self action:@selector(NextbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_Nextbutton setTitle:@"注册" forState:UIControlStateNormal];
        
    }
    return _Nextbutton;
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UILabel *RElabel=[[UILabel alloc]init];
//    RElabel.text=@"注册";
//    RElabel.textAlignment=NSTextAlignmentCenter;
//    RElabel.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-30, 30, 60, 40);
//    RElabel.textColor=[UIColor blackColor];
//    [self.view addSubview:RElabel];
    
//    [self.view addSubview:self.backButton];
    self.title=@"注册";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.phoneTF];
    [self.view addSubview:self.pwTF];
    [self.view addSubview:self.sureTF];
    [self.view addSubview:self.yzmTF];
    [self.view addSubview:self.Nextbutton];
    [self.view addSubview:self.SureBT];
    [self.view addSubview:self.serviceBT];
    [self.view addSubview:self.gouImage];
    
    
    [self createOtherUI];
    [self SetFrame];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tap];
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createOtherUI{
    UILabel *label=[[UILabel alloc]init];
    label.backgroundColor=[UIColor lightGrayColor];
    label.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.phoneTF addSubview:label];
    
    UILabel *label1=[[UILabel alloc]init];
    label1.backgroundColor=[UIColor lightGrayColor];
    label1.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.pwTF addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc]init];
    label2.backgroundColor=[UIColor lightGrayColor];
    label2.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.sureTF addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]init];
    label3.backgroundColor=[UIColor lightGrayColor];
    label3.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.yzmTF addSubview:label3];
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont systemFontOfSize:15];
    if (ISiPhoneX) {
        _button.frame=CGRectMake(APP_SCREEN_WIDTH-100, 100+150, 100, 40);
    }else{
        _button.frame=CGRectMake(APP_SCREEN_WIDTH-100, 80+150, 100, 40);
    }
    
    [_button setTitleColor:UIColorFromHex(0xff9966) forState:UIControlStateNormal];
    [self.view addSubview:_button];
}
-(void)SetFrame{
    if (ISiPhoneX) {
        _phoneTF.frame=CGRectMake(20, 100, APP_SCREEN_WIDTH-20, 40);
        _pwTF.frame=CGRectMake(20, 100+50, APP_SCREEN_WIDTH-20, 40);
        _sureTF.frame=CGRectMake(20, 100+100, self.view.bounds.size.width-20, 40);
        _yzmTF.frame=CGRectMake(20, 100+150, self.view.bounds.size.width-120, 40);
        _SureBT.frame=CGRectMake(30, 100+200, 100, 40);
        _serviceBT.frame=CGRectMake(130, 100+200, 200, 40);
        _gouImage.frame=CGRectMake(20, 112+200, 15, 15);
        _Nextbutton.frame=CGRectMake(20, APP_SCREEN_HEIGHT/2.0+190, self.view.bounds.size.width-40, 40);
    }else{
        _phoneTF.frame=CGRectMake(20, 80, APP_SCREEN_WIDTH-20, 40);
        _pwTF.frame=CGRectMake(20, 80+50, APP_SCREEN_WIDTH-20, 40);
        _sureTF.frame=CGRectMake(20, 80+100, self.view.bounds.size.width-20, 40);
        _yzmTF.frame=CGRectMake(20, 80+150, self.view.bounds.size.width-120, 40);
        _SureBT.frame=CGRectMake(30, 80+200, 100, 40);
        _serviceBT.frame=CGRectMake(130, 80+200, 200, 40);
        _gouImage.frame=CGRectMake(20, 92+200, 15, 15);
        _Nextbutton.frame=CGRectMake(20, APP_SCREEN_HEIGHT/2.0+190, self.view.bounds.size.width-40, 40);
    }
    

}

-(void)buttonClick{
    
    if (_phoneTF.text.length==0) {
        [self showMessage:@"请输入手机号"];
        return;
    }if (![_phoneTF.text checkPhoneNo]) {
        [self showMessage:@"请输入正确的手机号码"];
        return;
    }
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"PhoneNumber":_phoneTF.text,@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    NSDictionary *param=@{@"PhoneNumber":_phoneTF.text,@"Sign":string};
    

    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:sendRegistSecCode WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"--%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        
        
        if ([msgStr isEqualToString:@"1"])
        {
            self->_button.enabled = NO;
            self->_time = 60;
            self->_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];

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
       
        
//        [self showMessage:[obj objectForKey:@"Msg"]];
    } withfail:^(NSString *errorMsg) {
        
    }];
    
//
    NSLog(@"获取验证码");
    
}
- (void)timerMethod
{
    
    _time -= 1;
    [_button setTitle:[NSString stringWithFormat:@"%lds",(long)_time] forState:UIControlStateNormal];
    if (_time == 0)
    {
        [_timer invalidate];
        _timer = nil;
        [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
        _button.enabled = YES;
    }
    
}
-(void)SurebuttonClick{
    static int i=0;
    i++;
    if (i%2==1) {
        _gouImage.image=[UIImage imageNamed:@"xuanzhong"];
        isSelected=@"1";
    }else{
        _gouImage.image=[UIImage imageNamed:@"weixuanzhong"];
        isSelected=@"0";
    }
  
}
-(void)FWbuttonClick{
    SeviceViewController * sevice=[[SeviceViewController alloc]init];
    [self.navigationController pushViewController:sevice animated:YES];
    
}
-(void)NextbuttonClick{
    if (_phoneTF.text.length==0) {
        [self showMessage:@"请输入手机号"];
        return;
    }
    if (![_phoneTF.text checkPhoneNo]) {
        [self showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (_pwTF.text.length==0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    if (_pwTF.text.length<6) {
        [self showMessage:@"密码至少6位"];
        return;
    }if (_sureTF.text.length==0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    if (![_sureTF.text isEqualToString:_pwTF.text]) {
        [self showMessage:@"两次密码输入不一致"];
        return;
    }if (_yzmTF.text.length==0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    if (![isSelected isEqualToString:@"1"]) {
       [self showMessage:@"请先勾选服务协议"];
        return;
    }
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"PhoneNumber":_phoneTF.text,@"UserPassword":_pwTF.text,@"ConfrimUserPassword":_sureTF.text,@"SecCode":_yzmTF.text,@"AccessToken":AccessToken,@"Device":[NSString deviceModelName]};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"PhoneNumber":_phoneTF.text,@"UserPassword":_pwTF.text,@"ConfrimUserPassword":_sureTF.text,@"SecCode":_yzmTF.text,@"Sign":string,@"Device":[NSString deviceModelName]};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:register1 WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
  
        
        NSLog(@"-注册-%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        
        
        if ([msgStr isEqualToString:@"1"])
        {
            
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            NSString * AccessToken=[NSString stringWithFormat:@"%@",dataDic[@"AccessToken"]];
            NSString * UserToken=[NSString stringWithFormat:@"%@",dataDic[@"UserToken"]];
            [self setValueName:AccessToken withKey:@"AccessToken"];
            [self setValueName:UserToken withKey:@"UserToken"];
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
+(NSString*)removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}
-(void)tap:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
@end
