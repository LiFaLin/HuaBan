//
//  DraftViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/7/24.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "DraftViewController.h"
#import "DraftCollectionViewCell.h"
#import "EditDraftViewController.h"
#import "header.h"
@interface DraftViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray * DetailNumberArr;
    int count;
    NSString * hasMore;
    NSString * Status;
    UIButton *button;
//    BOOL isSelected;
    BOOL isAllSelected;
     NSMutableArray * SelectedArr;
     NSMutableArray * SelectedIDArr;
}
@property(nonatomic,strong)UICollectionView * ChooseBCollectionView;
@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UIView * BgView;
@end

@implementation DraftViewController
-(UIView *)BgView{
    if (!_BgView) {
        _BgView=[[UIView alloc]init];
        _BgView.backgroundColor=UIColorFromHex(0xf7f7f7);
        _BgView.hidden=YES;
        if (ISiPhoneX) {
            _BgView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-60, APP_SCREEN_WIDTH, 40);
        }else{
            _BgView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-40, APP_SCREEN_WIDTH, 40);
        }
        
    }
    return _BgView;
}
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView=[[UIImageView alloc]init];
        _bgImageView.image=[UIImage imageNamed:@"草稿lfl"];
    }
    return _bgImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"草稿";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self.view addSubview:self.bgImageView];
    [self setFrame];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(APP_SCREEN_WIDTH, LWidth(180));
    
    _ChooseBCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT_TOP_MARGIN, self.view.bounds.size.width,self.view.bounds.size.height-HEIGHT_TOP_MARGIN) collectionViewLayout:layout];
    _ChooseBCollectionView.backgroundColor = [UIColor whiteColor];
    _ChooseBCollectionView.dataSource = self;
    _ChooseBCollectionView.delegate = self;
    _ChooseBCollectionView.showsVerticalScrollIndicator=YES;
    [_ChooseBCollectionView registerClass:[DraftCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [_ChooseBCollectionView registerClass:[header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:_ChooseBCollectionView];
    
    [self.view addSubview:self.BgView];
    
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
    button.frame=CGRectMake(10, 10, 20, 20);
    [self.BgView addSubview:button];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"全选";
    label.frame=CGRectMake(40, 0, 40, 40);
    [self.BgView addSubview:label];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"删除" forState:UIControlStateNormal];
    button1.backgroundColor=UIColorFromHex(0xff9966);
    button1.layer.cornerRadius=15;
    button1.clipsToBounds=YES;
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.frame=CGRectMake(APP_SCREEN_WIDTH-80, 5, 60, 30);
    [self.BgView addSubview:button1];
    
}
-(void)buttonClick{
    
    if (isAllSelected==YES) {
        isAllSelected=NO;
        SelectedArr=[NSMutableArray arrayWithCapacity:0];
        SelectedIDArr=[NSMutableArray arrayWithCapacity:0];
        [button setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
    }else{
         SelectedArr=[NSMutableArray arrayWithCapacity:0];
         SelectedIDArr=[NSMutableArray arrayWithCapacity:0];
         isAllSelected=YES;
        for (int i = 0;i<DetailNumberArr.count; i++ ) {
            NSString *string=[NSString stringWithFormat:@"%d",i];
            NSDictionary *dic=DetailNumberArr[i];
            NSString * lfl=dic[@"radom"];
            [SelectedArr addObject:lfl];
            [SelectedIDArr addObject:string];
        }
        [button setBackgroundImage:[UIImage imageNamed:@"lflgx"] forState:UIControlStateNormal];
    }
    [self.ChooseBCollectionView reloadData];
}
-(void)button1Click{
    if (SelectedIDArr.count<1) {
        [self showMessage:@"请选择删除的草稿"];
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *arr=[self objectValueWith:@"DraftArr"];
        NSMutableArray *arr1=[NSMutableArray arrayWithArray:arr];
       
        
        for (NSString * tag in self->SelectedIDArr) {
            int i=[tag intValue];
            NSDictionary *dic=self->DetailNumberArr[i];
            if ([self->SelectedArr containsObject:dic[@"radom"]]) {
                [arr1 removeObject:dic];
            }
            
        }
    
       
        
        [self setValueName:arr1 withKey:@"DraftArr"];
        self->DetailNumberArr=arr1;
        self->SelectedArr=[NSMutableArray arrayWithCapacity:0];
        self->Status=@"管理";
        [self confinRightItemWithName:@"管理"];
        self.BgView.hidden=YES;
        self->isAllSelected=NO;
        if (self->DetailNumberArr.count<1) {
            self->_ChooseBCollectionView.hidden=YES;
            [self confinRight1ItemWithName:@"管理"];
        }else{
            self->_ChooseBCollectionView.hidden=NO;
            [self.ChooseBCollectionView reloadData];
        }
        
    }];
    UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alertController addAction:confirm];
    [alertController addAction:cance];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    DetailNumberArr=[NSMutableArray arrayWithCapacity:0];
    SelectedArr=[NSMutableArray arrayWithCapacity:0];
    SelectedIDArr=[NSMutableArray arrayWithCapacity:0];
    Status=@"管理";
    
    self.BgView.hidden=YES;
    isAllSelected=NO;
    
    DetailNumberArr=[self objectValueWith:@"DraftArr"];
    if (DetailNumberArr.count<1) {
        _ChooseBCollectionView.hidden=YES;
        [self confinRight1ItemWithName:@"管理"];
    }else{
        _ChooseBCollectionView.hidden=NO;
        [self confinRightItemWithName:@"管理"];
        [self.ChooseBCollectionView reloadData];
    }
    
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popRightItemView{
    
    if (DetailNumberArr.count<1) {
        
    }else{
        if ([Status isEqualToString:@"管理"]) {
            
            SelectedArr=[NSMutableArray arrayWithCapacity:0];
            SelectedIDArr=[NSMutableArray arrayWithCapacity:0];
            Status=@"完成";
            self.BgView.hidden=NO;
            if (ISiPhoneX) {
                self.ChooseBCollectionView.frame=CGRectMake(0, HEIGHT_TOP_MARGIN, self.view.bounds.size.width,self.view.bounds.size.height-HEIGHT_TOP_MARGIN-60);
            }else{
               self.ChooseBCollectionView.frame=CGRectMake(0, HEIGHT_TOP_MARGIN, self.view.bounds.size.width,self.view.bounds.size.height-HEIGHT_TOP_MARGIN-40);
            }
            
            
        }
        else
        {
            Status=@"管理";
            self.BgView.hidden=YES;
            self.ChooseBCollectionView.frame=CGRectMake(0, HEIGHT_TOP_MARGIN, self.view.bounds.size.width,self.view.bounds.size.height-HEIGHT_TOP_MARGIN);
        }
        
        [button setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
        [self confinRightItemWithName:Status];
        [self.ChooseBCollectionView reloadData];
    }
    
}
#pragma UICollectionDelegate
//collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return DetailNumberArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=DetailNumberArr[indexPath.section];
    NSData* data= dic[@"qietu"];
    DraftCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.bgImage.image=[UIImage imageWithData:data];
    
    NSString * time=[NSString stringWithFormat:@"%@",dic[@"date"]];
    NSString * name=[NSString stringWithFormat:@"%@",dic[@"TemplateName"]];
    
    if ([name isEmptyString]) {
        cell.nameLabel.text=@"";
    }else{
        cell.nameLabel.text=name;
    }
     cell.dayLabel.text=time;
    [cell.nameButton addTarget:self action:@selector(nameButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.nameButton.tag=indexPath.section;
    [cell.gxButton addTarget:self action:@selector(gxButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.gxButton.tag=indexPath.section;
    if ([Status isEqualToString:@"完成"]) {
        cell.gxButton.hidden=NO;
        cell.bgImage.frame=CGRectMake(LWidth(30), 50, cell.bounds.size.width-LWidth(40), cell.bounds.size.height-50);
        cell.nameLabel.frame=CGRectMake(LWidth(30), 0, cell.bounds.size.width-100, 20);
        cell.dayLabel.frame=CGRectMake(LWidth(30), 30, cell.bounds.size.width-100, 10);
        cell.gxButton.frame=CGRectMake(LWidth(5),0, LWidth(20), LWidth(20));
        cell.nameButton.frame=CGRectMake(cell.bounds.size.width-40, 0, 30, 30);
        cell.EditImg.frame=CGRectMake(cell.bounds.size.width-27, 10, 17, 5);
        NSString *string=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
        if ([SelectedIDArr containsObject:string]) {
            [cell.gxButton setBackgroundImage:[UIImage imageNamed:@"lflgx"] forState:UIControlStateNormal];
        }else{
            [cell.gxButton setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
        }
    }else{
        cell.gxButton.hidden=YES;
        cell.bgImage.frame=CGRectMake(LWidth(20), 50, cell.bounds.size.width-LWidth(40), cell.bounds.size.height-50);
        cell.nameLabel.frame=CGRectMake(LWidth(20), 0, cell.bounds.size.width-100, 20);
        cell.dayLabel.frame=CGRectMake(LWidth(20), 30, cell.bounds.size.width-100, 10);
        cell.gxButton.frame=CGRectMake(LWidth(5),0, LWidth(20), LWidth(20));
        cell.nameButton.frame=CGRectMake(cell.bounds.size.width-50, 0, 30, 30);
        cell.EditImg.frame=CGRectMake(cell.bounds.size.width-37, 10, 17, 5);
        
    }
    
   
    return cell;
}
-(void)gxButton:(UIButton*)sender{
    NSString *string=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    
        if ([SelectedIDArr containsObject:string])
        {
            isAllSelected=NO;
            NSDictionary *dic=DetailNumberArr[sender.tag];
            NSString * lfl=dic[@"radom"];
            [SelectedArr removeObject:lfl];
            [SelectedIDArr removeObject:string];
            [button setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
        }
        else
        {
            
            NSDictionary *dic=DetailNumberArr[sender.tag];
            NSString * lfl=dic[@"radom"];
            [SelectedArr addObject:lfl];
            [SelectedIDArr addObject:string];
            if (SelectedIDArr.count==DetailNumberArr.count) {
                isAllSelected=YES;
               [button setBackgroundImage:[UIImage imageNamed:@"lflgx"] forState:UIControlStateNormal];
            }else{
                isAllSelected=NO;
                [button setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
            }
            
        }
    [self.ChooseBCollectionView reloadData];
}

-(void)nameButton:(UIButton*)sender
{
    if ([Status isEqualToString:@"完成"]) {
        return;
    }
    NSDictionary *dic=DetailNumberArr[sender.tag];
    NSString * tag=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];

    UIAlertAction *editName = [UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   [self eidtName:dic with:tag];
                               }];
   
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
                             {
                                 [self deleteButton:dic with:tag];
                             }];
    
    [alert addAction:editName];
    [alert addAction:delete];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)eidtName:(NSDictionary*)dic with:(NSString*)tag{
    NSString * name=[NSString stringWithFormat:@"%@",dic[@"TemplateName"]];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"修改名称"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         //响应事件
                                                         //得到文本信息
                                                         for(UITextField *text in alert.textFields){
                                                             if (text.text.length<1) {
                                                                 [self showMessage:@"请输入名称"];
                                                             }
                                                             else
                                                             {
                                                                 NSMutableDictionary *NasDic=[NSMutableDictionary dictionaryWithDictionary:dic];
                                                                 
                                                                 [NasDic setValue:text.text forKey:@"TemplateName"];
                                                                 
                                                                 
                                                                 NSArray *arr=[self objectValueWith:@"DraftArr"];
                                                                 NSMutableArray *arr1=[NSMutableArray arrayWithArray:arr];
                                                                 [arr1 replaceObjectAtIndex:[tag intValue] withObject:NasDic];
                                                                 [self setValueName:arr1 withKey:@"DraftArr"];
                                                                 
                                                                 self->DetailNumberArr=arr1;
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                      [self.ChooseBCollectionView reloadData];
                                                                 });
                                                                
                                                             }
                                                             NSLog(@"text = %@", text.text);
                                                         }
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", alert.textFields);
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"输入名称";
        if ([name isEmptyString]) {
            textField.text=@"";
        }else{
            textField.text=name;
        }
        
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)deleteButton:(NSDictionary*)dic with:(NSString*)tag{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSArray *arr=[self objectValueWith:@"DraftArr"];
        NSMutableArray *arr1=[NSMutableArray arrayWithArray:arr];
        [arr1 removeObjectAtIndex:[tag intValue]];
        [self setValueName:arr1 withKey:@"DraftArr"];
        self->DetailNumberArr=arr1;
        if (self->DetailNumberArr.count<1) {
            self->_ChooseBCollectionView.hidden=YES;
            [self confinRight1ItemWithName:@"管理"];
        }else{
            self->_ChooseBCollectionView.hidden=NO;
            [self.ChooseBCollectionView reloadData];
        }
        
    }];
    UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alertController addAction:confirm];
    [alertController addAction:cance];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return nil;
    }else{
        UICollectionReusableView* reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *label=[[UILabel alloc]init];
        label.backgroundColor=UIColorFromHex(0xf0f0f0);
        label.frame=CGRectMake(0, 0, SCREEN_WIDTH, 10);
        [reusableView addSubview:label];
        return reusableView;
    }
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(SCREEN_WIDTH,0);;
    }else{
        CGSize size = CGSizeMake(SCREEN_WIDTH, 10);
        return size;
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     if ([Status isEqualToString:@"管理"]) {
         NSDictionary *dic=DetailNumberArr[indexPath.section];
         
         NSString * TemplateId=[NSString stringWithFormat:@"%@",dic[@"TemplateId"]];
         NSString * radom=[NSString stringWithFormat:@"%@",dic[@"radom"]];
         NSString *boxColor=[NSString stringWithFormat:@"%@",dic[@"boxColor"]];
         NSString *TemplateName=[NSString stringWithFormat:@"%@",dic[@"TemplateName"]];
         NSString *backgroundimage=[NSString stringWithFormat:@"%@",dic[@"backgroundimage"]];
         [FCAppInfo shareManager].backgroundImage=backgroundimage;
         [FCAppInfo shareManager].boxColor=[boxColor intValue];
         [FCAppInfo shareManager].TDic=dic[@"fontColor"];
         [FCAppInfo shareManager].huabanArr=dic[@"huaban"];
         [FCAppInfo shareManager].lflTemName=TemplateName;
         [FCAppInfo shareManager].pDic=dic[@"portroy"];
         EditDraftViewController*edit=[[EditDraftViewController alloc]init];
         edit.TemplateId=radom;
         edit.TemplateId1=TemplateId;
         
         [FCAppInfo shareManager].lflTemID=TemplateId;
         [self.navigationController pushViewController:edit animated:YES];
     }
     else
     {
         NSString *string=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
         
         if ([SelectedIDArr containsObject:string])
         {
             isAllSelected=NO;
             NSDictionary *dic=DetailNumberArr[indexPath.section];
             NSString * lfl=dic[@"radom"];
             [SelectedArr removeObject:lfl];
             [SelectedIDArr removeObject:string];
             [button setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
         }else
         {
             
             NSDictionary *dic=DetailNumberArr[indexPath.section];
             NSString * lfl=dic[@"radom"];
             [SelectedArr addObject:lfl];
             [SelectedIDArr addObject:string];
             if (SelectedIDArr.count==DetailNumberArr.count) {
                 isAllSelected=YES;
                 [button setBackgroundImage:[UIImage imageNamed:@"lflgx"] forState:UIControlStateNormal];
             }else{
                 isAllSelected=NO;
                 [button setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
             }
         }
         [self.ChooseBCollectionView reloadData];
     }
    
    
    
}

-(void)setFrame{
    self.bgImageView.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-80, 250, 160, 160);
}



@end
