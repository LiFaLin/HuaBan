//
//  cengjiViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/8.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "cengjiViewController.h"
#import "cengjilflViewController.h"
#import "cengjiCollectionViewCell.h"
#import "DraftViewController.h"
#import "DraftDetailViewController.h"
#import "header.h"
@interface cengjiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TencentSessionDelegate>{
    NSMutableArray * DetailNumberArr;
    int count;
    NSString * hasMore;
    UITapGestureRecognizer *tap;
    TencentOAuth *tencentOAuth;
}
@property(nonatomic,strong)UICollectionView * ChooseBCollectionView;
@property(nonatomic,strong)UIImageView * bgImageView;
@property (nonatomic,strong)UIView *background;
@property (nonatomic,strong)UIView *pickerBgView;

@property(nonatomic,strong)NSString * ScrapbookId;
@property(nonatomic,strong)NSString * TemplateId;
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * ScrapbookName;
@property(nonatomic,strong)NSString * picture;
@property(nonatomic,strong)NSString * text;
@end

@implementation cengjiViewController
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView=[[UIImageView alloc]init];
        _bgImageView.image=[UIImage imageNamed:@"Nocengji"];
    }
    return _bgImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confinRightItemWithName:@"草稿"];

    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    [stand setObject:@"yes" forKey:@"firstLogin"];
    [stand synchronize];
    [self.view addSubview:self.bgImageView];
    [self setFrame];
    
    DetailNumberArr=[NSMutableArray arrayWithCapacity:0];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(LWidth(335), LWidth(180));
    
    _ChooseBCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT_TOP_MARGIN, self.view.bounds.size.width,self.view.bounds.size.height-HEIGHT_TAB_BAR-HEIGHT_TOP_MARGIN) collectionViewLayout:layout];
    _ChooseBCollectionView.backgroundColor = [UIColor whiteColor];
    _ChooseBCollectionView.dataSource = self;
    _ChooseBCollectionView.delegate = self;
    _ChooseBCollectionView.showsVerticalScrollIndicator=YES;
    [_ChooseBCollectionView registerClass:[cengjiCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [_ChooseBCollectionView registerClass:[header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:_ChooseBCollectionView];
    self.ChooseBCollectionView.mj_header=[MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self getMyScrapbookList1];
        [self.ChooseBCollectionView.mj_footer resetNoMoreData];
    }];
   self.ChooseBCollectionView.mj_footer=[MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if ([self->hasMore isEqualToString:@"TRUE"]) {
            [self getMyScrapbookList];
        }
        else
        {
            [self.ChooseBCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
//    [gifFooter setTitle:@"我也是有底线的" forState:MJRefreshStateNoMoreData];
//    self.ChooseBCollectionView.mj_footer=gifFooter;
//    [self.ChooseBCollectionView.mj_footer beginRefreshing];
    //第一次进入直接刷新
//    [self.ChooseBCollectionView.mj_header beginRefreshing];
    
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
    return DetailNumberArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=DetailNumberArr[indexPath.section];
    NSString * imageString=[NSString stringWithFormat:@"%@",dic[@"Picture"]];
    cengjiCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@""]];
    
     NSString * time=[NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
     NSString * name=[NSString stringWithFormat:@"%@",dic[@"ScrapbookName"]];
    NSString * Likes=[NSString stringWithFormat:@"%@",dic[@"Likes"]];
    NSString * Views=[NSString stringWithFormat:@"%@",dic[@"Views"]];
    NSString * Comments=[NSString stringWithFormat:@"%@",dic[@"Comments"]];
    if ([name isEmptyString]) {
       cell.nameLabel.text=@"";
    }else{
       cell.nameLabel.text=name;
    }
     [cell.nameButton addTarget:self action:@selector(nameButton:) forControlEvents:UIControlEventTouchUpInside];
     cell.nameButton.tag=indexPath.section;
    
     cell.dayLabel.text=[NSString converStrToDate1:time];
     cell.lookLab.text=Views;
     cell.likeLab.text=Likes;
     cell.commentLab.text=Comments;
     return cell;
}

-(void)nameButton:(UIButton*)sender
{
    NSDictionary *dic=DetailNumberArr[sender.tag];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
//    UIAlertAction *edit = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
//                              {
////                                  [self loadUserInfo1:dic];
//                              }];
    UIAlertAction *editName = [UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [self eidtName:dic];
                            }];
    UIAlertAction *share = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   [self share:dic];
                               }];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
                               {
                                    [self deleteButton:dic];
                               }];
//    [alert addAction:edit];
    [alert addAction:editName];
    [alert addAction:share];
    [alert addAction:delete];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma 四种方法
-(void)loadUserInfo:(NSDictionary*)dic1{
    //    [self getNewToken];
    //    [DetailNumberArr removeAllObjects];
    NSString * ScrapbookId=[NSString stringWithFormat:@"%@",dic1[@"ScrapbookId"]];
    NSString * TemplateId=[NSString stringWithFormat:@"%@",dic1[@"TemplateId"]];
    NSString * url=[NSString stringWithFormat:@"%@",dic1[@"URL"]];
    NSString * ScrapbookName=[NSString stringWithFormat:@"%@",dic1[@"ScrapbookName"]];
    NSString * Picture=[NSString stringWithFormat:@"%@",dic1[@"Picture"]];
     NSString * text=[NSString stringWithFormat:@"%@",dic1[@"Text"]];
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"TemplateId":TemplateId};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"TemplateId":TemplateId};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:getTemplateBackgroundImageList WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        //        NSLog(@"--%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            
            [FCAppInfo shareManager].huabanArr =[dataDic objectForKey:@"BackgroundImageList"];
            [FCAppInfo shareManager].pDic =[dataDic objectForKey:@"PoetryList"];
            NSDictionary *Templatedic=[dataDic objectForKey:@"Template"];
            NSString *BackgroundImage=[NSString stringWithFormat:@"%@",Templatedic[@"BackgroundImage"]];
            [FCAppInfo shareManager].backgroundImage=BackgroundImage;
            cengjilflViewController *cj=[[cengjilflViewController alloc]init];
            cj.ScrapbookId=ScrapbookId;
            cj.TemplateId=TemplateId;
            cj.url=url;
            cj.ScrapbookName=ScrapbookName;
            cj.picture=Picture;
            cj.text=text;
            [self.navigationController pushViewController:cj animated:YES];
            
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
-(void)loadUserInfo1:(NSDictionary*)dic1{
    //    [self getNewToken];
    //    [DetailNumberArr removeAllObjects];
    NSString * ScrapbookId=[NSString stringWithFormat:@"%@",dic1[@"ScrapbookId"]];
    NSString * TemplateId=[NSString stringWithFormat:@"%@",dic1[@"TemplateId"]];
    NSString * url=[NSString stringWithFormat:@"%@",dic1[@"URL"]];
    NSString * ScrapbookName=[NSString stringWithFormat:@"%@",dic1[@"ScrapbookName"]];
    NSString * Picture=[NSString stringWithFormat:@"%@",dic1[@"Picture"]];
    NSString * text=[NSString stringWithFormat:@"%@",dic1[@"Text"]];
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"TemplateId":TemplateId};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"TemplateId":TemplateId};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:getTemplateBackgroundImageList WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        //        NSLog(@"--%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            
            [FCAppInfo shareManager].huabanArr =[dataDic objectForKey:@"BackgroundImageList"];
            [FCAppInfo shareManager].pDic =[dataDic objectForKey:@"PoetryList"];
            NSDictionary *Templatedic=[dataDic objectForKey:@"Template"];
          
            NSString *BackgroundImage=[NSString stringWithFormat:@"%@",Templatedic[@"BackgroundImage"]];
            [FCAppInfo shareManager].backgroundImage=BackgroundImage;
            
           
            DraftDetailViewController *cj=[[DraftDetailViewController alloc]init];
            cj.TemplateId=TemplateId;
            cj.ScrapbookId=ScrapbookId;
            [FCAppInfo shareManager].lflTemID=TemplateId;
            [self.navigationController pushViewController:cj animated:YES];
            
//            cengjilflViewController *cj=[[cengjilflViewController alloc]init];
//            cj.ScrapbookId=ScrapbookId;
//            cj.TemplateId=TemplateId;
//            cj.url=url;
//            cj.ScrapbookName=ScrapbookName;
//            cj.picture=Picture;
//            cj.text=text;
//            [self.navigationController pushViewController:cj animated:YES];
            
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
-(void)eidtName:(NSDictionary*)dic{
    NSString * name=[NSString stringWithFormat:@"%@",dic[@"ScrapbookName"]];
    NSString * ScrapbookId=[NSString stringWithFormat:@"%@",dic[@"ScrapbookId"]];
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
                                                             }else{
                                                                 [self updateScrapbookName:text.text withScrapbookId:ScrapbookId];
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

-(void)share:(NSDictionary*)dic{
    NSLog(@"分享");
    self.ScrapbookId=[NSString stringWithFormat:@"%@",dic[@"ScrapbookId"]];
    self.TemplateId=[NSString stringWithFormat:@"%@",dic[@"TemplateId"]];
    self.url=[NSString stringWithFormat:@"%@",dic[@"URL"]];
    self.ScrapbookName=[NSString stringWithFormat:@"%@",dic[@"ScrapbookName"]];
    self.picture=[NSString stringWithFormat:@"%@",dic[@"Picture"]];
    NSString *str=[NSString stringWithFormat:@"%@",dic[@"Text"]];
    
//    NSArray *arry=[str componentsSeparatedByString:@"，"];
//
//    NSString *str2=[[NSString alloc]init];
//
//    for (NSString *mystr in arry) {
//
//        str2=[str2 stringByAppendingFormat:@"\n%@",mystr];
//
//    }
    self.text=str;
    _background = [[UIView alloc]init];
    _background.frame =CGRectMake(0,0,APP_SCREEN_WIDTH,APP_SCREEN_HEIGHT);
    _background.backgroundColor = [UIColor blackColor];
    _background.alpha =0.5;
    _background.hidden=NO;
    [self.navigationController.view addSubview:_background];
    tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=1;
    [self.background addGestureRecognizer:tap];
    
    _pickerBgView = [[UIView alloc]init];
    _pickerBgView.frame =CGRectMake(0,APP_SCREEN_HEIGHT - 200,APP_SCREEN_WIDTH,200);
    _pickerBgView.backgroundColor = [UIColor whiteColor];
    _pickerBgView.hidden=NO;
    [self.navigationController.view addSubview:_pickerBgView];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"分享到";
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:16];
    label.textAlignment=NSTextAlignmentCenter;
    label.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-40, 20, 80, 20);
    [_pickerBgView addSubview:label];
    
    
    UIButton * Person=[UIButton buttonWithType:UIButtonTypeCustom];
    [Person addTarget:self action:@selector(personClick:) forControlEvents:UIControlEventTouchUpInside];
    [Person setTitle:@"微信好友" forState:UIControlStateNormal];
    [Person setImage:[UIImage imageNamed:@"weixinhaoyou"] forState:UIControlStateNormal];
    Person.titleLabel.font=[UIFont systemFontOfSize:16];
    [Person setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 30, 0)];
    [Person setTitleEdgeInsets:UIEdgeInsetsMake(70, -50, 0, 0)];
    Person.frame=CGRectMake(0, 40, APP_SCREEN_WIDTH/4.0, 100);
    Person.tag=0;
    [Person setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_pickerBgView addSubview:Person];
    
    
    UIButton * Person1=[UIButton buttonWithType:UIButtonTypeCustom];
    [Person1 addTarget:self action:@selector(personClick:) forControlEvents:UIControlEventTouchUpInside];
    [Person1 setTitle:@"朋友圈" forState:UIControlStateNormal];
    [Person1 setImage:[UIImage imageNamed:@"pengyouquan"] forState:UIControlStateNormal];
    Person1.titleLabel.font=[UIFont systemFontOfSize:16];
    [Person1 setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 30, 0)];
    [Person1 setTitleEdgeInsets:UIEdgeInsetsMake(70, -50, 0, 0)];
    Person1.tag=1;
    Person1.frame=CGRectMake(APP_SCREEN_WIDTH/4.0, 40, APP_SCREEN_WIDTH/4.0, 100);
    [Person1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_pickerBgView addSubview:Person1];
    
    UIButton * QPerson=[UIButton buttonWithType:UIButtonTypeCustom];
    [QPerson addTarget:self action:@selector(QpersonClick:) forControlEvents:UIControlEventTouchUpInside];
    [QPerson setTitle:@"QQ好友" forState:UIControlStateNormal];
    [QPerson setImage:[UIImage imageNamed:@"QQhaoyou"] forState:UIControlStateNormal];
    QPerson.titleLabel.font=[UIFont systemFontOfSize:16];
    [QPerson setImageEdgeInsets:UIEdgeInsetsMake(0, 13, 30, 0)];
    [QPerson setTitleEdgeInsets:UIEdgeInsetsMake(70, -50, 0, 0)];
    QPerson.frame=CGRectMake(APP_SCREEN_WIDTH/2.0, 40, APP_SCREEN_WIDTH/4.0, 100);
    QPerson.tag=0;
    [QPerson setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_pickerBgView addSubview:QPerson];
    
    
    UIButton * QPerson1=[UIButton buttonWithType:UIButtonTypeCustom];
    [QPerson1 addTarget:self action:@selector(QpersonClick:) forControlEvents:UIControlEventTouchUpInside];
    [QPerson1 setTitle:@"QQ空间" forState:UIControlStateNormal];
    [QPerson1 setImage:[UIImage imageNamed:@"QQkongjian"] forState:UIControlStateNormal];
    QPerson1.titleLabel.font=[UIFont systemFontOfSize:16];
    [QPerson1 setImageEdgeInsets:UIEdgeInsetsMake(0, 13, 30, 0)];
    [QPerson1 setTitleEdgeInsets:UIEdgeInsetsMake(70, -50, 0, 0)];
    QPerson1.tag=1;
    QPerson1.frame=CGRectMake(APP_SCREEN_WIDTH/4.0*3.0, 40, APP_SCREEN_WIDTH/4.0, 100);
    [QPerson1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_pickerBgView addSubview:QPerson1];
    
    UIButton * cance=[UIButton buttonWithType:UIButtonTypeCustom];
    [cance addTarget:self action:@selector(canceClick) forControlEvents:UIControlEventTouchUpInside];
    [cance setTitle:@"取消" forState:UIControlStateNormal];
    cance.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [cance setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cance.frame=CGRectMake(0, 160, APP_SCREEN_WIDTH, 40);
    cance.titleLabel.font=[UIFont systemFontOfSize:15];
    [_pickerBgView addSubview:cance];
    
    
    
}
-(void)canceClick{
    self.background.hidden=YES;
    self.pickerBgView.hidden=YES;
}
-(void)personClick:(UIButton*)sender{
    
   
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.picture]];
    
    UIImage *image = [UIImage imageWithData:data];
    
    UIImage *image1=[UIImage compressImage:image toByte:32*1024];
    
    int scent;
    NSString *string=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([string isEqualToString:@"0"]) {
        scent=0;
    }
    else
    {
        scent=1;
    }
    
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = scent;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    
    if (scent==0) {
       urlMessage.title = self.ScrapbookName;//分享标题
       urlMessage.description = self.text;//分享描述
    }else{
         urlMessage.title = self.text;//分享标题
         urlMessage.description = self.text;//分享描述
    }
   
    [urlMessage setThumbImage:image1];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = self.url;//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:sendReq];
    
    NSLog(@"--%d--%@--%@",scent,self.ScrapbookName,self.url);
}

-(void)QpersonClick:(UIButton*)sender{
   
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.picture]];
    UIImage *image = [UIImage imageWithData:data];
    tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"1106874265"andDelegate:self];
    NSString *string=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    if ([string isEqualToString:@"0"]) {
        
        QQApiURLObject *urlObject = [QQApiURLObject objectWithURL:[NSURL URLWithString:self.url] title:self.ScrapbookName description:self.text previewImageData:UIImageJPEGRepresentation(image, 1) targetContentType:QQApiURLTargetTypeNews];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObject];
        // 分享给好友
        [QQApiInterface sendReq:req];
    }else{
        QQApiURLObject *urlObject = [QQApiURLObject objectWithURL:[NSURL URLWithString:self.url] title:self.ScrapbookName description:self.text previewImageData:UIImageJPEGRepresentation(image, 1) targetContentType:QQApiURLTargetTypeNews];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObject];
        [QQApiInterface SendReqToQZone:req];
    }
    
    
    
}
-(void)tap:(UITapGestureRecognizer*)tap{
    
    [self.view endEditing:YES];
    self.background.hidden=YES;
    self.pickerBgView.hidden=YES;
    
}
-(void)deleteButton:(NSDictionary*)dic{
    NSString*ScrapbookId=[NSString stringWithFormat:@"%@",dic[@"ScrapbookId"]];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self deleteBook:ScrapbookId];
    }];
    UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alertController addAction:confirm];
    [alertController addAction:cance];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)deleteBook:(NSString*)ScrapbookId{
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"ScrapbookId":ScrapbookId};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"ScrapbookId":ScrapbookId};
    
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:deleteScrapbook WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"shanchu%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            
           [self getMyScrapbookList1];
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
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return nil;
    }else{
        UICollectionReusableView* reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *label=[[UILabel alloc]init];
        label.backgroundColor=UIColorFromRGB(247, 247, 247);
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
    NSDictionary *dic=DetailNumberArr[indexPath.section];
    
    [self loadUserInfo:dic];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getMyScrapbookList1];
    
}
-(void)setFrame{
    self.bgImageView.frame=CGRectMake(APP_SCREEN_WIDTH/2.0-80, 250, 160, 140);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateScrapbookName:(NSString*)name withScrapbookId:(NSString*)ScrapbookId{
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"ScrapbookName":name,@"ScrapbookId":ScrapbookId};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"ScrapbookName":name,@"ScrapbookId":ScrapbookId};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:updateScrapbookName WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            self->count=self->count-10;
            [self getMyScrapbookList1];
            
        }
        
        else if ([msgStr isEqualToString:@"0"])
        {
            [self getNewToken];
            
            //            [self getMyScrapbookList];
            
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
-(void)getMyScrapbookList{
    
    count+=10;
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"Count":[NSString stringWithFormat:@"%d",count]};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"Count":[NSString stringWithFormat:@"%d",count]};
    NSLog(@"--%@",param);
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:getMyScrapbookList WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            
            self->hasMore=[NSString stringWithFormat:@"%@",dataDic[@"HasMore"]];
            
            self->DetailNumberArr=[dataDic objectForKey:@"ScrapbookList"];
            if (self->DetailNumberArr.count<1) {
                self.ChooseBCollectionView.hidden=YES;
            }else{
                 self.ChooseBCollectionView.hidden=NO;
                 [self.ChooseBCollectionView reloadData];
            }
            
            [self.ChooseBCollectionView.mj_footer endRefreshing];
        }
        
        else if ([msgStr isEqualToString:@"0"])
        {
            [self getNewToken];
            
//            [self getMyScrapbookList];
            
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

-(void)getMyScrapbookList1{
    [DetailNumberArr removeAllObjects];
    count=10;
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"Count":@"10"};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"Count":@"10"};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:getMyScrapbookList WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            self->hasMore=[NSString stringWithFormat:@"%@",dataDic[@"HasMore"]];
            [FCAppInfo shareManager].MaxXian=[NSString stringWithFormat:@"%@",dataDic[@"MaxScrapbookSize"]];
            if ([self->hasMore isEqualToString:@"TRUE"]) {
               
            }
            else
            {
                [self.ChooseBCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
            self->DetailNumberArr=[dataDic objectForKey:@"ScrapbookList"];
            if (self->DetailNumberArr.count<1) {
                self.ChooseBCollectionView.hidden=YES;
            }else{
                self.ChooseBCollectionView.hidden=NO;
                [self.ChooseBCollectionView reloadData];
            }
            
            [self.ChooseBCollectionView.mj_header endRefreshing];
        }
        
        else if ([msgStr isEqualToString:@"0"])
        {
            [self getNewToken];
            
            //            [self getMyScrapbookList];
            
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
- (NSString *)timeFormatted:(int)totalSeconds
{
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    return [NSString stringWithFormat:@"%@",localeDate];
}

@end
