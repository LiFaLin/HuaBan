//
//  NameViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/6.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController (){
   
}
@property(nonatomic,strong) UITextField *text;
@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改昵称";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=UIColorFromRGBA(245, 245, 245, 1);
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self confinRightItemWithName:@"完成"];
    
    _text=[[UITextField alloc]init];
    
    if ([self.Namestr isEmptyString]) {
        _text.text=@"";
        _text.placeholder=@"未填写";
    }else{
        _text.text=self.Namestr;
        _text.placeholder=@"未填写";
    }
    
    _text.backgroundColor=[UIColor whiteColor];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 40)];
    [_text setLeftView:leftView];
    _text.leftViewMode = UITextFieldViewModeAlways;
    _text.clearButtonMode=UITextFieldViewModeWhileEditing;
    if (ISiPhoneX) {
        _text.frame=CGRectMake(0, 100, APP_SCREEN_WIDTH, 40);
    }else{
        _text.frame=CGRectMake(0, 80, APP_SCREEN_WIDTH, 40);
    }
    [_text addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_text];
}
-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popRightItemView{
    if (_text.text.length<1) {
        [self showMessage:@"请输入昵称"];
        return;
    }
    if (_text.text.length>24) {
        [self showMessage:@"昵称过长,请重新输入"];
        return;
    }
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Nickname":_text.text,@"AccessToken":AccessToken};
    NSString *string=[self createSign:dic];
    
    NSDictionary *param=@{@"Nickname":_text.text,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:updateUserNickname WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
         NSLog(@"更新用户昵称%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            if (self.nickNameBlock) {
                self.nickNameBlock(self->_text.text);
            }
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
