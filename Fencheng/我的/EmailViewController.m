//
//  EmailViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/6.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController (){
    UITextField *text;
}


@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改邮箱";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=UIColorFromRGBA(245, 245, 245, 1);
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self confinRightItemWithName:@"完成"];
    
    text=[[UITextField alloc]init];
   
    if ([self.Namestr isEmptyString]) {
       text.text=@"";
       text.placeholder=@"未填写";
    }else{
        text.text=self.Namestr;
    }
    text.backgroundColor=[UIColor whiteColor];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    [text setLeftView:leftView];
    [text addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    text.leftViewMode = UITextFieldViewModeAlways;
    text.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    if (ISiPhoneX) {
        text.frame=CGRectMake(0, 100, APP_SCREEN_WIDTH, 40);
    }else{
        text.frame=CGRectMake(0, 80, APP_SCREEN_WIDTH, 40);
    }
    
    [self.view addSubview:text];
    
    

}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popRightItemView{
    if (text.text.length<7) {
        [self showMessage:@"请输入正确邮箱"];
        return;
    }if (text.text.length>48) {
        [self showMessage:@"邮箱过长,请重新输入"];
        return;
    }
    if (![text.text checkEmail]) {
        [self showMessage:@"请输入正确邮箱"];
        return;
    }
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Email":text.text,@"AccessToken":AccessToken};
    NSString *string=[self createSign:dic];
    
    NSDictionary *param=@{@"Email":text.text,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:updateUserEmail WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"更新用户email%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
           
            [self.navigationController popViewControllerAnimated:YES];
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
-(void)textChange:(UITextField*)textField{
    
}
@end
