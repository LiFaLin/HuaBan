//
//  ThirdLoginViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/7.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ThirdLoginViewController.h"
#import "HandAViewController.h"
#import "FCTabBarViewController.h"
#import "PassWordViewController.h"
#import "ShowViewController.h"
#import "RegisterView.h"
@interface ThirdLoginViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>{
    
}
@property(nonatomic,strong)UIButton*backButton;
@property(nonatomic,strong)UIImageView*bgView;
@property(nonatomic,strong)UITextField * phoneTF;
//@property(nonatomic,strong)UITextField * pwTF;
//@property(nonatomic,strong)UITextField * sureTF;
@property(nonatomic,strong)UITextField * yzmTF;
@property(nonatomic,strong)UIButton * Nextbutton;
@property(nonatomic,strong)RegisterView *regisView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
@property(nonatomic,strong)UIButton * button;

@end

@implementation ThirdLoginViewController

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

-(UIButton *)Nextbutton{
    if (!_Nextbutton) {
        _Nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_Nextbutton setBackgroundColor:UIColorFromHex(0xff9966)];
        _Nextbutton.clipsToBounds=YES;
        _Nextbutton.layer.cornerRadius=20;
        _Nextbutton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_Nextbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_Nextbutton addTarget:self action:@selector(NextbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_Nextbutton setTitle:@"下一步" forState:UIControlStateNormal];
        
    }
    return _Nextbutton;
}

-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"绑定手机号";
    [self confinRightItemWithName:@"跳过"];
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self.view addSubview:self.phoneTF];

    [self.view addSubview:self.yzmTF];
    [self.view addSubview:self.Nextbutton];
  
    [self createOtherUI];
    [self SetFrame];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tap];
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popRightItemView{
    FCTabBarViewController *hand=[[FCTabBarViewController alloc]init];
    UIWindow *window=[UIApplication sharedApplication].delegate.window;
    window.rootViewController=hand;
   
   
}
-(void)createOtherUI{
    UILabel *label=[[UILabel alloc]init];
    label.backgroundColor=[UIColor lightGrayColor];
    label.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.phoneTF addSubview:label];
    
    
    UILabel *label3=[[UILabel alloc]init];
    label3.backgroundColor=[UIColor lightGrayColor];
    label3.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.yzmTF addSubview:label3];
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
    _button.titleLabel.font=[UIFont systemFontOfSize:15];
    if (ISiPhoneX) {
        _button.frame=CGRectMake(APP_SCREEN_WIDTH-100, 100+50, 100, 40);
    }else{
        _button.frame=CGRectMake(APP_SCREEN_WIDTH-100, 80+50, 100, 40);
    }
    [_button setTitleColor:UIColorFromHex(0xff9966) forState:UIControlStateNormal];
    [self.view addSubview:_button];
}
-(void)SetFrame{
    
    if (ISiPhoneX) {
        _phoneTF.frame=CGRectMake(20, 100, APP_SCREEN_WIDTH-20, 40);
        _yzmTF.frame=CGRectMake(20, 100+50, self.view.bounds.size.width-120, 40);
        _Nextbutton.frame=CGRectMake(20, 100+190, self.view.bounds.size.width-40, 40);
        
    }else{
        _phoneTF.frame=CGRectMake(20, 80, APP_SCREEN_WIDTH-20, 40);
        _yzmTF.frame=CGRectMake(20, 80+50, self.view.bounds.size.width-120, 40);
        _Nextbutton.frame=CGRectMake(20, 80+190, self.view.bounds.size.width-40, 40);
        
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
    NSDictionary *dic=@{@"PhoneNumber":_phoneTF.text,@"AccessToken":AccessToken,@"Platform":self.Platform};
    
    NSString *string= [self createSign:dic];
    NSDictionary *param=@{@"PhoneNumber":_phoneTF.text,@"Platform":self.Platform,@"Sign":string};
    
    
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:sendFirstSetPhoneNumberSecCode WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
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

-(void)NextbuttonClick{
    if (_phoneTF.text.length==0) {
        [self showMessage:@"请输入手机号"];
        return;
    }
    if (![_phoneTF.text checkPhoneNo]) {
        [self showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (_yzmTF.text.length==0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"PhoneNumber":_phoneTF.text,@"SecCode":_yzmTF.text,@"Platform":self.Platform,@"AccessToken":AccessToken};

    NSString *string= [self createSign:dic];

    NSDictionary *param=@{@"PhoneNumber":_phoneTF.text,@"SecCode":_yzmTF.text,@"Platform":self.Platform,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:checkFirstSetPhoneNumberSecCode WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {

        NSLog(@"--第三方登录%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        NSString *IsBinding = [NSString stringWithFormat:@"%@",[obj objectForKey:@"IsBinding"]];

        if ([msgStr isEqualToString:@"1"]&&[IsBinding isEqualToString:@"FALSE"])
        {
            PassWordViewController *pw=[[PassWordViewController alloc]init];
            pw.Platform=self.Platform;
            pw.phoneNum=self->_phoneTF.text;
            [self.navigationController pushViewController:pw animated:YES];
            
            
        }
        else if ([msgStr isEqualToString:@"1"]&&[IsBinding isEqualToString:@"TRUE"])
        {
            NSDictionary *dic=[obj objectForKey:@"UserInfo"];
            NSString *UserId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"UserId"]];
             NSString *Nickname = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Nickname"]];
            NSString *PhoneNumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PhoneNumber"]];
            ShowViewController *pw=[[ShowViewController alloc]init];
            pw.Platform=self.Platform;
            pw.userId=UserId;
            pw.NickName=Nickname;
            pw.phoneNum=PhoneNumber;
            [self.navigationController pushViewController:pw animated:YES];
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
