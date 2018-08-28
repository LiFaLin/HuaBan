//
//  PersonViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/6.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "PersonViewController.h"
#import "NameViewController.h"
#import "PhoneViewController.h"
#import "EmailViewController.h"
#import "ChangePViewController.h"
#import "HeaderImageViewController.h"
#import "HeaderTableViewCell.h"
#import "OtherTableViewCell.h"
@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * NameNumberArr;
    NSMutableArray * DetailNumberArr;
    NSString * currentDay;
   
    
}
@property(nonatomic,strong)UITableView * PersonTableView;
@property (nonatomic,strong)UIView *background;
@property (nonatomic,strong)UIView *pickerBgView;
@property (nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)NSString *Birthday;
@property(nonatomic,strong)NSString *Email;
@property(nonatomic,strong)NSString *Nickname;
@property(nonatomic,strong)NSString *PhoneNumber;
@property(nonatomic,strong)NSString *Sex;
@property(nonatomic,strong)NSString *Photo_Big;
@property(nonatomic,strong)NSString *Photo_Small;
@end

@implementation PersonViewController

-(void)viewWillAppear:(BOOL)animated{
    //监听当调用getNewtoken成功时，再次访问原来接口
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNextURL) name:@"getNewToken" object:nil];
    [self loadUserInfo];
}
-(void)viewWillDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getNewToken" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人中心";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    self.view.backgroundColor=UIColorFromRGBA(245, 245, 245, 1);
    NameNumberArr=[NSMutableArray arrayWithCapacity:0];
    DetailNumberArr=[NSMutableArray arrayWithCapacity:0];
    
    NSArray *arr=@[@"昵称",@"手机号码",@"邮箱",@"性别",@"生日"];
    
    NameNumberArr=[NSMutableArray arrayWithArray:arr];
    
    _PersonTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT) style:UITableViewStylePlain];
    _PersonTableView.delegate=self;
    _PersonTableView.dataSource=self;
    _PersonTableView.rowHeight=70;
    _PersonTableView.scrollEnabled=NO;
    _PersonTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    
    [self.view addSubview:_PersonTableView];
    [self.PersonTableView registerClass:[HeaderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HeaderTableViewCell class])];
    [self.PersonTableView registerClass:[OtherTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OtherTableViewCell class])];
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadUserInfo{
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
            self.Birthday=[NSString stringWithFormat:@"%@",dataDic1[@"Birthday"]];
            self.Email=[NSString stringWithFormat:@"%@",dataDic1[@"Email"]];
            self.Nickname=[NSString stringWithFormat:@"%@",dataDic1[@"Nickname"]];
            self.PhoneNumber=[NSString stringWithFormat:@"%@",dataDic1[@"PhoneNumber"]];
            self.Sex=[NSString stringWithFormat:@"%@",dataDic1[@"Sex"]];
            self.Photo_Big=[NSString stringWithFormat:@"%@",dataDic1[@"Photo_Big"]];
            self.Photo_Small=[NSString stringWithFormat:@"%@",dataDic1[@"Photo_Small"]];
            [self->DetailNumberArr addObject:self.Nickname];
            [self->DetailNumberArr addObject:self.PhoneNumber];
            [self->DetailNumberArr addObject:self.Email];
            [self->DetailNumberArr addObject:self.Sex];
            [self->DetailNumberArr addObject:self.Birthday];
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
#pragma tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        HeaderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HeaderTableViewCell class])];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.nameLabel.text=@"头像";
        if ([self.Photo_Small isEmptyString]) {
            cell.headerImage.image=[UIImage imageNamed:@"xiaoxiongtou"];
        }else{
            [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:self.Photo_Small] placeholderImage:[UIImage imageNamed:@""]];
        }
        
        return cell;
    }else{
        OtherTableViewCell *Ocell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OtherTableViewCell class])];
        Ocell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSString *name=[NSString stringWithFormat:@"%@",NameNumberArr[indexPath.row-1]];
        if (DetailNumberArr.count<1) {
            
        }else{
            NSString *name1=[NSString stringWithFormat:@"%@",DetailNumberArr[indexPath.row-1]];
            if ([name1 isEmptyString]==YES) {
                Ocell.detailLabel.text=@"";
            }else{
                Ocell.detailLabel.text=name1;
            }
            
        }
        
        Ocell.nameLabel.text=name;
        
        return Ocell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        HeaderImageViewController *header=[[HeaderImageViewController alloc]init];
        header.headUrl=self.Photo_Big;
        [self.navigationController pushViewController:header animated:YES];
    }
   else if (indexPath.row==1) {
        NameViewController *name=[[NameViewController alloc]init];
        name.Namestr=self.Nickname;
        [name setNickNameBlock:^(NSString *name) {
            [self->DetailNumberArr replaceObjectAtIndex:0 withObject:name];
            [self.PersonTableView reloadData];
        }];
        [self.navigationController pushViewController:name animated:YES];
    }else if(indexPath.row==2){
        if ([self.PhoneNumber isEmptyString]) {
            PhoneViewController *phone=[[PhoneViewController alloc]init];
            [self.navigationController pushViewController:phone animated:YES];
        }else{
            
            ChangePViewController * change=[[ChangePViewController alloc]init];
            change.phoneStr=self.PhoneNumber;
            [self.navigationController pushViewController:change animated:YES];
        }
        
    }else if(indexPath.row==3){
        EmailViewController *email=[[EmailViewController alloc]init];
        email.Namestr=self.Email;
        [self.navigationController pushViewController:email animated:YES];
    }
    else if(indexPath.row==4){
        [self addSex];
    }else{
        [self updateBirthdayClick];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 70;
    }else{
        return 40;
    }
}
#pragma headerImg
//-(void)updateHeaderImage:(UIImage*)image{
//    headerImg=image;
//    [self.PersonTableView reloadData];
//}
#pragma updateSex
-(void)addSex
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *takePic = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  
                                  [self updateSex:@"男"];
                              }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [self updateSex:@"女"];
                            }];
    [alert addAction:takePic];
    [alert addAction:photo];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)updateSex:(NSString*)sex{
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Sex":sex,@"AccessToken":AccessToken};
    NSString *string=[self createSign:dic];
    
    NSDictionary *param=@{@"Sex":sex,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:updateUserSex WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"更新性别%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
//            [self->DetailNumberArr replaceObjectAtIndex:2 withObject:sex];
//            [self.PersonTableView reloadData];
            [self loadUserInfo];
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

#pragma updateBirthDay
-(void)updateBirthdayClick{
    
    _background = [[UIView alloc]init];
    _background.frame =CGRectMake(0,0,APP_SCREEN_WIDTH,APP_SCREEN_HEIGHT);
    _background.backgroundColor = [UIColor blackColor];
    _background.alpha =0.5;
    _background.hidden=NO;
    [self.navigationController.view addSubview:_background];
    
    
    _pickerBgView = [[UIView alloc]init];
    _pickerBgView.frame =CGRectMake(0,APP_SCREEN_HEIGHT - 250,APP_SCREEN_WIDTH,250);
    _pickerBgView.backgroundColor = [UIColor whiteColor];
    _pickerBgView.hidden=NO;
    [self.navigationController.view addSubview:_pickerBgView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame =CGRectMake(10,10,60,20);
    [cancelBtn setTitle:@"取消"forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [_pickerBgView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [[UIButton alloc]init];
    confirmBtn.frame =CGRectMake(APP_SCREEN_WIDTH -70,10,60,20);
    [confirmBtn setTitle:@"确定"forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    confirmBtn.tag =1;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [_pickerBgView addSubview:confirmBtn];
    
    _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,50,APP_SCREEN_WIDTH, 150)];
    [_datePicker setTimeZone:[NSTimeZone systemTimeZone]];
    [_datePicker addTarget:self action:@selector(datePickerChangeValue:)forControlEvents:UIControlEventValueChanged];
    _datePicker.maximumDate=[NSDate date];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_pickerBgView addSubview:_datePicker];
}
-(void)datePickerChangeValue:(UIDatePicker*)pickerView{
    NSDate *date = pickerView.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentDay = [dateFormatter stringFromDate:date];
    NSLog(@"--%@",currentDay);
}
    
-(void)cancelBtnClick{
    _background.hidden=YES;
    _pickerBgView.hidden=YES;
    
}
-(void)confirmBtnClick{
    _background.hidden=YES;
    _pickerBgView.hidden=YES;
    NSDate *date = _datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentDay = [dateFormatter stringFromDate:date];
    [self updateBirthday:currentDay];
}
-(void)updateBirthday:(NSString*)day{

    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Birthday":day,@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Birthday":day,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:updateUserBirthday WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
         NSLog(@"更新用户生日%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            [self loadUserInfo];
           
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

#pragma 当code=0的时候重新获取token，并且监听返回时，重新加载该方法。
-(void)getNextURL{
    [self loadUserInfo];
}

@end
