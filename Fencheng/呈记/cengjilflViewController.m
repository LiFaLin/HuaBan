//
//  cengjilflViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/26.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "cengjilflViewController.h"
#import "cengjiDetailViewController.h"
#import "YOneCell.h"
#import "YTwoCell.h"
#import "YThreeCell.h"
#import "YFourCell.h"
#import "YFiveCell.h"
#import "YSixCell.h"
#import "YSenvenCell.h"
#import "YEightCell.h"
#import "YNineCell.h"
#import "YTenCell.h"
#import "FCTabBarViewController.h"
#import "header.h"
#import "header1.h"
#import "CommentCollectionViewCell.h"
#import "Comment1CollectionViewCell.h"
#import "Comment2CollectionViewCell.h"
@interface cengjilflViewController ()

<UICollectionViewDelegate,UICollectionViewDataSource,TencentSessionDelegate,UITextViewDelegate>{
    //    NSMutableArray * dataNumberArr;
    NSMutableArray * ModuleIdArr;
    NSMutableArray * ImageArr;
    UIView * guideAnimationView;
    NSString *Currentstring;
    UIImage *CurrentImage;
    NSDictionary *textAttribute;
    //测试
    
    NSString * lflimage; //看他是第几item
    
    NSString * image1;   //看他是第几item中的第几
    
    //    NSArray * goodIdea;
    
    BOOL chooseImg;
    BOOL chooseVideo;
    
    UIImage *videoImage;
    
    NSString * wancheng;
    NSMutableArray * pamaArr;
    
    //    沙盒里面存在的总数据
    NSMutableArray * zongArr;
    
    NSMutableArray * ModulesArr;
    NSDictionary * ScrapbookList;
    NSString * changeNum;
    MBProgressHUD *hud;
    
    NSString *yunxu;
    TencentOAuth *tencentOAuth;
    
    UILabel *placeHolderLabel;

    UITapGestureRecognizer *tap;
    UITapGestureRecognizer *tap1;
    UITapGestureRecognizer *tap2;
    NSString * ToCommentId;
    
    NSArray * ReplysArr;
    NSMutableArray * SCArr;
    NSMutableArray * LikeArr;
    UIButton *button;
    UIButton *headerButton;
    NSString*currentCell;
}
@property(nonatomic,strong)UICollectionView * DataCollectionView;
@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property(nonatomic,strong)NSString *accessKeyId;
@property(nonatomic,strong)NSString *accessKeySecret;
@property(nonatomic,strong)NSString *securityToken;
@property(nonatomic,strong)NSString *buketName;
@property(nonatomic,strong)NSString *AccessDomain;
@property(nonatomic,strong)NSString *EndPoint;
@property(nonatomic,strong)NSString *BobjectKey;
@property(nonatomic,strong)NSString *SobjectKey;

@property (nonatomic,strong)UIView *background;
@property (nonatomic,strong)UIView *pickerBgView;
@property (nonatomic,strong)UIView *background1;
@property (nonatomic,strong)UIView *background2;
@property (nonatomic,strong)UIView *pickerBgView1;
@property (nonatomic, strong)LFLVideoPlayer * player;
@property(nonatomic,strong)UIView * BgView;
@property(nonatomic,strong)UITextView*textView;
@end


@implementation cengjilflViewController
-(UIView *)BgView{
    if (!_BgView) {
        _BgView=[[UIView alloc]init];
        _BgView.backgroundColor=RGBA(247, 245, 245, 1);
        _BgView.frame=CGRectMake(0, APP_SCREEN_HEIGHT-50, APP_SCREEN_WIDTH, 50);
        _BgView.hidden=YES;
    }
    return _BgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [FCAppInfo shareManager].ScrapbookId=self.ScrapbookId;
    SCArr=[NSMutableArray arrayWithCapacity:0];
    LikeArr=[NSMutableArray arrayWithCapacity:0];
    NSLog(@"--%f",APP_SCREEN_WIDTH);
    changeNum=@"0";
    yunxu=@"1";
    ModulesArr=[NSMutableArray arrayWithCapacity:0];
    ModuleIdArr=[NSMutableArray arrayWithCapacity:0];
    ImageArr=[NSMutableArray arrayWithCapacity:0];
    pamaArr=[NSMutableArray arrayWithCapacity:0];
    chooseVideo=NO;
    chooseImg=NO;

    
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self confinRightItemWithImg:[UIImage imageNamed:@"morelfl"]];
    
    [self loadData];
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)popLeftItemView{
    
    //移除所有有关的text沙盒
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:self.ScrapbookId]) {
            [stand removeObjectForKey:key];
            [stand synchronize];
        }
        
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PicutreFromAlbum" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.background1.hidden=YES;
    self.pickerBgView1.hidden=YES;
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
}

-(void)next{
    
}
-(void)popRightItemView{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *edit = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                           {
                               self->wancheng=@"1";
                               cengjiDetailViewController *detail=[[cengjiDetailViewController alloc]init];
                               detail.TemplateId=self.TemplateId;
                               [FCAppInfo shareManager].lflTemID=self.TemplateId;
                               detail.ScrapbookId=self.ScrapbookId;
                               detail.isFrom=@"cengjilfl";
                               detail.scrobookName=self.ScrapbookName;
                               [self.DataCollectionView reloadData];
                               [self.navigationController pushViewController:detail animated:YES];
                           }];
    UIAlertAction *editName = [UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   [self eidtName:self.ScrapbookId];
                               }];
    UIAlertAction *share = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                               [self share];
                            }];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
                             {
                                  [self deleteButton];
                             }];
    [alert addAction:edit];
    [alert addAction:editName];
    [alert addAction:share];
    [alert addAction:delete];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)eidtName:(NSString*)ScrapbookId{
    
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
        
        textField.text=self.ScrapbookName;
        
        
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
            self.ScrapbookName=name;
            self.title=self.ScrapbookName;
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
-(void)deleteButton{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self deleteBook:self.ScrapbookId];
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

-(void)share{
    NSLog(@"分享");
   
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
    urlMessage.title = self.ScrapbookName;//分享标题
    urlMessage.description = self.text;//分享描述
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
-(void)viewWillAppear:(BOOL)animated{
    self.title=self.ScrapbookName;
    wancheng=@"0";
    self.automaticallyAdjustsScrollViewInsets=NO;
    //设置collectionView的背景图片
    UIImageView * imageView=[[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[FCAppInfo shareManager].backgroundImage] placeholderImage:[UIImage imageNamed:@""]];
    imageView.frame=CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 1;
    
    _DataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT_TOP_MARGIN, self.view.bounds.size.width,self.view.bounds.size.height-HEIGHT_TOP_MARGIN) collectionViewLayout:layout];
    
    _DataCollectionView.backgroundColor = [UIColor whiteColor];
    _DataCollectionView.dataSource = self;
    _DataCollectionView.delegate = self;
    _DataCollectionView.backgroundView=imageView;
    _DataCollectionView.showsVerticalScrollIndicator=YES;
    [_DataCollectionView registerClass:[YOneCell class] forCellWithReuseIdentifier:@"cellid1"];
    [_DataCollectionView registerClass:[YTwoCell class] forCellWithReuseIdentifier:@"cellid2"];
    [_DataCollectionView registerClass:[YThreeCell class] forCellWithReuseIdentifier:@"cellid3"];
    [_DataCollectionView registerClass:[YFourCell class] forCellWithReuseIdentifier:@"cellid4"];
    [_DataCollectionView registerClass:[YFiveCell class] forCellWithReuseIdentifier:@"cellid5"];
    [_DataCollectionView registerClass:[YSixCell class] forCellWithReuseIdentifier:@"cellid6"];
    [_DataCollectionView registerClass:[YSenvenCell class] forCellWithReuseIdentifier:@"cellid7"];
    [_DataCollectionView registerClass:[YEightCell class] forCellWithReuseIdentifier:@"cellid8"];
    [_DataCollectionView registerClass:[YNineCell class] forCellWithReuseIdentifier:@"cellid9"];
    [_DataCollectionView registerClass:[YTenCell class] forCellWithReuseIdentifier:@"cellid10"];
    
    
    
    [_DataCollectionView registerClass:[header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_DataCollectionView registerClass:[header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    [_DataCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [_DataCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer1"];
    [_DataCollectionView registerClass:[CommentCollectionViewCell class] forCellWithReuseIdentifier:@"comment"];
    [_DataCollectionView registerClass:[Comment1CollectionViewCell class] forCellWithReuseIdentifier:@"comment1"];
    [_DataCollectionView registerClass:[Comment2CollectionViewCell class] forCellWithReuseIdentifier:@"comment2"];
    [self.view addSubview:_DataCollectionView];
    
    [self.view addSubview:self.BgView];
    if (!_textView)
    {
        _textView=[[UITextView alloc]init];
        _textView.backgroundColor=[UIColor whiteColor];
        _textView.delegate=self;
        _textView.returnKeyType=UIReturnKeySend;
        _textView.frame=CGRectMake(20, 10, APP_SCREEN_WIDTH-40, 30);
        [self.BgView addSubview:_textView];
        
        placeHolderLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        placeHolderLabel.textColor=[UIColor grayColor];
        placeHolderLabel.font=self.textView.font;
        [self.textView addSubview:placeHolderLabel];
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets=NO;
            
        }
    }

    
    
}

#pragma UICollectionDelegate
//collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    NSArray * arr=ScrapbookList[@"CommentList"];
    return arr.count+2;
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return ModuleIdArr.count;
    }
    else if (section==1)
    {
        return 1;
    }
        
    else
    {
        NSArray * arr=ScrapbookList[@"CommentList"];
        NSDictionary * ReplysDic=arr[section-2];
        NSArray *ReplysArr=ReplysDic[@"Replys"];
        return ReplysArr.count+1;
    }

}
-(void)lflButton{
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //
    
    if (indexPath.section==0)
    {
        NSString * currentString=ModuleIdArr[indexPath.row];
        
        if ([currentString isEqualToString:@"Module_1_1"]) {
            
            
            YOneCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid1" forIndexPath:indexPath];
            
            cell1.editButton.tag=indexPath.row;
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[0];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell1.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell1.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSDictionary *dic=paraArr[0];
            
            if (dic.count>2) {
                cell1.bottomLabel.text=dic[@"Text"];
                cell1.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
                cell1.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
                if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                    cell1.bottomLabel.textAlignment=NSTextAlignmentCenter;
                }
                else if ([dic[@"TextAlign"] isEqualToString:@"Left"]) {
                    cell1.bottomLabel.textAlignment=NSTextAlignmentLeft;
                }else{
                    cell1.bottomLabel.textAlignment=NSTextAlignmentRight;
                }
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                if (height>kheigh(58)){
                    cell1.editButton.frame=CGRectMake(kheigh(20), 0, self.view.bounds.size.width-2*kWidth(20), height);
                    cell1.bottomLabel.frame=CGRectMake(0, 0, self.view.bounds.size.width-2*kWidth(20), height);
                }
                else
                {
                    cell1.editButton.frame=CGRectMake(kheigh(20),0, self.view.bounds.size.width-2*kWidth(20), kheigh(58));
                    cell1.bottomLabel.frame=CGRectMake(0, 0, self.view.bounds.size.width-2*kWidth(20), kheigh(58));
                }
                
            }
            //保存从服务器返回的数据
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
            
            return cell1;
        }
        else if ([currentString isEqualToString:@"Module_1_2"]){
            NSString * tag=@"2";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            
            YTwoCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid2" forIndexPath:indexPath];
            
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[1];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell2.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell2.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
//            cell2.addButton.tag=indexPath.row;
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell2.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell2.centerImg.image=[UIImage imageNamed:@""];
                    [cell2.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell2.addButton.tag=indexPath.row;
                    
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    cell2.addButton.userInteractionEnabled=NO;
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell2.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell2.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                       
                    }
                    else
                    {
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell2.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell2.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                           
                            
                            
                            
                        }
                        
    
                    }
                    
                    //判断是否是老版本导致的未上传gifURL
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    
                    
                    
                    cell2.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell2.addButton addTarget:self action:@selector(Cell2AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell2.addButton.tag=indexPath.row;
                     cell2.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                    
//                    NSString *giftextIndex1=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.ScrapbookId];
//                    [self setValueName:dic1 withKey:giftextIndex1];
                    
                    
                }
                
                
            }
            
            return cell2;
        }
        else if ([currentString isEqualToString:@"Module_2_1"]){
            
            NSString * imageUrl;
            YThreeCell *cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid3" forIndexPath:indexPath];
//        dequeueReusableCellWithReuseIdentifier:@"cellid3" forIndexPath:indexPath];
//            TitleViewCell * cell = (TitleViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];//
            NSString * tag=@"3";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[2];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell3.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell3.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            cell3.editButton.tag=indexPath.row;
            
            
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSDictionary *dic=paraArr[0];
            
            if (dic.count>2) {
                cell3.bottomLabel.text=dic[@"Text"];
                cell3.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
                cell3.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
                if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                    cell3.bottomLabel.textAlignment=NSTextAlignmentCenter;
                }
                else if ([dic[@"TextAlign"] isEqualToString:@"Left"]) {
                    cell3.bottomLabel.textAlignment=NSTextAlignmentLeft;
                }else{
                    cell3.bottomLabel.textAlignment=NSTextAlignmentRight;
                }
                
            }
            //保存从服务器返回的数据
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            
            [self setValueName:dic withKey:textIndex];
            //        添加图片按钮的操作
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell3.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell3.centerImg.image=[UIImage imageNamed:@""];
                    [cell3.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell3.addButton.tag=indexPath.row;
                    cell3.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                    
                }
                else
                {
                    
                    
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell3.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell3.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell3.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell3.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    
                    
                    
                    cell3.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell3.addButton addTarget:self action:@selector(Cell3AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell3.addButton.tag=indexPath.row;
                    cell3.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
                imageUrl=string;
            }
            
            
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell3.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell3.center1Img.image=[UIImage imageNamed:@""];
                    [cell3.add1Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell3.add1Button.tag=indexPath.row;
                    cell3.add1Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                    
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell3.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell3.add1Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell3.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell3.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    
                    cell3.center1Img.image=[UIImage imageNamed:@"zanting"];
                    [cell3.add1Button addTarget:self action:@selector(Cell3Add1Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell3.add1Button.tag=indexPath.row;
                    cell3.add1Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
                
            }
            
            return cell3;
        }
        else if ([currentString isEqualToString:@"Module_2_2"]){
            YFourCell *cell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid4" forIndexPath:indexPath];
            NSString * tag=@"4";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            //        [cell4.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
            cell4.editButton.tag=indexPath.row;
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[3];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell4.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell4.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSDictionary *dic=paraArr[0];
            
            if (dic.count>2) {
                cell4.bottomLabel.text=dic[@"Text"];
                cell4.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
                cell4.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
                if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                    cell4.bottomLabel.textAlignment=NSTextAlignmentCenter;
                }
                else if ([dic[@"TextAlign"] isEqualToString:@"Left"]) {
                    cell4.bottomLabel.textAlignment=NSTextAlignmentLeft;
                }else{
                    cell4.bottomLabel.textAlignment=NSTextAlignmentRight;
                }
                
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                if (height>kheigh(31)){
                    cell4.bgImage.frame=CGRectMake(cell4.bgImage.frame.origin.x, kheigh(46)+height-kheigh(31), cell4.bgImage.frame.size.width, cell4.bgImage.frame.size.height);
                    cell4.editButton.frame=CGRectMake(kheigh(20), 0, kheigh(280), height);
                    cell4.bottomLabel.frame=CGRectMake(0, 0, kheigh(280), height);
                    cell4.addButton.frame=CGRectMake(cell4.addButton.frame.origin.x, kheigh(46)+height-kheigh(31), cell4.addButton.frame.size.width, cell4.addButton.frame.size.height);
                }else{
                     cell4.bgImage.frame=CGRectMake(cell4.bgImage.frame.origin.x, kheigh(46),cell4.bgImage.frame.size.width, cell4.bgImage.frame.size.height);
                    cell4.editButton.frame=CGRectMake(kheigh(20), 0, kheigh(280), kheigh(31));
                    cell4.bottomLabel.frame=CGRectMake(0, 0, kheigh(280), kheigh(31));
                    cell4.addButton.frame=CGRectMake(cell4.addButton.frame.origin.x, kheigh(46), cell4.addButton.frame.size.width, cell4.addButton.frame.size.height);
                }
            }
            
            //保存从服务器返回的数据
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
            //        添加图片按钮的操作
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell4.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell4.centerImg.image=[UIImage imageNamed:@""];
                    [cell4.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell4.addButton.tag=indexPath.row;
                    cell4.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell4.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell4.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell4.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell4.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                            
                        }
                        
                    }
                    

                    
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    
                    cell4.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell4.addButton addTarget:self action:@selector(Cell4AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell4.addButton.tag=indexPath.row;cell4.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
            }
            return cell4;
        }
        else if ([currentString isEqualToString:@"Module_3_1"]){
           
            YFiveCell *cell5 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid5" forIndexPath:indexPath];
            NSString * tag=@"5";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            //        [cell5.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
            cell5.editButton.tag=indexPath.row;
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[4];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell5.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell5.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSDictionary *dic=paraArr[0];
            
            if (dic.count>2) {
                cell5.bottomLabel.text=dic[@"Text"];
                cell5.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
                cell5.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
                if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                    cell5.bottomLabel.textAlignment=NSTextAlignmentCenter;
                }
                else if ([dic[@"TextAlign"] isEqualToString:@"Left"]) {
                    cell5.bottomLabel.textAlignment=NSTextAlignmentLeft;
                }else{
                    cell5.bottomLabel.textAlignment=NSTextAlignmentRight;
                }
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                if (height>kheigh(15)) {
                    cell5.bgImage.frame=CGRectMake(cell5.bgImage.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.bgImage.frame.size.width, cell5.bgImage.frame.size.height);
                    cell5.editButton.frame=CGRectMake(kheigh(20),0, kWidth(280), height);
                    cell5.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), height);
                    cell5.addButton.frame=CGRectMake(cell5.addButton.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.addButton.frame.size.width, cell5.addButton.frame.size.height);
                    cell5.add1Button.frame=CGRectMake(cell5.add1Button.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.add1Button.frame.size.width, cell5.add1Button.frame.size.height);
                    cell5.add2Button.frame=CGRectMake(cell5.add2Button.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.add2Button.frame.size.width, cell5.add2Button.frame.size.height);
                    
                }else{
                    cell5.bgImage.frame=CGRectMake(cell5.bgImage.frame.origin.x, kheigh(30), cell5.bgImage.frame.size.width, cell5.bgImage.frame.size.height);
                    cell5.editButton.frame=CGRectMake(kheigh(20), 0, kWidth(280), kheigh(15));
                    cell5.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kheigh(15));
                    cell5.addButton.frame=CGRectMake(cell5.addButton.frame.origin.x, kheigh(30), cell5.addButton.frame.size.width, cell5.addButton.frame.size.height);
                    cell5.add1Button.frame=CGRectMake(cell5.add1Button.frame.origin.x, kheigh(30), cell5.add1Button.frame.size.width, cell5.add1Button.frame.size.height);
                    cell5.add2Button.frame=CGRectMake(cell5.add2Button.frame.origin.x, kheigh(30), cell5.add2Button.frame.size.width, cell5.add2Button.frame.size.height);
                }
                
            }
            
            //保存从服务器返回的数据
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
            //        添加图片按钮的操作
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell5.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.centerImg.image=[UIImage imageNamed:@""];
                    [cell5.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell5.addButton.tag=indexPath.row;
                    cell5.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell5.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell5.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell5.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell5.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell5.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell5.addButton addTarget:self action:@selector(Cell5AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell5.addButton.tag=indexPath.row;cell5.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
                
            }
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell5.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.center1Img.image=[UIImage imageNamed:@""];
                    [cell5.add1Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell5.add1Button.tag=indexPath.row;
                    cell5.add1Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell5.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell5.add1Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell5.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell5.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                            
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell5.center1Img.image=[UIImage imageNamed:@"zanting"];
                    [cell5.add1Button addTarget:self action:@selector(Cell5Add1Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell5.add1Button.tag=indexPath.row;cell5.add1Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
            }
            
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[3];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell5.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.center2Img.image=[UIImage imageNamed:@""];
                    [cell5.add2Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell5.add2Button.tag=indexPath.row;
                    cell5.add2Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell5.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell5.add2Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell5.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell5.add2Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld3%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld3%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell5.center2Img.image=[UIImage imageNamed:@"zanting"];
                    [cell5.add2Button addTarget:self action:@selector(Cell5Add2Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell5.add2Button.tag=indexPath.row;cell5.add2Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
            }
            return cell5;
        }
        else if ([currentString isEqualToString:@"Module_3_2"]){
            
            YSixCell *cell6 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid6" forIndexPath:indexPath];
            NSString * tag=@"6";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            //        [cell6.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
            cell6.editButton.tag=indexPath.row;
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[5];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell6.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell6.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSDictionary *dic=paraArr[3];
            
            if (dic.count>2) {
                cell6.bottomLabel.text=dic[@"Text"];
                cell6.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
                cell6.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
                if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                    cell6.bottomLabel.textAlignment=NSTextAlignmentCenter;
                }
                else if ([dic[@"TextAlign"] isEqualToString:@"Left"]) {
                    cell6.bottomLabel.textAlignment=NSTextAlignmentLeft;
                }else{
                    cell6.bottomLabel.textAlignment=NSTextAlignmentRight;
                }
                
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                if (height>kWidth(33)) {
                    cell6.editButton.frame=CGRectMake(kWidth(20), kWidth(165), kWidth(280), height);
                    cell6.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), height-25);
                }else{
                    cell6.editButton.frame=CGRectMake(kWidth(20), kWidth(165),kWidth(280), kWidth(33));
                    cell6.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kWidth(33));
                }
            }
            //保存从服务器返回的数据
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
            //        添加图片按钮的操作
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell6.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.centerImg.image=[UIImage imageNamed:@""];
                    [cell6.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell6.addButton.tag=indexPath.row;cell6.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell6.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell6.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell6.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell6.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                            
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell6.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell6.addButton addTarget:self action:@selector(Cell6AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell6.addButton.tag=indexPath.row;cell6.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
            }
            
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell6.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.center1Img.image=[UIImage imageNamed:@""];
                    [cell6.add1Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell6.add1Button.tag=indexPath.row;cell6.add1Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell6.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell6.add1Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell6.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell6.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell6.center1Img.image=[UIImage imageNamed:@"zanting"];
                    [cell6.add1Button addTarget:self action:@selector(Cell6Add1Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell6.add1Button.tag=indexPath.row;cell6.add1Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
            }
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell6.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.center2Img.image=[UIImage imageNamed:@""];
                    [cell6.add2Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell6.add2Button.tag=indexPath.row;cell6.add2Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell6.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell6.add2Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell6.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell6.add2Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld3%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld3%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell6.center2Img.image=[UIImage imageNamed:@"zanting"];
                    [cell6.add2Button addTarget:self action:@selector(Cell6Add2Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell6.add2Button.tag=indexPath.row;cell6.add2Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
            }
            return cell6;
        }
        else if ([currentString isEqualToString:@"Module_4_2"]){
            
            YEightCell *cell8 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid8" forIndexPath:indexPath];
            NSString * tag=@"8";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[7];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell8.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell8.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            
            //        添加图片按钮的操作
            //        [cell8.addButton addTarget:self action:@selector(Cell8AddButton:) forControlEvents:UIControlEventTouchUpInside];
            cell8.addButton.tag=indexPath.row;
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.centerImg.image=[UIImage imageNamed:@""];
                    [cell8.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell8.addButton.tag=indexPath.row;cell8.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell8.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell8.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell8.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell8.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell8.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell8.addButton addTarget:self action:@selector(Cell8AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell8.addButton.tag=indexPath.row;cell8.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
            }
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center1Img.image=[UIImage imageNamed:@""];
                    [cell8.add1Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell8.add1Button.tag=indexPath.row;cell8.add1Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell8.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell8.add1Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell8.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell8.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                           
                        }
                        
                    }
                    
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld2%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell8.center1Img.image=[UIImage imageNamed:@"zanting"];
                    [cell8.add1Button addTarget:self action:@selector(Cell8Add1Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell8.add1Button.tag=indexPath.row;
                    cell8.add1Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
            }
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center2Img.image=[UIImage imageNamed:@""];
                    [cell8.add2Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell8.add2Button.tag=indexPath.row;cell8.add2Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell8.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell8.add2Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell8.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell8.add2Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                           
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld3%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld3%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell8.center2Img.image=[UIImage imageNamed:@"zanting"];
                    [cell8.add2Button addTarget:self action:@selector(Cell8Add2Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell8.add2Button.tag=indexPath.row;cell8.add2Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
                
            }
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[3];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.add3Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center3Img.image=[UIImage imageNamed:@""];
                    [cell8.add3Button addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell8.add3Button.tag=indexPath.row;cell8.add3Button.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld4%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld4%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell8.add3Button sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell8.add3Button setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell8.add3Button sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell8.add3Button setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                            
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld4%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld4%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell8.center3Img.image=[UIImage imageNamed:@"zanting"];
                    [cell8.add3Button addTarget:self action:@selector(Cell8Add3Button:) forControlEvents:UIControlEventTouchUpInside];
                    cell8.add3Button.tag=indexPath.row;cell8.add3Button.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld4%@video",indexPath.row+1,self.ScrapbookId];
                    
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
            }
            return cell8;
        }
        else if ([currentString isEqualToString:@"Module_4_1"]){
            NSDictionary *dic;
            NSDictionary *dic1;
            YSenvenCell *cell7 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid7" forIndexPath:indexPath];
            NSString * tag=@"7";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[6];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell7.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell7.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
        
            dic=paraArr[1];
            
            
            if (dic.count<4) {
               dic=paraArr[0];
            }else{
               dic=paraArr[1];
            }
            if (dic.count>2) {
                cell7.bottomLabel.text=dic[@"Text"];
                cell7.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
                cell7.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
                if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                    cell7.bottomLabel.textAlignment=NSTextAlignmentCenter;
                }
                else if ([dic[@"TextAlign"] isEqualToString:@"Left"]) {
                    cell7.bottomLabel.textAlignment=NSTextAlignmentLeft;
                }else{
                    cell7.bottomLabel.textAlignment=NSTextAlignmentRight;
                }
                
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                if (height>kWidth(15)) {
                    cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), height);
                    cell7.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), height);
                }else{
                    cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), kWidth(15));
                    cell7.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kWidth(15));
                }
                
                
                
            }
            
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
            //        添加图片按钮的操作
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                dic1=paraArr[0];
                if (dic1.count<5) {
                     dic1=paraArr[0];
                }else{
                     dic1=paraArr[1];
                }
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell7.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell7.centerImg.image=[UIImage imageNamed:@""];
                    [cell7.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell7.addButton.tag=indexPath.row;cell7.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell7.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell7.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell7.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell7.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                            
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell7.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell7.addButton addTarget:self action:@selector(Cell7AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell7.addButton.tag=indexPath.row;cell7.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    
                    [self setValueName:dic1 withKey:textIndex1];
                }
            }
            
            
            return cell7;
        }
        else if ([currentString isEqualToString:@"Module_5_1"])
        {
            
            YNineCell *cell9 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid9" forIndexPath:indexPath];
            NSString * tag=@"9";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[8];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell9.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell9.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            cell9.addButton.tag=indexPath.row;
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell9.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell9.centerImg.image=[UIImage imageNamed:@""];
                    [cell9.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell9.addButton.tag=indexPath.row;cell9.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell9.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell9.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell9.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell9.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                            
                           
                        }
                        
                    }
                    
                    
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell9.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell9.addButton addTarget:self action:@selector(Cell9AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell9.addButton.tag=indexPath.row;
                    cell9.addButton.userInteractionEnabled=YES;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                    
                    
                }
                
                
            }
            
            return cell9;
        }
        else
        {
            
            YTenCell *cell10 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid10" forIndexPath:indexPath];
            NSString * tag=@"10";
            if ([currentCell isEqualToString:tag]) {
                if (self.player) {
                    [self.player destroyPlayer];
                    self->_player = nil;
                }
            }
            NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[9];
            NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
            if ([self objectValueWith:string111]) {
                NSLog(@"you");
                
                UIImage *image = [UIImage imageWithData:[self objectValueWith:string111]];
                cell10.bgImage.image=image;
            }else{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string111]]; //得到图像数据
                UIImage *image = [UIImage imageWithData:imgData];
                cell10.bgImage.image=image;
                [self setValueName:imgData withKey:string111];
            }
            
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSDictionary *dic=paraArr[1];
            
            if (dic.count>2) {
                cell10.bottomLabel.text=dic[@"Text"];
                cell10.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
                cell10.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
                if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                    cell10.bottomLabel.textAlignment=NSTextAlignmentCenter;
                }
                else if ([dic[@"TextAlign"] isEqualToString:@"Left"]) {
                    cell10.bottomLabel.textAlignment=NSTextAlignmentLeft;
                }else{
                    cell10.bottomLabel.textAlignment=NSTextAlignmentRight;
                }
                
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                if (height>kWidth(32)) {
                    cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280), height);
                    cell10.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), height);
                }else{
                    cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280),kWidth(32));
                    cell10.bottomLabel.frame=CGRectMake(0, 0, kWidth(280),kWidth(32));
                }
                
                
                
            }
            
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
            //        添加图片按钮的操作
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell10.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell10.centerImg.image=[UIImage imageNamed:@""];
                    [cell10.addButton addTarget:self action:@selector(lflButton) forControlEvents:UIControlEventTouchUpInside];
                    cell10.addButton.tag=indexPath.row;cell10.addButton.userInteractionEnabled=NO;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSDictionary * wDic1=[self objectValueWith:wtextIndex1];
                    NSString * vstring=wDic1[@"image"];
                    
                    if (vstring.length>9) {
                        if ([vstring isKindOfClass:[NSString class]]) {
                            [cell10.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:vstring] forState:UIControlStateNormal];
                        }else{
                            UIImage *image=[UIImage imageWithData:wDic1[@"image"]];
                            [cell10.addButton setBackgroundImage:image forState:UIControlStateNormal];
                        }
                        
                    }else{
                        NSString * Vstring=[NSString stringWithFormat:@"%@",dic1[@"VideoPictureURL"]];
                        [cell10.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:Vstring] forState:UIControlStateNormal];
                        NSDictionary * dataDic=@{@"image":Vstring};
                        [self setValueName:dataDic withKey:wtextIndex1];
                        
                        if (Vstring.length<9) {
                            NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                            UIImage * video=[UIImage videoImageWithvideoURL:[NSURL URLWithString:string] atTime:1];
                            [cell10.addButton setBackgroundImage:video forState:UIControlStateNormal];
                            NSData *imageData = UIImagePNGRepresentation(video);
                            NSDictionary * IdataDic=@{@"image":imageData};
                            [self setValueName:IdataDic withKey:wtextIndex1];
                            
                            
                        }
                        
                    }
                    NSString*gifString=[NSString stringWithFormat:@"%@",dic1[@"GifURL"]];
                    if ([gifString containsString:@"https"]) {
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":gifString};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }else{
                        NSString *zuiIndex2=[NSString stringWithFormat:@"%ld1%@gif123",indexPath.row+1,self.ScrapbookId];
                        NSDictionary * gifDic=@{@"gifString":dic1[@"VideoURL"]};
                        [self setValueName:gifDic withKey:zuiIndex2];
                    }
                    cell10.centerImg.image=[UIImage imageNamed:@"zanting"];
                    [cell10.addButton addTarget:self action:@selector(Cell10AddButton:) forControlEvents:UIControlEventTouchUpInside];
                    cell10.addButton.tag=indexPath.row;
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    cell10.addButton.userInteractionEnabled=YES;
                    [self setValueName:dic1 withKey:textIndex1];
                }
            }
            
            
            return cell10;
        }
    }
    else if(indexPath.section==1){
        CommentCollectionViewCell *comment = [collectionView dequeueReusableCellWithReuseIdentifier:@"comment" forIndexPath:indexPath];
        if (ScrapbookList.count>0) {
            NSString * Comments=[NSString stringWithFormat:@"%@",ScrapbookList[@"Comments"]];
            NSString * Likes=[NSString stringWithFormat:@"%@",ScrapbookList[@"Likes"]];
            NSString * Views=[NSString stringWithFormat:@"%@",ScrapbookList[@"Views"]];
            NSString * IsLike=[NSString stringWithFormat:@"%@",ScrapbookList[@"IsLike"]];
            if ([IsLike isEqualToString:@"FALSE"]) {
                comment.likeImg.image=[UIImage imageNamed:@"zan"];
                [comment.nameButton addTarget:self action:@selector(zanButton:) forControlEvents:UIControlEventTouchUpInside];
                comment.nameButton.tag=123;
            }else{
                comment.likeImg.image=[UIImage imageNamed:@"zaned"];
                [comment.nameButton addTarget:self action:@selector(zanButton:) forControlEvents:UIControlEventTouchUpInside];
                comment.nameButton.tag=321;
            }
            [comment.name1Button addTarget:self action:@selector(name1ButtonClick) forControlEvents:UIControlEventTouchUpInside];
            comment.likeLab.text=Likes;
            comment.lookLab.text=Views;
            comment.commentLab.text=Comments;
        }

        
//        UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, (comment.frame.size.height) * (indexPath.row+1), comment.width, 1)];
//        horizontalLine.backgroundColor = [UIColor lightGrayColor];
//        horizontalLine.alpha = 0.35;
//        [comment addSubview:horizontalLine];
        
        return comment;
    }
    else
    {
        
        
        if (indexPath.row==0) {
            NSArray * arr=ScrapbookList[@"CommentList"];
            NSDictionary *dic=arr[indexPath.section-2];
            ReplysArr=dic[@"Replys"];
            
            Comment1CollectionViewCell *comment = [collectionView dequeueReusableCellWithReuseIdentifier:@"comment1" forIndexPath:indexPath];
            
               
            
            
            NSString *time=[NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
            NSString *nickName=[NSString stringWithFormat:@"%@",dic[@"Nickname"]];
            NSString *userId=[NSString stringWithFormat:@"%@",dic[@"UserId"]];
            NSString *IsOwner=[NSString stringWithFormat:@"%@",dic[@"IsOwner"]];
            
            if ([nickName isEmptyString]&&[userId isEmptyString]) {
                if ([IsOwner isEqualToString:@"TRUE"]) {
                    comment.nameLabel.text=@"作者：匿名用户";
                }else{
                    comment.nameLabel.text=@"匿名用户";
                }
                
                comment.bgImage.image=[UIImage imageNamed:@"xiaoxiongtou"];
            }
            else if ([nickName isEmptyString]&&![userId isEmptyString]) {
                if ([IsOwner isEqualToString:@"TRUE"]) {
                    comment.nameLabel.text=@"作者：纷呈用户";
                }else{
                    comment.nameLabel.text=@"纷呈用户";
                }
                
                comment.bgImage.image=[UIImage imageNamed:@"logo"];
            }else{
                if ([IsOwner isEqualToString:@"TRUE"]) {
                    comment.nameLabel.text=[NSString stringWithFormat:@"作者：%@",nickName];
                }else{
                    comment.nameLabel.text=nickName;
                }
                
                [comment.bgImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"Photo_Small"]]] placeholderImage:[UIImage imageNamed:@""]];
            }
            
            comment.commentLabel.text=[NSString stringWithFormat:@"%@",dic[@"Content"]];
            comment.dayLabel.text=[NSString converStrToDate1:time];
            comment.likeLabel.text=[NSString stringWithFormat:@"%@",dic[@"Likes"]];
            
            NSString * IsLike=[NSString stringWithFormat:@"%@",dic[@"IsLike"]];
            
            NSString * Status=[NSString stringWithFormat:@"%@",dic[@"Status"]];
            if ([IsLike isEqualToString:@"FALSE"]) {
                [comment.likeButton setBackgroundImage:[UIImage imageNamed:@"点赞lfl"] forState:UIControlStateNormal];

            }else{
                [comment.likeButton setBackgroundImage:[UIImage imageNamed:@"zaned"] forState:UIControlStateNormal];
            }
            [comment.likeButton addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
            comment.likeButton.tag=indexPath.section-2;
            if ([Status isEqualToString:@"PT"]) {
                [comment.collectionButton setBackgroundImage:[UIImage imageNamed:@"精选lfl"] forState:UIControlStateNormal];
              
            }else{
                [comment.collectionButton setBackgroundImage:[UIImage imageNamed:@"精选1lfl"] forState:UIControlStateNormal];
              
            }
            
            [comment.collectionButton addTarget:self action:@selector(collectionClick:) forControlEvents:UIControlEventTouchUpInside];
            comment.collectionButton.tag=indexPath.section-2;
            
            [comment.commentButton addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
            comment.commentButton.tag=indexPath.section-2;
            
            [comment.deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
            comment.deleteButton.tag=indexPath.section-2;
            return comment;
            
            
        }
        else
        {
            NSArray * arr=ScrapbookList[@"CommentList"];
            NSDictionary *lfldic=arr[indexPath.section-2];
            ReplysArr=lfldic[@"Replys"];
            NSDictionary *dic=ReplysArr[indexPath.row-1];
            Comment2CollectionViewCell *comment = [collectionView dequeueReusableCellWithReuseIdentifier:@"comment2" forIndexPath:indexPath];

            NSString *time=[NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
            
            NSString *nickName=[NSString stringWithFormat:@"%@",dic[@"Nickname"]];
            NSString *userId=[NSString stringWithFormat:@"%@",dic[@"UserId"]];
            NSString *IsOwner=[NSString stringWithFormat:@"%@",dic[@"IsOwner"]];
            
            if ([nickName isEmptyString]&&[userId isEmptyString]) {
                if ([IsOwner isEqualToString:@"TRUE"]) {
                    comment.nameLabel.text=@"作者：匿名用户";
                }else{
                    comment.nameLabel.text=@"匿名用户";
                }
            }
            else if ([nickName isEmptyString]&&![userId isEmptyString]) {
                if ([IsOwner isEqualToString:@"TRUE"]) {
                    comment.nameLabel.text=@"作者：纷呈用户";
                }else{
                    comment.nameLabel.text=@"纷呈用户";
                }
            }else{
                if ([IsOwner isEqualToString:@"TRUE"]) {
                    comment.nameLabel.text=[NSString stringWithFormat:@"作者：%@",nickName];
                }else{
                    comment.nameLabel.text=nickName;
                }
            }
            
            comment.commentLabel.text=[NSString stringWithFormat:@"%@",dic[@"Content"]];
            comment.dayLabel.text=[NSString converStrToDate1:time];
            comment.likeLabel.text=[NSString stringWithFormat:@"%@",dic[@"Likes"]];
            NSString * IsLike=[NSString stringWithFormat:@"%@",dic[@"IsLike"]];
            if ([IsLike isEqualToString:@"FALSE"]) {
                [comment.likeButton setBackgroundImage:[UIImage imageNamed:@"点赞lfl"] forState:UIControlStateNormal];
                
            }else{
                [comment.likeButton setBackgroundImage:[UIImage imageNamed:@"zaned"] forState:UIControlStateNormal];
            }
            
            [comment.likeButton addTarget:self action:@selector(RlikeClick:) forControlEvents:UIControlEventTouchUpInside];
            comment.likeButton.tag=indexPath.section-2;
            
            [comment.deleteButton addTarget:self action:@selector(RdeleteClick:) forControlEvents:UIControlEventTouchUpInside];
            comment.deleteButton.tag=indexPath.section-2;
            return comment;
        
        
    }
    }
    }

#pragma 点赞呈记
-(void)zanButton:(UIButton*)sender{
    sender.enabled=NO;
    NSString * islike=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSString * like;
    if ([islike isEqualToString:@"123"]) {
        like=@"TRUE";
    }else{
       like=@"FALSE";
    }
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"ScrapbookId":_ScrapbookId,@"IsLike":like};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"ScrapbookId":_ScrapbookId,@"IsLike":like};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:changeScrapbookLike WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {

            [self loadData];
            sender.enabled=YES;
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
-(void)name1ButtonClick{
    NSLog(@"自己评论");
    ToCommentId=@"";
    _BgView.hidden=NO;
    [_textView becomeFirstResponder];
    _background2 = [[UIView alloc]init];
    _background2.frame =CGRectMake(0,0,APP_SCREEN_WIDTH,359);
    _background2.backgroundColor = [UIColor whiteColor];
    _background2.alpha=0.1;
    _background2.hidden=NO;
    [self.navigationController.view addSubview:_background2];
    tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
    tap2.numberOfTapsRequired=1;
    [self.background2 addGestureRecognizer:tap2];
    
}
#pragma 点击评论四个按钮
-(void)collectionClick:(UIButton*)sender{
    sender.enabled=NO;
    NSArray * arr=ScrapbookList[@"CommentList"];
    NSDictionary *lfldic=arr[sender.tag];
    NSString * like=[NSString stringWithFormat:@"%@",lfldic[@"Status"]];
  
    if ([like isEqualToString:@"JP"]) {
        like=@"PT";
    }else{
        like=@"JP";
    }
      NSLog(@"收藏--%@",like);
    NSString * CommentId=[NSString stringWithFormat:@"%@",lfldic[@"CommentId"]];
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"CommentId":CommentId,@"Status":like};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"CommentId":CommentId,@"Status":like};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:changeCommentStatus WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"收藏%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            
            [self loadData];
            sender.enabled=YES;
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
-(void)likeClick:(UIButton*)sender{
    sender.enabled=NO;
    NSArray * arr=ScrapbookList[@"CommentList"];
    NSDictionary *lfldic=arr[sender.tag];
    NSString * like=[NSString stringWithFormat:@"%@",lfldic[@"IsLike"]];
    NSLog(@"喜欢--%@",like);
    if ([like isEqualToString:@"TRUE"]) {
        like=@"FALSE";
    }else{
       like=@"TRUE";
    }
    NSString * CommentId=[NSString stringWithFormat:@"%@",lfldic[@"CommentId"]];
   
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"CommentId":CommentId,@"IsLike":like};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"CommentId":CommentId,@"IsLike":like};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:changeCommentLike WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"喜欢%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            
            [self loadData];
            sender.enabled=YES;
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
-(void)RlikeClick:(UIButton*)sender{
    sender.enabled=NO;
    UIView *contentView = [sender superview];
    Comment2CollectionViewCell *cell = (Comment2CollectionViewCell *)[contentView superview];
    NSIndexPath * index=[self.DataCollectionView indexPathForCell:cell];
    

    NSArray * arr=ScrapbookList[@"CommentList"];
    NSDictionary *lfldic=arr[sender.tag];
    
    NSArray * arr1=lfldic[@"Replys"];
    NSDictionary *diclfl=arr1[index.row-1];
    NSString * like=[NSString stringWithFormat:@"%@",diclfl[@"IsLike"]];

    NSLog(@"喜欢--%@",like);
    if ([like isEqualToString:@"TRUE"]) {
        like=@"FALSE";
    }else{
        like=@"TRUE";
    }
    NSString * CommentId=[NSString stringWithFormat:@"%@",diclfl[@"CommentId"]];
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"CommentId":CommentId,@"IsLike":like};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"CommentId":CommentId,@"IsLike":like};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:changeCommentLike WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"喜欢%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            
            [self loadData];
            sender.enabled=YES;
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

-(void)commentClick:(UIButton*)sender{
    NSLog(@"回复评论");
    NSArray * arr=ScrapbookList[@"CommentList"];
    NSDictionary *lfldic=arr[sender.tag];
    NSString * CommentId=[NSString stringWithFormat:@"%@",lfldic[@"CommentId"]];
     ToCommentId=CommentId;
    _BgView.hidden=NO;
    [_textView becomeFirstResponder];
    _background2 = [[UIView alloc]init];
    _background2.frame =CGRectMake(0,0,APP_SCREEN_WIDTH,359);
    _background2.backgroundColor = [UIColor whiteColor];
    _background2.alpha=0.1;
    _background2.hidden=NO;
    [self.navigationController.view addSubview:_background2];
    tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
    tap2.numberOfTapsRequired=1;
    [self.background2 addGestureRecognizer:tap2];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        NSLog(@"text==%@",textView.text);
        if (textView.text.length<1) {
            [self showMessage:@"评论不能为空"];
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self lflcommentClick:textView.text];
                [self.view endEditing:YES];
            });
            
        }
        
        return NO;
    }
    
    return YES;
}

-(void)lflcommentClick:(NSString*)text{
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
//    NSDictionary *dic;
    NSDictionary * param;
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    if ([ToCommentId isEqualToString:@""]) {
        NSDictionary *dic=@{@"AccessToken":AccessToken,@"ScrapbookId":_ScrapbookId,@"Content":text};
        
        NSString *string= [self createSign:dic];
        
        param=@{@"Sign":string,@"ScrapbookId":_ScrapbookId,@"Content":text};
    }else{
        NSDictionary *dic=@{@"AccessToken":AccessToken,@"ScrapbookId":_ScrapbookId,@"Content":text,@"ToCommentId":ToCommentId};
        
        NSString *string= [self createSign:dic];
        
        param=@{@"Sign":string,@"ScrapbookId":_ScrapbookId,@"Content":text,@"ToCommentId":ToCommentId};
    }
   
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:addScrapbookComment WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            [self loadData];
            [self.view endEditing:YES];
            [self.background2 removeFromSuperview];
            
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
#pragma keyBord
- (void)keyboardWillShow:(NSNotification *)aNotification {
    
    NSDictionary *userInfo = aNotification.userInfo;
    
    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue fromView:nil];  // 键盘的frame
    NSLog(@"--%f--%f--%f--%f",keyboardEndFrame.origin.x,keyboardEndFrame.origin.y,keyboardEndFrame.size.width,keyboardEndFrame.size.height);
    
    // 接下拉可以在动画内来改变界面的布局，布局会随着键盘弹出，平滑的过度
    
    [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         self->_BgView.frame=CGRectMake(0, keyboardEndFrame.origin.y-50, keyboardEndFrame.size.width, 50);
         self->_background2.frame =CGRectMake(0,0,APP_SCREEN_WIDTH,keyboardEndFrame.origin.y-50);
         
     }
                     completion:nil];
    
}



- (void)keyboardWillHide:(NSNotification *)aNotification {
    NSDictionary *userInfo = aNotification.userInfo;
    
    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardEndFrame = [self.view convertRect:endFrameValue.CGRectValue fromView:nil];  // 键盘的frame
    NSLog(@"--%f--%f--%f--%f",keyboardEndFrame.origin.x,keyboardEndFrame.origin.y,keyboardEndFrame.size.width,keyboardEndFrame.size.height);
    [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self->_BgView.hidden=YES;
        self->_textView.text=@"";
        
    } completion:nil];
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    placeHolderLabel.text=@"";
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textView.text.length==0) {
        placeHolderLabel.text=@"我觉得...";
    }else{
        placeHolderLabel.text=@"";
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)deleteClick:(UIButton*)sender{
    NSLog(@"删除");
   
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            sender.enabled=NO;
            NSArray * arr=self->ScrapbookList[@"CommentList"];
            NSDictionary *lfldic=arr[sender.tag];
            NSString * CommentId=[NSString stringWithFormat:@"%@",lfldic[@"CommentId"]];
            NSString * like=@"YSC";
            
            NSString *AccessToken= [self objectValueWith:@"AccessToken"];
            
            if (AccessToken.length<1) {
                AccessToken=@"12123456789878765453423456789876";
            }
            NSDictionary *dic=@{@"AccessToken":AccessToken,@"CommentId":CommentId,@"Status":like};
            
            NSString *string= [self createSign:dic];
            
            NSDictionary *param=@{@"Sign":string,@"CommentId":CommentId,@"Status":like};
            [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:changeCommentStatus WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
                NSLog(@"删除%@",obj);
                NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
                if ([msgStr isEqualToString:@"1"])
                {
                    
                    [self loadData];
                    sender.enabled=YES;
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
            
            
            
        }];
        UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
        }];
        [alertController addAction:confirm];
        [alertController addAction:cance];
        [self presentViewController:alertController animated:YES completion:nil];
    
    
}
-(void)RdeleteClick:(UIButton*)sender{
    NSLog(@"删除");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        sender.enabled=NO;
        UIView *contentView = [sender superview];
        Comment2CollectionViewCell *cell = (Comment2CollectionViewCell *)[contentView superview];
        NSIndexPath * index=[self.DataCollectionView indexPathForCell:cell];
        
        
        NSArray * arr=ScrapbookList[@"CommentList"];
        NSDictionary *lfldic=arr[sender.tag];
        
        NSArray * arr1=lfldic[@"Replys"];
        NSDictionary *diclfl=arr1[index.row-1];
        
        
        NSString * CommentId=[NSString stringWithFormat:@"%@",diclfl[@"CommentId"]];
        NSString * like=@"YSC";
        
        NSString *AccessToken= [self objectValueWith:@"AccessToken"];
        
        if (AccessToken.length<1) {
            AccessToken=@"12123456789878765453423456789876";
        }
        NSDictionary *dic=@{@"AccessToken":AccessToken,@"CommentId":CommentId,@"Status":like};
        
        NSString *string= [self createSign:dic];
        
        NSDictionary *param=@{@"Sign":string,@"CommentId":CommentId,@"Status":like};
        [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:changeCommentStatus WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
            NSLog(@"删除%@",obj);
            NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
            if ([msgStr isEqualToString:@"1"])
            {
                
                [self loadData];
                sender.enabled=YES;
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
        
        
        
    }];
    UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirm];
    [alertController addAction:cance];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma 点击添加图片按钮
-(void)Cell2AddButton:(UIButton*)sender{
    NSLog(@"cell2=1=%ld",(long)sender.tag);
    currentCell=@"2";
   
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[0];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YTwoCell *cell = (YTwoCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame =cell.addButton.frame;
    [cell addSubview:_player];
    
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
    
}
-(void)Cell3AddButton:(UIButton*)sender
{
    currentCell=@"3";
    NSLog(@"cell3=1=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[1];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    
//    NSSet *touches = [event allTouches];
//    UITouch *touch = [touches anyObject];
//    CGPoint position = [touch locationInView:self.DataCollectionView];
//
//    NSIndexPath *indexPath = [self.DataCollectionView indexPathForItemAtPoint:position];
//    YThreeCell *cell = (YThreeCell*)[self.DataCollectionView cellForItemAtIndexPath:indexPath];
    
    
    UIView *contentView = [sender superview];
    YThreeCell *cell = (YThreeCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame =cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
   
}
-(void)Cell3Add1Button:(UIButton*)sender{
    currentCell=@"3";
    NSLog(@"cell3=2=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[2];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YThreeCell *cell = (YThreeCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.add1Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell4AddButton:(UIButton*)sender{
    currentCell=@"4";
    NSLog(@"cell4=1=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[1];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YFourCell *cell = (YFourCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell5AddButton:(UIButton*)sender{
    currentCell=@"5";
    NSLog(@"cell5=2=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[1];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YFiveCell *cell = (YFiveCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell5Add1Button:(UIButton*)sender{
    currentCell=@"5";
    NSLog(@"cell5=2=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[2];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YFiveCell *cell = (YFiveCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame =cell.add1Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell5Add2Button:(UIButton*)sender{
    currentCell=@"5";
    NSLog(@"cell5=3=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[3];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YFiveCell *cell = (YFiveCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.add2Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell6AddButton:(UIButton*)sender{
    currentCell=@"6";
    NSLog(@"cell6=1=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[0];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YSixCell *cell = (YSixCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell6Add1Button:(UIButton*)sender{
    currentCell=@"6";
    NSLog(@"cell6=2=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[1];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YSixCell *cell = (YSixCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.add1Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell6Add2Button:(UIButton*)sender{
    currentCell=@"6";
    NSLog(@"cell6=3=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[2];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YSixCell *cell = (YSixCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.add2Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell8AddButton:(UIButton*)sender{
    NSLog(@"cell8=1=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    currentCell=@"8";
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[0];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YEightCell *cell = (YEightCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell8Add1Button:(UIButton*)sender{
    NSLog(@"cell8=2=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    currentCell=@"8";
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[1];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YEightCell *cell = (YEightCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.add1Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell8Add2Button:(UIButton*)sender{
    NSLog(@"cell8=3=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    currentCell=@"8";
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[2];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YEightCell *cell = (YEightCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.add2Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell8Add3Button:(UIButton*)sender{
    NSLog(@"cell8=4=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    currentCell=@"8";
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[3];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YEightCell *cell = (YEightCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.add3Button.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell7AddButton:(UIButton*)sender{
    NSLog(@"cell7=1=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    currentCell=@"7";
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[0];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YSenvenCell *cell = (YSenvenCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell9AddButton:(UIButton*)sender{
    NSLog(@"cell9=1=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    currentCell=@"9";
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    NSDictionary *dic1=paraArr[0];
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YNineCell *cell = (YNineCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame = cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
-(void)Cell10AddButton:(UIButton*)sender{
    NSLog(@"cell10=1=%ld",(long)sender.tag);
    if (self.player) {
        [self.player destroyPlayer];
        self->_player = nil;
    }
    currentCell=@"10";
    NSDictionary *DetailDic=ModulesArr[sender.tag+1];
    NSArray * paraArr=DetailDic[@"Parameters"];
    
    NSDictionary *dic1=paraArr[0];
    if (dic1.count>5) {
        dic1=paraArr[1];
    }else{
        dic1=paraArr[0];
    }
    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
    UIView *contentView = [sender superview];
    YTenCell *cell = (YTenCell *)[contentView superview];
    _player= [[LFLVideoPlayer alloc] init];
    _player.videoUrl = string;
    _player.frame =cell.addButton.frame;
    [cell addSubview:_player];
    _player.completedPlayingBlock = ^(LFLVideoPlayer *player) {
        [player destroyPlayer];
        self->_player = nil;
    };
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//item之间的空隙为0
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 1.定义重用标识
        static NSString *ID;
        
        if (indexPath.section == 0) {
            ID = @"header";
        } else {
            ID = @"header1";
        }
        
        UICollectionReusableView* reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ID forIndexPath:indexPath];
        if (indexPath.section==0) {
            if (headerButton) {
                [headerButton removeFromSuperview];
                headerButton=nil;
            }
            headerButton=[UIButton buttonWithType:UIButtonTypeCustom];
            headerButton.frame=CGRectMake(0, 0, self.view.bounds.size.width, kheigh(167));
            [headerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            UILabel *label=[[UILabel alloc]init];
            label.frame=CGRectMake(kWidth(20), kheigh(167)-kheigh(57), APP_SCREEN_WIDTH-2*kWidth(20), kheigh(24));
            label.numberOfLines=0;
            if (ModulesArr.count>1) {
                NSDictionary *dic=ModulesArr[0];
                NSArray *paraArr=dic[@"Parameters"];
                if (paraArr.count==2) {
                    NSDictionary *dic1=paraArr[0];
                    
                    label.text=dic1[@"Text"];
                    label.font=[UIFont systemFontOfSize:[dic1[@"Text"]intValue]];
                    label.textColor=UIColorFromHex([dic1[@"Color"] intValue]);
                    label.font=[UIFont fontWithName:dic1[@"FontFamily"] size:[dic1[@"FontSize"] intValue]];
                    if ([dic1[@"TextAlign"] isEqualToString:@"Center"]) {
                        label.textAlignment=NSTextAlignmentCenter;
                    }
                    else if ([dic1[@"TextAlign"] isEqualToString:@"Left"]) {
                        label.textAlignment=NSTextAlignmentLeft;
                    }else{
                        label.textAlignment=NSTextAlignmentRight;
                    }
                    [self setValueName:dic1 withKey:[NSString stringWithFormat:@"%@headerText",self.ScrapbookId]];
                    
                    NSDictionary *dic2=paraArr[1];
                    NSString *url=dic2[@"PictureURL"];
                    if ([self objectValueWith:url]) {
                        NSLog(@"you");
                        
                        UIImage *image = [UIImage imageWithData:[self objectValueWith:url]];
                        [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                        
                    }else{
                        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]; //得到图像数据
                        UIImage *image = [UIImage imageWithData:imgData];
                        [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                        [self setValueName:imgData withKey:url];
                        imgData=nil;
                        image=nil;
                       
                        
                    }
                    [self setValueName:@{@"image":url,@"type":@"1"} withKey:[NSString stringWithFormat:@"%@imageheader",self.ScrapbookId]];
                }
                else
                {
                    
                    NSDictionary *dic1=paraArr[0];
                    
                    label.text=dic1[@"Text"];
                    label.font=[UIFont systemFontOfSize:[dic1[@"Text"]intValue]];
                    label.textColor=UIColorFromHex([dic1[@"Color"] intValue]);
                    label.font=[UIFont fontWithName:dic1[@"FontFamily"] size:[dic1[@"FontSize"] intValue]];
                    if ([dic1[@"TextAlign"] isEqualToString:@"Center"]) {
                        label.textAlignment=NSTextAlignmentCenter;
                    }
                    else if ([dic1[@"TextAlign"] isEqualToString:@"Left"]) {
                        label.textAlignment=NSTextAlignmentLeft;
                    }else{
                        label.textAlignment=NSTextAlignmentRight;
                    }
                    [self setValueName:dic1 withKey:[NSString stringWithFormat:@"%@headerText",self.ScrapbookId]];
                    
                    NSArray *lfla=[FCAppInfo shareManager].huabanArr;
                    NSDictionary *dic2=lfla[11];
                    NSString *url=dic2[@"BackgroundImage"];
                    if ([self objectValueWith:url]) {
                        NSLog(@"you");
                        
                        UIImage *image = [UIImage imageWithData:[self objectValueWith:url]];
                        [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                        
                    }else{
                        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]; //得到图像数据
                        UIImage *image = [UIImage imageWithData:imgData];
                        [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                        [self setValueName:imgData withKey:url];
                        imgData=nil;
                        image=nil;
                       
                        
                    }
                }
                
            }
            [reusableView addSubview:headerButton];
            [headerButton addSubview:label];
            return reusableView;
        }
        else if(indexPath.section==1)
        {
            UILabel *label=[[UILabel alloc]init];
            label.backgroundColor=UIColorFromHex(0xeeeeee);
            label.frame=CGRectMake(0, 0, SCREEN_WIDTH, 1);
            [reusableView addSubview:label];
            return reusableView;
        }
        else
        {
            UILabel *label=[[UILabel alloc]init];
            label.backgroundColor=UIColorFromHex(0xeeeeee);
            label.frame=CGRectMake(0, 0, SCREEN_WIDTH, 1);
            [reusableView addSubview:label];
            return reusableView;
        }
        
    }else{
        // 1.定义重用标识
        static NSString *ID;
        
        if (indexPath.section == 0) {
            ID = @"footer";
        } else {
            ID = @"footer1";
        }
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ID forIndexPath:indexPath];
        if (indexPath.section==0)
        {
            NSDictionary *dic=[FCAppInfo shareManager].huabanArr[10];
            NSString *string=[NSString stringWithFormat:@"%@",dic[@"BackgroundImage"]];
            if (button) {
                NSLog(@"存在");
                if ([self objectValueWith:string]) {
                    NSLog(@"you");
                    
                    UIImage *image = [UIImage imageWithData:[self objectValueWith:string]];
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                }else{
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]]; //得到图像数据
                    UIImage *image = [UIImage imageWithData:imgData];
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                    [self setValueName:imgData withKey:string];
                    imgData=nil;
                    image=nil;
                    string=nil;
                }
            }else{
                NSLog(@"不存在");
                button=[UIButton buttonWithType:UIButtonTypeCustom];
                button.frame=CGRectMake(0, 0, self.view.bounds.size.width, 60);
                if ([self objectValueWith:string]) {
                    NSLog(@"you");
                    
                    UIImage *image = [UIImage imageWithData:[self objectValueWith:string]];
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                }else{
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]]; //得到图像数据
                    UIImage *image = [UIImage imageWithData:imgData];
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                    [self setValueName:imgData withKey:string];
                    imgData=nil;
                    image=nil;
                    string=nil;
                }
            }
            
            [footerView addSubview:button];
            
            UILabel *label=[[UILabel alloc]init];
            label.backgroundColor=UIColorFromHex(0xf2f2f2);
            label.frame=CGRectMake(0, 60, SCREEN_WIDTH, 10);
            [footerView addSubview:label];
            
            return footerView;
        }else{
            return footerView;
        }
        
        
    }
}
    

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if ([wancheng isEqualToString:@"1"])
        {
            return CGSizeMake(APP_SCREEN_WIDTH, 1);
        }
        else
        {
            NSString * currentString=ModuleIdArr[indexPath.row];
            NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
            if ([currentString isEqualToString:@"Module_1_1"]) {
                
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                NSDictionary *dic=[stand objectForKey:textIndex];
                
                if (dic.count>2)
                {
                    
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
//                    if (height>kheigh(58)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(80)+height-kheigh(58));
//                    }else{
//                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(80));
//                    }
                    
                    
                }else
                {
                    NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                    NSArray * paraArr=DetailDic[@"Parameters"];
                    NSDictionary *dic=paraArr[0];
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
//                    if (height>kheigh(58)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(80)+height-kheigh(58));
//                    }else{
//                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(80));
//                    }
                }
                
            }
            else if([currentString isEqualToString:@"Module_1_2"]){
                
                
                return CGSizeMake(APP_SCREEN_WIDTH, kheigh(217));
            }
            else if([currentString isEqualToString:@"Module_2_1"])
            {
                UIImage *image=[UIImage imageNamed:@"byj3"];
                return CGSizeMake(APP_SCREEN_WIDTH, kheigh(211));
            }
            else if([currentString isEqualToString:@"Module_2_2"]){
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                NSDictionary *dic=[stand objectForKey:textIndex];
                
                if (dic.count>2)
                {
                    
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    
                    if (height>kheigh(31)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(263)+height-kheigh(31));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(263)-height+kheigh(31));
                    }
                    
                }else
                {
                    //文字展示
                    NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                    NSArray * paraArr=DetailDic[@"Parameters"];
                    NSDictionary *dic=paraArr[0];
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    
                    if (height>kheigh(31)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(263)+height-kheigh(31));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(263)-height+kheigh(31));
                    }
                }
            }
            else if([currentString isEqualToString:@"Module_3_1"]){
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                NSDictionary *dic=[stand objectForKey:textIndex];
                
                if (dic.count>2)
                {
                    
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    
                    if (height>kheigh(15)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(180)+height-kheigh(15));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(180)-height+kheigh(15));
                    }
                }else
                {
                    //文字展示
                    NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                    NSArray * paraArr=DetailDic[@"Parameters"];
                    NSDictionary *dic=paraArr[0];
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    
                    if (height>kheigh(15)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(180)+height-kheigh(15));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(180)-height+kheigh(15));
                    }
                }
            }
            else if([currentString isEqualToString:@"Module_3_2"]){
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                NSDictionary *dic=[stand objectForKey:textIndex];
                
                if (dic.count>2)
                {
                    
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    
                    if (height>kWidth(33)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(222)+height-kWidth(33));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(222)-height+kWidth(33));
                    }
                    
                }else
                {
                    //文字展示
                    NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                    NSArray * paraArr=DetailDic[@"Parameters"];
                    NSDictionary *dic=paraArr[3];
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    
                    if (height>kWidth(33)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(222)+height-kWidth(33));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(222)-height+kWidth(33));
                    }
                }
            }
            else if([currentString isEqualToString:@"Module_4_1"]){
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                NSDictionary *dic=[stand objectForKey:textIndex];
                
                if (dic.count>2)
                {
                    
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    if (height>kWidth(15)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)+height-kWidth(15));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)-height+kWidth(15));
                    }
                    
                }else
                {
                    //文字展示
                    NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                    NSArray * paraArr=DetailDic[@"Parameters"];
                    NSDictionary *dic=paraArr[1];
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
//                    if (height==0) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.DataCollectionView reloadData];
//                        });
//                    }
                    if (height>kWidth(15)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)+height-kWidth(15));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)-height+kWidth(15));
                    }
                    
                }
            }
            else if([currentString isEqualToString:@"Module_4_2"]) {
                //            UIImage *image=[UIImage imageNamed:@"byj8"];
                //            CGFloat width= CGImageGetWidth(image.CGImage);
                //            float bl=APP_SCREEN_WIDTH/width;
                //            CGFloat fixelH = CGImageGetHeight(image.CGImage);
                //            CGFloat zuihou=fixelH*bl;
                
                return CGSizeMake(APP_SCREEN_WIDTH, kheigh(219));
            }
            else if([currentString isEqualToString:@"Module_5_1"]) {
                //            UIImage *image=[UIImage imageNamed:@"byj8"];
                //            CGFloat width= CGImageGetWidth(image.CGImage);
                //            float bl=APP_SCREEN_WIDTH/width;
                //            CGFloat fixelH = CGImageGetHeight(image.CGImage);
                //            CGFloat zuihou=fixelH*bl;
                
                return CGSizeMake(APP_SCREEN_WIDTH, kheigh(326));
            }
            else
            {
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                NSDictionary *dic=[stand objectForKey:textIndex];
                
                if (dic.count>2)
                {
                    
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    if (height>kWidth(32)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(372)+height-kWidth(32));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(372)-height+kWidth(32));
                    }
                    
                }else
                {
                    NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                    NSArray * paraArr=DetailDic[@"Parameters"];
                    NSDictionary *dic=paraArr[1];
                    CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                    NSLog(@"height==%f",height);
                    if (height>kWidth(32)) {
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(372)+height-kWidth(32));
                    }else{
                        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(372)-height+kWidth(32));
                    }
                }
                
            }
        }
    }
    else if(indexPath.section==1)
        
        {
            return CGSizeMake(APP_SCREEN_WIDTH, 60);
        }
        else{
            if (indexPath.row==0) {
                return CGSizeMake(APP_SCREEN_WIDTH, 115);
            }else{
                return CGSizeMake(APP_SCREEN_WIDTH, 85);
            }
            
            
        }
    
    
    
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        if ([wancheng isEqualToString:@"1"]) {
            return CGSizeMake(APP_SCREEN_WIDTH, 1);
        }else{
            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(187));
        }
    }
    else if (section==1)
    {
        return CGSizeMake(APP_SCREEN_WIDTH, 1);
    }
    else
    {
        return CGSizeMake(APP_SCREEN_WIDTH,1);
    }
    
}
//尾部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==0) {
        if ([wancheng isEqualToString:@"1"]) {
            return CGSizeMake(APP_SCREEN_WIDTH, 1);
        }else{
            return CGSizeMake(APP_SCREEN_WIDTH, 70);
        }
    }else{
        return CGSizeMake(APP_SCREEN_WIDTH, 0);
    }
    
}
-(void)ButtonClick:(UIButton*)sender{
    
    NSString * string=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    if ([string isEqualToString:@"0"]) {
        
        FCTabBarViewController *hand=[[FCTabBarViewController alloc]init];
        hand.selectedIndex=1;
        UIWindow *window=[UIApplication sharedApplication].delegate.window;
        window.rootViewController=hand;
    }
    else{

        
    }
    
    
    
}


-(void)loadData{
//    if (ModuleIdArr.count>0) {
        [ModuleIdArr removeAllObjects];
//    }
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken,@"ScrapbookId":self.ScrapbookId};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"ScrapbookId":self.ScrapbookId};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:getScrapbookDetailByScrapbookId WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"obj==%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            
            NSDictionary *dic =[dataDic objectForKey:@"Scrapbook"];
            
            NSString *fontColor=[NSString stringWithFormat:@"%@",dic[@"BoxColor"]];
            NSString *font1Color=[NSString stringWithFormat:@"%@",dic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *fontDic=@{@"FontColor":font1Color,@"BoxColor":fontColor,@"BackgroundImage":[FCAppInfo shareManager].backgroundImage};
            [FCAppInfo shareManager].boxColor=[color1 intValue];
            
            [self setValueName:fontDic withKey:[NSString stringWithFormat:@"%@tlist",self.TemplateId]];
            self->ScrapbookList=dic;
            self->ModulesArr= [dic objectForKey:@"Modules"];
            for (NSDictionary * dic in self->ModulesArr) {
                NSString * ModuleId=dic[@"ModuleId"];
                if ([ModuleId isEqualToString:@"Module_header"]||[ModuleId isEqualToString:@"Module_footer"]) {
                    
                }else{
                    [self->ModuleIdArr addObject:ModuleId];
                }
                
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.DataCollectionView reloadData];
            });
            
           
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
    self.background.hidden=YES;
    self.pickerBgView.hidden=YES;
    
}
-(void)tap1:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
    self.background1.hidden=YES;
    self.pickerBgView1.hidden=YES;
    
}
- (UIImage*) getVideoPreViewImageWithPath:(NSURL *)videoPath
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    
    AVAssetImageGenerator *gen         = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time      = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error   = nil;
    
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img     = [[UIImage alloc] initWithCGImage:image];
    
    return img;
}
-(CGFloat)createHeightWithString:(NSString*)string withFont:(int)font{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};//指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.view.bounds.size.width+30, MAXFLOAT)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    CGRect rect1 = [[string substringToIndex:1] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width+30, MAXFLOAT)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    NSLog(@"size==%f==%f",rect1.size.height,rect.size.height);
    return rect.size.height+rect1.size.height;
}
-(BOOL )gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch* )touch{
    if (touch.view != self.DataCollectionView) {
        return NO;
    }
    
    return YES;
}
-(void)tap2:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
    _textView.text=@"";
     [self.background2 removeFromSuperview];
}
-(void)didload{
    [self loadData];
    self->wancheng=@"1";
    cengjiDetailViewController *detail=[[cengjiDetailViewController alloc]init];
    detail.TemplateId=self.TemplateId;
    [FCAppInfo shareManager].lflTemID=self.TemplateId;
    detail.ScrapbookId=self.ScrapbookId;
    detail.isFrom=@"cengjilfl";
    [self.DataCollectionView reloadData];
}
@end
