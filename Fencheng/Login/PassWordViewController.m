//
//  PassWordViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/7/12.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "PassWordViewController.h"
#import "FCTabBarViewController.h"
@interface PassWordViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * pwTF;
@property(nonatomic,strong)UITextField * sureTF;
@property(nonatomic,strong)UIButton * Nextbutton;
@end

@implementation PassWordViewController
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
    self.title=@"设置密码";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self.view addSubview:self.pwTF];
    [self.view addSubview:self.sureTF];
    [self.view addSubview:self.Nextbutton];
    [self createOtherUI];
    [self SetFrame];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tap];
}
-(void)popLeftItemView
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createOtherUI
{
    UILabel *label1=[[UILabel alloc]init];
    label1.backgroundColor=[UIColor lightGrayColor];
    label1.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.pwTF addSubview:label1];


    UILabel *label2=[[UILabel alloc]init];
    label2.backgroundColor=[UIColor lightGrayColor];
    label2.frame=CGRectMake(0,40,APP_SCREEN_WIDTH-20, 1);
    [self.sureTF addSubview:label2];
}
-(void)SetFrame{
    
    if (ISiPhoneX) {

        _pwTF.frame=CGRectMake(20, 100, APP_SCREEN_WIDTH-20, 40);
        _sureTF.frame=CGRectMake(20, 100+50, self.view.bounds.size.width-20, 40);
        _Nextbutton.frame=CGRectMake(20, 100+190, self.view.bounds.size.width-40, 40);
        
    }else{

        _pwTF.frame=CGRectMake(20, 80, APP_SCREEN_WIDTH-20, 40);
        _sureTF.frame=CGRectMake(20, 80+50, self.view.bounds.size.width-20, 40);
        _Nextbutton.frame=CGRectMake(20, 80+190, self.view.bounds.size.width-40, 40);
        
    }
    
    
}
-(void)NextbuttonClick{
    if (_pwTF.text.length==0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    if (_pwTF.text.length<6) {
        [self showMessage:@"密码至少6位"];
        return;
    }if (_sureTF.text.length==0) {
        [self showMessage:@"请再次输入密码"];
        return;
    }if (![_sureTF.text isEqualToString:_pwTF.text]) {
        [self showMessage:@"两次密码输入不一致"];
        return;
    }
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"UserPassword":_pwTF.text,@"PhoneNumber":self.phoneNum,@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"UserPassword":_pwTF.text,@"PhoneNumber":self.phoneNum,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:setFirstUserPassword WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        
        NSLog(@"--第三方登录%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        
        
        if ([msgStr isEqualToString:@"1"])
        {
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
-(void)tap:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
@end
