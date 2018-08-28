//
//  HuabuViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/8.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "HuabuViewController.h"
#import "HandAViewController.h"
#import "ChooseBCollectionViewCell.h"
#import "DraftViewController.h"
@interface HuabuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray * DetailNumberArr;
}
@property(nonatomic,strong)UICollectionView * ChooseBCollectionView;
@end

@implementation HuabuViewController
-(void)viewWillAppear:(BOOL)animated{
    [self loadUserInfo];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PicutreFromAlbum" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self confinRightItemWithName:@"草稿"];
     DetailNumberArr=[NSMutableArray arrayWithCapacity:0];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(103, 142);
    
    _ChooseBCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) collectionViewLayout:layout];
    _ChooseBCollectionView.backgroundColor = [UIColor whiteColor];
    _ChooseBCollectionView.dataSource = self;
    _ChooseBCollectionView.delegate = self;
    _ChooseBCollectionView.showsVerticalScrollIndicator=YES;
    [_ChooseBCollectionView registerClass:[ChooseBCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:_ChooseBCollectionView];
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popRightItemView{
    DraftViewController *draft=[[DraftViewController alloc]init];
    [self.navigationController pushViewController:draft animated:YES];
}
#pragma UICollectionDelegate
//collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return DetailNumberArr.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=DetailNumberArr[indexPath.row];
    NSString * imageString=[NSString stringWithFormat:@"%@",dic[@"Picture"]];
    ChooseBCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@""]];
    cell.nameLabel.text=[NSString stringWithFormat:@"%@",dic[@"TemplateName"]];
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic=DetailNumberArr[indexPath.row];
    NSString * TemplateId=[NSString stringWithFormat:@"%@",dic[@"TemplateId"]];
    NSString * name= [NSString stringWithFormat:@"%@",dic[@"TemplateName"]];
    
    NSDictionary * diclist=[self objectValueWith:[NSString stringWithFormat:@"%@list",TemplateId]];
    if (diclist.count>1) {
        NSDictionary *dic=[self objectValueWith:[NSString stringWithFormat:@"%@list",TemplateId]];
        NSDictionary *tdic=[self objectValueWith:[NSString stringWithFormat:@"%@tlist",TemplateId]];
        NSArray *arr=[self objectValueWith:[NSString stringWithFormat:@"%@list1",TemplateId]];
        
        NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"BoxColor"]];
        NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
        NSString *BackgroundImage=[NSString stringWithFormat:@"%@",tdic[@"BackgroundImage"]];
        [FCAppInfo shareManager].backgroundImage=BackgroundImage;
        [FCAppInfo shareManager].boxColor=[color1 intValue];
        [FCAppInfo shareManager].huabanArr =arr;
        [FCAppInfo shareManager].pDic =dic;
        [FCAppInfo shareManager].TDic =tdic;
        
        
        HandAViewController *hand=[[HandAViewController alloc]init];
        [FCAppInfo shareManager].lflTemName=name;
        [FCAppInfo shareManager].lflTemID=TemplateId;
        [self.navigationController pushViewController:hand animated:YES];
        
    }else{
       [self loadback:TemplateId withName:name];
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
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:getTemplateList WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"获取画布信息%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            self->DetailNumberArr =[dataDic objectForKey:@"TemplateList"];
            NSString*max=[dataDic objectForKey:@"MaxScrapbookSize"];
            [FCAppInfo shareManager].MaxXian=max;
            
            [self.ChooseBCollectionView reloadData];
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
//获取画布模块背景图
-(void)loadback:(NSString*)temID withName:(NSString*)name{
    //    [self getNewToken];
    //    [DetailNumberArr removeAllObjects];
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"TemplateId":temID};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"TemplateId":temID};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:getTemplateBackgroundImageList WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        
        
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            
            NSArray *arr=[dataDic objectForKey:@"BackgroundImageList"];
            NSDictionary *dic=[dataDic objectForKey:@"PoetryList"];
            NSDictionary *Templatedic=[dataDic objectForKey:@"Template"];
            NSString *fontColor=[NSString stringWithFormat:@"%@",Templatedic[@"BoxColor"]];
            NSString *BackgroundImage=[NSString stringWithFormat:@"%@",Templatedic[@"BackgroundImage"]];
            [FCAppInfo shareManager].backgroundImage=BackgroundImage;
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            [FCAppInfo shareManager].boxColor=[color1 intValue];
            [FCAppInfo shareManager].huabanArr =arr;
            [FCAppInfo shareManager].pDic =dic;
            [FCAppInfo shareManager].TDic =Templatedic;
            
            [self setValueName:Templatedic withKey:[NSString stringWithFormat:@"%@tlist",temID]];
            [self setValueName:dic withKey:[NSString stringWithFormat:@"%@list",temID]];
            [self setValueName:arr withKey:[NSString stringWithFormat:@"%@list1",temID]];
            
            HandAViewController *hand=[[HandAViewController alloc]init];
            [FCAppInfo shareManager].lflTemName=name;
            [FCAppInfo shareManager].lflTemID=temID;
            [self.navigationController pushViewController:hand animated:YES];
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
@end
