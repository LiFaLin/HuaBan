//
//  ChangePViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/7.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ChangePViewController.h"
#import "ChangeP1ViewController.h"
@interface ChangePViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * phoneTF;
@property(nonatomic,strong)UITextField * yzmTF;
@property(nonatomic,strong)UIButton * Nextbutton;
@property(nonatomic,strong)UIButton * button;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
@end

@implementation ChangePViewController

-(UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF=[[UITextField alloc]init];
        _phoneTF.placeholder=@"输入手机号";
        _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phoneTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _phoneTF.delegate=self;
        _phoneTF.text=self.phoneStr;
        _phoneTF.textColor=[UIColor lightGrayColor];
        _phoneTF.userInteractionEnabled=NO;
    }
    return _phoneTF;
}

-(UITextField *)yzmTF{
    if (!_yzmTF) {
        _yzmTF=[[UITextField alloc]init];
        _yzmTF.placeholder=@"输入验证码";
        _yzmTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_yzmTF.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        _yzmTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _yzmTF;
}
-(UIButton *)Nextbutton{
    if (!_Nextbutton) {
        _Nextbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_Nextbutton setBackgroundColor:UIColorFromHex(0xff9966)];
        _Nextbutton.clipsToBounds=YES;
        _Nextbutton.layer.cornerRadius=10;
        _Nextbutton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_Nextbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_Nextbutton addTarget:self action:@selector(NextbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [_Nextbutton setTitle:@"下一步" forState:UIControlStateNormal];
        
    }
    return _Nextbutton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"更换手机号";
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
    _button.frame=CGRectMake(APP_SCREEN_WIDTH-100, 190, 100, 40);
    [_button setTitleColor:UIColorFromHex(0xff9966) forState:UIControlStateNormal];
    [self.view addSubview:_button];
}
-(void)SetFrame{
    
    _phoneTF.frame=CGRectMake(20, 140, APP_SCREEN_WIDTH-20, 40);
    _yzmTF.frame=CGRectMake(20, 190, self.view.bounds.size.width-120, 40);
    _Nextbutton.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-60, 350, 120, 40);
    
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)buttonClick{
    if (_phoneTF.text.length==0) {
        [self showMessage:@"请输入手机号"];
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
    NSDictionary *dic=@{@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    NSDictionary *param=@{@"Sign":string};
    
    
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:sendChangePhoneNumberSecCode WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"-发送老验证码-%@",obj);
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
    NSDictionary *dic=@{@"SecCode":_yzmTF.text,@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    NSDictionary *param=@{@"SecCode":_yzmTF.text,@"Sign":string};
    
    
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:checkChangePhoneNumberSecCode WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"-检查老验证码是否正确-%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        
        
        if ([msgStr isEqualToString:@"1"])
        {
            ChangeP1ViewController *change1=[[ChangeP1ViewController alloc]init];
            change1.phone=self.phoneStr;
            [self.navigationController pushViewController:change1 animated:YES];
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
-(void)tap:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return NO;
//}
@end
