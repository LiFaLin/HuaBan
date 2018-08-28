//
//  DraftDetailViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/7/26.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "DraftDetailViewController.h"

#import "TakePhotoViewController.h"
#import "AlbumDetailsViewController.h"
#import "NewHBViewController.h"
#import "ChooseMViewController.h"
#import "ChooseBViewController.h"
#import "EditViewController.h"
#import "One1Cell.h"
#import "Two1Cell.h"
#import "Three1Cell.h"
#import "Four1Cell.h"
#import "Five1Cell.h"
#import "Six1Cell.h"
#import "Seven1Cell.h"
#import "Right1Cell.h"
#import "Nine1Cell.h"
#import "Ten1Cell.h"
#import <Photos/Photos.h>
//李发林
#import <AssetsLibrary/AssetsLibrary.h>
#import "FCTabBarViewController.h"
#import "header.h"
#import "LFLView.h"
@interface DraftDetailViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout>{
    //    NSMutableArray * dataNumberArr;
    NSMutableArray * ModuleIdArr;
    NSMutableArray * ImageArr;
    NSMutableArray * VideoArr;
    UIView * guideAnimationView;
    UIView * ChooseView;
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
    NSMutableArray * shijipamaArr;
    
    //    沙盒里面存在的总数据
    NSMutableArray * zongArr;
    
    NSMutableArray * ModulesArr;
    NSString * changeNum;
    MBProgressHUD *hud;
    
    //    NSString *yunxu;
    TencentOAuth *tencentOAuth;
    NSString * left;
    
    NSString * NoWork;//用于判断是否是已经来直接就按保存
    //    NSString *changeNum;
    NSString *isClick;
    
    int ZongSum;
    int SureSum;
    float SumData;
    float AlerayldData;
    
    
    NSString *StartJQ;
    CAShapeLayer *border;
    NSString *IsBack;
    UIButton *button;
    UIButton *headerButton;
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
@property (nonatomic, weak) LFLView *circleView;
@end

@implementation DraftDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [FCAppInfo shareManager].ScrapbookId=self.ScrapbookId;
    NSLog(@"--%f",APP_SCREEN_WIDTH);
    changeNum=@"0";
    left=@"0";
    NoWork=@"1";
    //    yunxu=@"1";
    ModulesArr=[NSMutableArray arrayWithCapacity:0];
    ModuleIdArr=[NSMutableArray arrayWithCapacity:0];
    ImageArr=[NSMutableArray arrayWithCapacity:0];
    pamaArr=[NSMutableArray arrayWithCapacity:0];
    shijipamaArr=[NSMutableArray arrayWithCapacity:0];
    VideoArr=[NSMutableArray arrayWithCapacity:0];
    chooseVideo=NO;
    chooseImg=NO;
    //    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"编辑呈记";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self confinRightItemWithImg:[UIImage imageNamed:@"edityes"]];
    
   
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _DataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) collectionViewLayout:layout];
    _DataCollectionView.backgroundColor = [UIColor whiteColor];
    _DataCollectionView.dataSource = self;
    _DataCollectionView.delegate = self;
    _DataCollectionView.showsVerticalScrollIndicator=YES;
    [_DataCollectionView registerClass:[One1Cell class] forCellWithReuseIdentifier:@"cellid1"];
    [_DataCollectionView registerClass:[Two1Cell class] forCellWithReuseIdentifier:@"cellid2"];
    [_DataCollectionView registerClass:[Three1Cell class] forCellWithReuseIdentifier:@"cellid3"];
    [_DataCollectionView registerClass:[Four1Cell class] forCellWithReuseIdentifier:@"cellid4"];
    [_DataCollectionView registerClass:[Five1Cell class] forCellWithReuseIdentifier:@"cellid5"];
    [_DataCollectionView registerClass:[Six1Cell class] forCellWithReuseIdentifier:@"cellid6"];
    [_DataCollectionView registerClass:[Seven1Cell class] forCellWithReuseIdentifier:@"cellid7"];
    [_DataCollectionView registerClass:[Right1Cell class] forCellWithReuseIdentifier:@"cellid8"];
    [_DataCollectionView registerClass:[Nine1Cell class] forCellWithReuseIdentifier:@"cellid9"];
    [_DataCollectionView registerClass:[Ten1Cell class] forCellWithReuseIdentifier:@"cellid10"];
    
    [_DataCollectionView registerClass:[header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    [_DataCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer1"];
    [self.view addSubview:_DataCollectionView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeImage:) name:@"PicutreFromAlbum" object:nil];
    
    [self createUI];
}
-(void)changeImage:(NSNotification*)notification{
    
    
    NSData * data=notification.userInfo[@"image"];
    NSDictionary * dic=@{@"image":data};
    NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
    if ([[FCAppInfo shareManager].isHeader isEqualToString:@"yes"]) {
        NSString *zuiIndex=[NSString stringWithFormat:@"%@imageheader",self.ScrapbookId];
        [stand setObject:dic forKey:zuiIndex];
        [stand synchronize];
        [self.DataCollectionView reloadData];
    }else{
        NSString *zuiIndex=[NSString stringWithFormat:@"%@%@%@image",lflimage,image1,self.ScrapbookId];
        NSString *zuiIndex1=[NSString stringWithFormat:@"%@%@%@video",lflimage,image1,self.ScrapbookId];
        NSDictionary * video=[stand objectForKey:zuiIndex1];
        if (video.count>0)
        {
            [stand removeObjectForKey:zuiIndex1];
        }
        [stand setObject:dic forKey:zuiIndex];
        [stand synchronize];
        [self.DataCollectionView reloadData];
    }
    
}
-(void)popLeftItemView{
    if ([IsBack isEqualToString:@"1"]) {
        
    }else{
        //移除所有有关的text沙盒
        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [stand dictionaryRepresentation];
        for(NSString *key in [dictionary allKeys]){
            if ([key containsString:[NSString stringWithFormat:@"%@image",self.ScrapbookId]]||[key containsString:[NSString stringWithFormat:@"%@headerText",self.ScrapbookId]]||[key containsString:[NSString stringWithFormat:@"%@video",self.ScrapbookId]]) {
                [stand removeObjectForKey:key];
                [stand synchronize];
            }
            
        }
        if ([left isEqualToString:@"0"]) {
            [FCAppInfo shareManager].back=@"1";
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
    
    
}
-(void)lflButton
{
    [self captureWithFrame];
    if ([isClick isEqualToString:@"1"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否完成编辑" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->StartJQ=@"yes";
            [self.DataCollectionView reloadData];
            [self captureWithFrame];
            
            self->isClick=@"0";
            self->IsBack=@"1";
            [self findNetWorkStatus];
            
            
            
        }];
        UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self->isClick=@"1";
            self->StartJQ=@"no";
          
        }];
        [alertController addAction:confirm];
        [alertController addAction:cance];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        
    }
}
-(void)popRightItemView
{
    if ([IsBack isEqualToString:@"1"]) {
        
    }
    else
    {
        [self.DataCollectionView setContentOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN) animated:YES];
        [self performSelector:@selector(lflButton) withObject:self afterDelay:0.5];
        
    }
    
    
    
    
}
-(void)lfl{
    SureSum=0;
    wancheng=@"1";
    SumData=[self getPictureData];
    AlerayldData=0;
    
    
    LFLView *circleView = [[LFLView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2.0-30, APP_SCREEN_HEIGHT/2.0-30, 60, 60)];
    circleView.arcFinishColor =UIColorFromHex(0x75AB33);
    circleView.arcUnfinishColor =UIColorFromHex(0x0D6FAE);
    circleView.arcBackColor =UIColorFromHex(0xEAEAEA);
    [self.view addSubview:circleView];
    self.circleView = circleView;
    
    
    
    self.DataCollectionView.userInteractionEnabled=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [stand dictionaryRepresentation];
        
        for(NSString *key in [dictionary allKeys]){
            if ([key containsString:[NSString stringWithFormat:@"%@image",self.ScrapbookId]]) {
                if ([key containsString:@"imageheader"]) {
                    NSDictionary *lfldic=[self objectValueWith:key];
                    if (lfldic.count==2) {
                        [self->ImageArr addObject:[NSString stringWithFormat:@"imageheader%@",lfldic[@"image"]]];
                    }else{
                        [self uploadPictureOSS:key];
                    }
                }else{
                    NSDictionary *dic = [self objectValueWith:key];
                    if (dic.count==2)
                    {
                        NSString *wtextIndex1=[NSString stringWithFormat:@"%@",key];
                        NSString *lfl=[NSString stringWithFormat:@"%@%@",wtextIndex1,dic[@"PictureURL"]];
                        
                        [self->ImageArr addObject:lfl];
                    }
                    else
                    {
                        
                        [self uploadPictureOSS:key];
                        
                    }
                }
                
                
            }
            if ([key containsString:[NSString stringWithFormat:@"%@video",self.ScrapbookId]]) {
                NSDictionary *dic = [self objectValueWith:key];
                if (dic.count==2) {
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%@",key];
                    NSString *lfl=[NSString stringWithFormat:@"%@%@",wtextIndex1,dic[@"VideoURL"]];
                    self->SureSum+=1;
                    [self->VideoArr addObject:lfl];
                }
                else
                {
                    self->SureSum+=1;
                    [self uploadVideoOSS:key];
                    
                }
                
            }
            
        }
        
        if (self->SumData==0) {
            [self startWork];
            
        }
    });
}
//直接点击保存没有其他操作

-(void)upDetail{
    NSLog(@"-%@",ImageArr);
    self->StartJQ=@"no";
    NSString * jianqie;
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@headerText",self.ScrapbookId]]) {
            NSDictionary *dic=[stand objectForKey:key];
            NSString * Color=dic[@"Color"];
            NSString *FontFamily=dic[@"FontFamily"];
            NSString *FontSize=dic[@"FontSize"];
            NSString *ParameterType=@"TEXT";
            NSString *Text=dic[@"Text"];
            NSString *TextAlign=dic[@"TextAlign"];
            
            NSDictionary *image;
            
            NSString *imageUrl;
            
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=ImageArr[i];
                if ([String containsString:@"imageheader"]) {
                    NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }
                //增加截图
                else if ([String containsString:@"jianqie"]){
                    NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    jianqie=[ImageArr[i] substringFromIndex:range.location];
                }
            }
            
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":ParameterType,@"Text":Text,@"TextAlign":TextAlign};
            
            if (imageUrl.length<10) {
                //                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
                NSArray *arr=@[headerPara];
                NSDictionary *zong=@{@"ModuleId":@"Module_header",@"Parameters":arr};
                [pamaArr insertObject:zong atIndex:0];
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
                NSArray *arr=@[headerPara,image];
                NSDictionary *zong=@{@"ModuleId":@"Module_header",@"Parameters":arr};
                [pamaArr insertObject:zong atIndex:0];
            }
        }
        
    }
    
    NSArray *arr=@[];
    NSDictionary *zong=@{@"ModuleId":@"Module_footer",@"Parameters":arr};
    [pamaArr addObject:zong];
    if (pamaArr.count<3) {
        [self showMessage:@"参数有误"];
        return;
    }
    NSLog(@"pamaArr==%@",pamaArr);
    
    NSDictionary *dic=@{@"Modules":pamaArr,@"TemplateId":self.TemplateId};
    NSError *error;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *lfldic=@{@"AccessToken":AccessToken,@"Scrapbook":jsonString,@"ScrapbookId":self.ScrapbookId,@"Picture":jianqie};
    
    NSString *lflstring= [self createSign:lfldic];
    
    NSDictionary *param=@{@"Sign":lflstring,@"Scrapbook":jsonString,@"ScrapbookId":self.ScrapbookId,@"Picture":jianqie};
    
    
    
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:updateScrapbook WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"完成更新上传图片%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            self->isClick=@"1";
            self->wancheng=@"0";
            self->left=@"1";
            [self->pamaArr removeAllObjects];
            [self->ImageArr removeAllObjects];
            //            [self.DataCollectionView reloadData];
            if(self->hud)
            {
                [self->hud hideAnimated:YES afterDelay:0.2];
            }
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PicutreFromAlbum" object:nil];
            FCTabBarViewController *hand=[[FCTabBarViewController alloc]init];
            hand.selectedIndex=0;
            UIWindow *window=[UIApplication sharedApplication].delegate.window;
            window.rootViewController=hand;
            [self.view removeFromSuperview];
            
        }
        else if ([msgStr isEqualToString:@"0"])
        {
            [self getNewToken];
            self->wancheng=@"0";
            self->IsBack=@"0";
            self.DataCollectionView.userInteractionEnabled=YES;
        }
        else if ([msgStr isEqualToString:@"-1"])
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            self->wancheng=@"0";
            self->IsBack=@"0";
            self.DataCollectionView.userInteractionEnabled=YES;
            
        }
        else if ([msgStr isEqualToString:@"-2"])
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            self->wancheng=@"0";
            self->IsBack=@"0";
            self.DataCollectionView.userInteractionEnabled=YES;
            
        }
        else if ([msgStr isEqualToString:@"-3"])
        {
            [self gotoLogin];
            
        }
        else
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            self->wancheng=@"0";
            self->IsBack=@"0";
            self.DataCollectionView.userInteractionEnabled=YES;
            
        }
        
        
    } withfail:^(NSString *errorMsg) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    UIImageView * imageView=[[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[FCAppInfo shareManager].backgroundImage] placeholderImage:[UIImage imageNamed:@""]];
    imageView.frame=CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    self.DataCollectionView.backgroundView=imageView;
    wancheng=@"0";
    IsBack=@"0";
    self->isClick=@"1";
    ChooseView.hidden=NO;
    self.TemplateId=[FCAppInfo shareManager].lflTemID;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.DataCollectionView reloadData];
    });
    
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    ChooseView.hidden=YES;
}
-(void)createUI{
    ChooseView=[[UIView alloc]init];
    ChooseView.frame=CGRectMake(15, self.view.bounds.size.height-100, 15+70*2+50, 50);
    
    NSArray*array=@[@"图标",@"图标1"];
    for (int i=0; i<2; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=i;
        [button addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        button.clipsToBounds=YES;
        button.layer.cornerRadius=25;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor yellowColor];
        button.frame=CGRectMake(70*i, 0, 50, 50);
        [ChooseView addSubview:button];
        [[UIApplication sharedApplication].keyWindow addSubview:ChooseView];
    }
    
}
#pragma UICollectionDelegate
//collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ModuleIdArr.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * currentString=ModuleIdArr[indexPath.row];
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    
    if ([currentString isEqualToString:@"Module_1_1"]) {
        NSString * text;
        NSString * FontFamily;
        NSString * FontSize;
        NSString * Color;
        NSString * TextAlign;
        
        One1Cell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid1" forIndexPath:indexPath];
        
        [cell1.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell1.leftButton.tag=indexPath.row;
        [cell1.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
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
        NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic=[stand objectForKey:wtextIndex];
        if (wDic.count>2) {
            
            cell1.bottomLabel.text=wDic[@"Text"];
            cell1.bottomLabel.font=[UIFont fontWithName:wDic[@"FontFamily"] size:[wDic[@"FontSize"] intValue]];
            cell1.bottomLabel.textColor=UIColorFromHex([wDic[@"Color"] intValue]);
            if ([wDic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell1.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([wDic[@"TextAlign"] isEqualToString:@"Left"]) {
                cell1.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }
            else
            {
                cell1.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
            
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            //            if (height>kheigh(58)){
            cell1.editButton.frame=CGRectMake(kheigh(20), 0, self.view.bounds.size.width-2*kWidth(20), height);
            cell1.bottomLabel.frame=CGRectMake(0, kWidth(1), self.view.bounds.size.width-2*kWidth(20), height);
            
        }else{
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
                
                //                //保存从服务器返回的数据
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                [self setValueName:dic withKey:textIndex];
                
                text=dic[@"Text"];
                FontFamily=dic[@"FontFamily"];
                FontSize=dic[@"FontSize"];
                TextAlign=dic[@"TextAlign"];
                Color=dic[@"Color"];
                CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
        
                cell1.editButton.frame=CGRectMake(kheigh(20), 0, self.view.bounds.size.width-2*kWidth(20), height);
                cell1.bottomLabel.frame=CGRectMake(0, kWidth(1), self.view.bounds.size.width-2*kWidth(20), height);
            }
        }
        [cell1 setLFL];
        if ([wancheng isEqualToString:@"1"]) {
            //添加数据
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":@"TEXT",@"Text":text,@"TextAlign":TextAlign};
            NSArray *arr=@[headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_1_1",@"Parameters":arr};
            [pamaArr addObject:zong];
        }
        
        
        return cell1;
    }
    else if ([currentString isEqualToString:@"Module_1_2"]){
        NSString *urlStr;
        Two1Cell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid2" forIndexPath:indexPath];
        [cell2.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell2.leftButton.tag=indexPath.row;
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
        [cell2.addButton addTarget:self action:@selector(Cell2AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell2.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell2.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell2.centerImg.image=[UIImage imageNamed:@""];
            
            if ([wancheng isEqualToString:@"1"]) {
                
                NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                NSString *VideoUrl;
                for (int i=0; i<VideoArr.count; i++){
                    NSString * String=[VideoArr[i] substringToIndex:VideoIndex1.length];
                    NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    if ([String isEqualToString:VideoIndex1]) {
                        VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                    }
                }
                
                if (VideoUrl.length>9)
                {
                    
                    //添加数据
                    NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
                    NSArray *arr=@[image];
                    NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                    [pamaArr addObject:zong];
                    
                }else
                {
                    for (int i=0; i<ImageArr.count; i++) {
                        NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                        NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                        if ([String isEqualToString:wtextIndex1]) {
                            urlStr=[ImageArr[i] substringFromIndex:range.location];
                        }
                    }
                    //添加数据
                    NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":urlStr};
                    NSArray *arr=@[image];
                    NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                    [pamaArr addObject:zong];
                }
                
            }
        }else{
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9)
                {
                    [cell2.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell2.centerImg.image=[UIImage imageNamed:@""];
                    
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell2.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell2.centerImg.image=[UIImage imageNamed:@"zanting"];
                    
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSData *imageData = UIImagePNGRepresentation(video);
                    NSDictionary * dataDic=@{@"image":imageData};
                    [self setValueName:dataDic withKey:wtextIndex1];

                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    
                    [self setValueName:dic1 withKey:textIndex1];
                    
                }
               
                if ([wancheng isEqualToString:@"1"]) {
                    //添加数据
                    NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    NSString *VideoUrl;
                    for (int i=0; i<VideoArr.count; i++){
                        NSString * String=[VideoArr[i] substringToIndex:VideoIndex1.length];
                        NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                        if ([String isEqualToString:VideoIndex1]) {
                            VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                        }
                    }
                    
                    if (VideoUrl.length>9)
                    {
                        
                        //添加数据
                        NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
                        NSArray *arr=@[image];
                        NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                        [pamaArr addObject:zong];
                        
                    }else{
                        NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":string};
                        NSArray *arr=@[image];
                        NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                        [pamaArr addObject:zong];
                    }
                    
                    
                }
            }else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell2.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell2.centerImg.image=[UIImage imageNamed:@""];
                    if ([wancheng isEqualToString:@"1"]) {
                        //添加数据
                        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                        
                        NSString *VideoUrl;
                        for (int i=0; i<VideoArr.count; i++){
                            NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                            NSString * String=[VideoArr[i] substringToIndex:range.location];
                            if ([String isEqualToString:VideoIndex1]) {
                                VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                            }
                        }
                        
                        if (VideoUrl.length>9)
                        {
                            
                            //添加数据
                            NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
                            NSArray *arr=@[image];
                            NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                            [pamaArr addObject:zong];
                            
                        }else{
                            NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":string};
                            NSArray *arr=@[image];
                            NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                            [pamaArr addObject:zong];
                        }
                        
                    }
                }else{
                    cell2.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell2.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell2.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
                
            }
            
            
            
        }
        
        //添加视屏播放的按钮
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell2.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        return cell2;
    }
    else if ([currentString isEqualToString:@"Module_2_1"]){
        NSString * text;
        NSString * FontFamily;
        NSString * FontSize;
        NSString * Color;
        NSString * TextAlign;
        NSString * imageUrl;
        NSString * imageUrl1;
        Three1Cell *cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid3" forIndexPath:indexPath];
        [cell3.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell3.leftButton.tag=indexPath.row;
        
        
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
        [cell3.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
        cell3.editButton.tag=indexPath.row;
        
        NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic=[stand objectForKey:wtextIndex];
        
        if (wDic.count>2) {
            
            cell3.bottomLabel.text=wDic[@"Text"];
            cell3.bottomLabel.font=[UIFont fontWithName:wDic[@"FontFamily"] size:[wDic[@"FontSize"] intValue]];
            cell3.bottomLabel.textColor=UIColorFromHex([wDic[@"Color"] intValue]);
            if ([wDic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell3.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([wDic[@"TextAlign"] isEqualToString:@"Left"]) {
                cell3.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }else{
                cell3.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
            
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
        }else{
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
                text=dic[@"Text"];
                FontFamily=dic[@"FontFamily"];
                FontSize=dic[@"FontSize"];
                TextAlign=dic[@"TextAlign"];
                Color=dic[@"Color"];
                //保存从服务器返回的数据
                                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                
                                [self setValueName:dic withKey:textIndex];
                
            }
            
        }
        //        添加图片按钮的操作
        [cell3.addButton addTarget:self action:@selector(Cell3AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell3.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell3.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell3.centerImg.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell3.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell3.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell3.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell3.centerImg.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                //            [cell3.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                //            cell3.centerImg.image=[UIImage imageNamed:@""];
                //            NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                //            [self setValueName:dic1 withKey:textIndex1];
                imageUrl=string;
            }
            else
            {
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell3.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell3.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl=string;
                }else{
                    cell3.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell3.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell3.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
                
            }
            
        }
        
        [cell3.add1Button addTarget:self action:@selector(Cell3Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell3.add1Button.tag=indexPath.row;
        NSString *wtextIndex2=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic2=[stand objectForKey:wtextIndex2];
        if (wDic2.count==1) {
            NSData *data=wDic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell3.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell3.center1Img.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                NSString * String=[ImageArr[i] substringToIndex:range.location];
                if ([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell3.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell3.center1Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell3.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell3.center1Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl1=string;
            }else{
                if (wDic2.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic2[@"PictureURL"]];
                    [cell3.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell3.center1Img.image=[UIImage imageNamed:@""];
                    imageUrl1=string;
                }else{
                    cell3.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell3.center1Img.image=[UIImage imageNamed:@"中间"];
                    [cell3.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSDictionary *image1;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            for (int i=0; i<VideoArr.count; i++){
                NSString * String=[VideoArr[i] substringToIndex:VideoIndex.length];
                NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    VideoUrl1=[VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            NSString *imageUrl;
            NSString *imageUrl1;
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":@"TEXT",@"Text":text,@"TextAlign":TextAlign};
            NSArray *arr=@[headerPara,image,image1];
            NSDictionary *zong=@{@"ModuleId":@"Module_2_1",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell3.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell3.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        return cell3;
    }
    else if ([currentString isEqualToString:@"Module_2_2"]){
        NSString * text;
        NSString * FontFamily;
        NSString * FontSize;
        NSString * Color;
        NSString * TextAlign;
        NSString *imageUrl;
        Four1Cell *cell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid4" forIndexPath:indexPath];
        [cell4.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell4.leftButton.tag=indexPath.row;
        [cell4.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
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
        NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic=[stand objectForKey:wtextIndex];
        
        if (wDic.count>2) {
            
            cell4.bottomLabel.text=wDic[@"Text"];
            cell4.bottomLabel.font=[UIFont fontWithName:wDic[@"FontFamily"] size:[wDic[@"FontSize"] intValue]];
            cell4.bottomLabel.textColor=UIColorFromHex([wDic[@"Color"] intValue]);
            if ([wDic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell4.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([wDic[@"TextAlign"] isEqualToString:@"Left"]) {
                cell4.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }else{
                cell4.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
            
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
            
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            
            //            if (height>kheigh(31)){
            cell4.bgImage.frame=CGRectMake(cell4.bgImage.frame.origin.x, kheigh(46)+height-kheigh(31), cell4.bgImage.frame.size.width, cell4.bgImage.frame.size.height);
            cell4.editButton.frame=CGRectMake(kheigh(20), 0, kheigh(280), height);
            cell4.bottomLabel.frame=CGRectMake(0, kWidth(1), kheigh(280), height);
            cell4.addButton.frame=CGRectMake(cell4.addButton.frame.origin.x, kheigh(46)+height-kheigh(31), cell4.addButton.frame.size.width, cell4.addButton.frame.size.height);
            //            }else{
            //                cell4.bgImage.frame=CGRectMake(cell4.bgImage.frame.origin.x, kheigh(46),cell4.bgImage.frame.size.width, cell4.bgImage.frame.size.height);
            //                cell4.editButton.frame=CGRectMake(kheigh(20), 0, kheigh(280), kheigh(31));
            //                cell4.bottomLabel.frame=CGRectMake(0, 0, kheigh(280), kheigh(31));
            //                cell4.addButton.frame=CGRectMake(cell4.addButton.frame.origin.x, kheigh(46), cell4.addButton.frame.size.width, cell4.addButton.frame.size.height);
            //            }
        }else{
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
                
            }
            
            text=dic[@"Text"];
            FontFamily=dic[@"FontFamily"];
            FontSize=dic[@"FontSize"];
            TextAlign=dic[@"TextAlign"];
            Color=dic[@"Color"];
            
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            
            //            if (height>kheigh(31)){
            cell4.bgImage.frame=CGRectMake(cell4.bgImage.frame.origin.x, kheigh(46)+height-kheigh(31), cell4.bgImage.frame.size.width, cell4.bgImage.frame.size.height);
            cell4.editButton.frame=CGRectMake(kheigh(20), 0, kheigh(280), height);
            cell4.bottomLabel.frame=CGRectMake(0, kWidth(1), kheigh(280), height);
            cell4.addButton.frame=CGRectMake(cell4.addButton.frame.origin.x, kheigh(46)+height-kheigh(31), cell4.addButton.frame.size.width, cell4.addButton.frame.size.height);
            //            }else{
            //                cell4.bgImage.frame=CGRectMake(cell4.bgImage.frame.origin.x, kheigh(46),cell4.bgImage.frame.size.width, cell4.bgImage.frame.size.height);
            //                cell4.editButton.frame=CGRectMake(kheigh(20), 0, kheigh(280), kheigh(31));
            //                cell4.bottomLabel.frame=CGRectMake(0, 0, kheigh(280), kheigh(31));
            //                cell4.addButton.frame=CGRectMake(cell4.addButton.frame.origin.x, kheigh(46), cell4.addButton.frame.size.width, cell4.addButton.frame.size.height);
            //            }
            //保存从服务器返回的数据
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
        }
        [cell4 setLFL];
        
        //        添加图片按钮的操作
        [cell4.addButton addTarget:self action:@selector(Cell4AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell4.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell4.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell4.centerImg.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell4.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell4.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell4.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell4.centerImg.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl=string;
            }else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell4.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell4.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl=string;
                }else{
                    cell4.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell4.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell4.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
            
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoUrl;
            for (int i=0; i<VideoArr.count; i++){
                NSString * String=[VideoArr[i] substringToIndex:VideoIndex.length];
                NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            NSString *imageUrl;
            
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    //                    NSRange range = [key rangeOfString:self.ScrapbookId];
                    //                    NSString *str = [key substringToIndex:range.location];
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":@"TEXT",@"Text":text,@"TextAlign":TextAlign};
            NSArray *arr=@[headerPara,image];
            NSDictionary *zong=@{@"ModuleId":@"Module_2_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell4.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        return cell4;
        return cell4;
    }
    else if ([currentString isEqualToString:@"Module_3_1"]){
        NSString * text;
        NSString * FontFamily;
        NSString * FontSize;
        NSString * Color;
        NSString * TextAlign;
        NSString *imageUrl;
        NSString *imageUrl1;
        NSString *imageUrl2;
        Five1Cell *cell5 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid5" forIndexPath:indexPath];
        [cell5.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell5.leftButton.tag=indexPath.row;
        [cell5.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
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
        NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic=[stand objectForKey:wtextIndex];
        
        if (wDic.count>2) {
            
            cell5.bottomLabel.text=wDic[@"Text"];
            cell5.bottomLabel.font=[UIFont fontWithName:wDic[@"FontFamily"] size:[wDic[@"FontSize"] intValue]];
            cell5.bottomLabel.textColor=UIColorFromHex([wDic[@"Color"] intValue]);
            if ([wDic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell5.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([wDic[@"TextAlign"] isEqualToString:@"Left"]) {
                cell5.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }else{
                cell5.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            //            if (height>kheigh(15)) {
            cell5.bgImage.frame=CGRectMake(cell5.bgImage.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.bgImage.frame.size.width, cell5.bgImage.frame.size.height);
            cell5.editButton.frame=CGRectMake(kheigh(20),0, kWidth(280), height);
            cell5.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
            cell5.addButton.frame=CGRectMake(cell5.addButton.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.addButton.frame.size.width, cell5.addButton.frame.size.height);
            cell5.add1Button.frame=CGRectMake(cell5.add1Button.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.add1Button.frame.size.width, cell5.add1Button.frame.size.height);
            cell5.add2Button.frame=CGRectMake(cell5.add2Button.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.add2Button.frame.size.width, cell5.add2Button.frame.size.height);
            
            //            }else{
            //                cell5.bgImage.frame=CGRectMake(cell5.bgImage.frame.origin.x, kheigh(30), cell5.bgImage.frame.size.width, cell5.bgImage.frame.size.height);
            //                cell5.editButton.frame=CGRectMake(kheigh(20), 0, kWidth(280), kheigh(15));
            //                cell5.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kheigh(15));
            //                cell5.addButton.frame=CGRectMake(cell5.addButton.frame.origin.x, kheigh(30), cell5.addButton.frame.size.width, cell5.addButton.frame.size.height);
            //                cell5.add1Button.frame=CGRectMake(cell5.add1Button.frame.origin.x, kheigh(30), cell5.add1Button.frame.size.width, cell5.add1Button.frame.size.height);
            //                cell5.add2Button.frame=CGRectMake(cell5.add2Button.frame.origin.x, kheigh(30), cell5.add2Button.frame.size.width, cell5.add2Button.frame.size.height);
            //            }
        }else{
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
                
            }
            
            text=dic[@"Text"];
            FontFamily=dic[@"FontFamily"];
            FontSize=dic[@"FontSize"];
            TextAlign=dic[@"TextAlign"];
            Color=dic[@"Color"];
            
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            //            if (height>kheigh(15)) {
            cell5.bgImage.frame=CGRectMake(cell5.bgImage.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.bgImage.frame.size.width, cell5.bgImage.frame.size.height);
            cell5.editButton.frame=CGRectMake(kheigh(20),0, kWidth(280), height);
            cell5.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
            cell5.addButton.frame=CGRectMake(cell5.addButton.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.addButton.frame.size.width, cell5.addButton.frame.size.height);
            cell5.add1Button.frame=CGRectMake(cell5.add1Button.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.add1Button.frame.size.width, cell5.add1Button.frame.size.height);
            cell5.add2Button.frame=CGRectMake(cell5.add2Button.frame.origin.x, kheigh(30)+height-kheigh(15), cell5.add2Button.frame.size.width, cell5.add2Button.frame.size.height);
            
            //            }else{
            //                cell5.bgImage.frame=CGRectMake(cell5.bgImage.frame.origin.x, kheigh(30), cell5.bgImage.frame.size.width, cell5.bgImage.frame.size.height);
            //                cell5.editButton.frame=CGRectMake(kheigh(20), 0, kWidth(280), kheigh(15));
            //                cell5.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kheigh(15));
            //                cell5.addButton.frame=CGRectMake(cell5.addButton.frame.origin.x, kheigh(30), cell5.addButton.frame.size.width, cell5.addButton.frame.size.height);
            //                cell5.add1Button.frame=CGRectMake(cell5.add1Button.frame.origin.x, kheigh(30), cell5.add1Button.frame.size.width, cell5.add1Button.frame.size.height);
            //                cell5.add2Button.frame=CGRectMake(cell5.add2Button.frame.origin.x, kheigh(30), cell5.add2Button.frame.size.width, cell5.add2Button.frame.size.height);
            //            }
            //保存从服务器返回的数据
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            [self setValueName:dic withKey:textIndex];
        }
        [cell5 setLFL];
        //        添加图片按钮的操作
        [cell5.addButton addTarget:self action:@selector(Cell5AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell5.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell5.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell5.centerImg.image=[UIImage imageNamed:@""];
            
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell5.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell5.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell5.centerImg.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl=string;
                
            }else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell5.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl=string;
                }else{
                    cell5.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell5.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell5.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        
        [cell5.add1Button addTarget:self action:@selector(Cell5Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell5.add1Button.tag=indexPath.row;
        NSString *wtextIndex2=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic2=[stand objectForKey:wtextIndex2];
        if (wDic2.count==1) {
            NSData *data=wDic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell5.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell5.center1Img.image=[UIImage imageNamed:@""];
            
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex2.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell5.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.center1Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell5.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell5.center1Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl1=string;
            }else{
                if (wDic2.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic2[@"PictureURL"]];
                    [cell5.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.center1Img.image=[UIImage imageNamed:@""];
                    imageUrl1=string;
                }else{
                    cell5.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell5.center1Img.image=[UIImage imageNamed:@"中间"];
                    [cell5.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        [cell5.add2Button addTarget:self action:@selector(Cell5Add2Button:) forControlEvents:UIControlEventTouchUpInside];
        cell5.add2Button.tag=indexPath.row;
        NSString *wtextIndex3=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic3=[stand objectForKey:wtextIndex3];
        if (wDic3.count==1) {
            NSData *data=wDic3[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell5.add2Button setBackgroundImage:image forState:UIControlStateNormal];
            cell5.center2Img.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex3.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex3]) {
                    imageUrl2=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[3];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell5.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.center2Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell5.add2Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell5.center2Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl2=string;
            }else{
                if (wDic3.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic3[@"PictureURL"]];
                    [cell5.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell5.center2Img.image=[UIImage imageNamed:@""];
                    imageUrl2=string;
                }else{
                    cell5.add2Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell5.center2Img.image=[UIImage imageNamed:@"中间"];
                    [cell5.add2Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSDictionary *image1;
            NSDictionary *image2;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            NSString *VideoUrl2;
            for (int i=0; i<VideoArr.count; i++){
                NSString * String=[VideoArr[i] substringToIndex:VideoIndex.length];
                NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    VideoUrl1=[VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex2]) {
                    VideoUrl2=[VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            NSString *imageUrl;
            NSString *imageUrl1;
            NSString *imageUrl2;
            for (int i=0; i<ImageArr.count; i++) {
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:wtextIndex3]){
                    imageUrl2=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            
            if (VideoUrl2.length>9) {
                image2=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl2};
            }else{
                image2=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl2};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":@"TEXT",@"Text":text,@"TextAlign":TextAlign};
            NSArray *arr=@[headerPara,image,image1,image2];
            NSDictionary *zong=@{@"ModuleId":@"Module_3_1",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell5.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell5.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic2=[stand objectForKey:VideoIndex2];
        if (Videodic2.count>0) {
            cell5.center2Img.image=[UIImage imageNamed:@"zanting"];
        }
        return cell5;
    }
    
    
    
    
    else if ([currentString isEqualToString:@"Module_3_2"]){
        NSString * text;
        NSString * FontFamily;
        NSString * FontSize;
        NSString * Color;
        NSString * TextAlign;
        NSString *imageUrl;
        NSString *imageUrl1;
        NSString *imageUrl2;
        Six1Cell *cell6 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid6" forIndexPath:indexPath];
        [cell6.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell6.leftButton.tag=indexPath.row;
        [cell6.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
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
        NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic=[stand objectForKey:wtextIndex];
        
        if (wDic.count>2) {
            
            cell6.bottomLabel.text=wDic[@"Text"];
            cell6.bottomLabel.font=[UIFont fontWithName:wDic[@"FontFamily"] size:[wDic[@"FontSize"] intValue]];
            cell6.bottomLabel.textColor=UIColorFromHex([wDic[@"Color"] intValue]);
            if ([wDic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell6.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([wDic[@"TextAlign"] isEqualToString:@"Left"]) {
                cell6.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }else{
                cell6.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
            
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            //            if (height>kWidth(33)) {
            cell6.editButton.frame=CGRectMake(kWidth(20), kWidth(165), kWidth(280), height);
            cell6.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
            //            }else{
            //                cell6.editButton.frame=CGRectMake(kWidth(20), kWidth(165),kWidth(280), kWidth(33));
            //                cell6.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kWidth(33));
            //            }
        }
        else
        {
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSLog(@"dayin==%@",paraArr);
            if (paraArr.count<3) {
                
            }else{
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
                    
                    
                }
                
                text=dic[@"Text"];
                FontFamily=dic[@"FontFamily"];
                FontSize=dic[@"FontSize"];
                TextAlign=dic[@"TextAlign"];
                Color=dic[@"Color"];
                
                CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
                //                if (height>kWidth(33)) {
                cell6.editButton.frame=CGRectMake(kWidth(20), kWidth(165), kWidth(280), height);
                cell6.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height-25);
                //保存从服务器返回的数据
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                [self setValueName:dic withKey:textIndex];
            }
            
            
        }
        [cell6 setLFL];
        //        添加图片按钮的操作
        [cell6.addButton addTarget:self action:@selector(Cell6AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell6.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell6.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell6.centerImg.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell6.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell6.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell6.centerImg.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl=string;
                
            }else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell6.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl=string;
                }else{
                    cell6.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell6.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell6.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        
        [cell6.add1Button addTarget:self action:@selector(Cell6Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell6.add1Button.tag=indexPath.row;
        NSString *wtextIndex2=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic2=[stand objectForKey:wtextIndex2];
        if (wDic2.count==1) {
            NSData *data=wDic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell6.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell6.center1Img.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex2.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell6.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.center1Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell6.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell6.center1Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl1=string;
            }else{
                if (wDic2.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic2[@"PictureURL"]];
                    [cell6.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.center1Img.image=[UIImage imageNamed:@""];
                    imageUrl1=string;
                }else{
                    cell6.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell6.center1Img.image=[UIImage imageNamed:@"中间"];
                    [cell6.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        [cell6.add2Button addTarget:self action:@selector(Cell6Add2Button:) forControlEvents:UIControlEventTouchUpInside];
        cell6.add2Button.tag=indexPath.row;
        NSString *wtextIndex3=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic3=[stand objectForKey:wtextIndex3];
        if (wDic3.count==1) {
            NSData *data=wDic3[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell6.add2Button setBackgroundImage:image forState:UIControlStateNormal];
            cell6.center2Img.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex3.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex3]) {
                    imageUrl2=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell6.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.center2Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell6.add2Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell6.center2Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl2=string;
            }else{
                if (wDic3.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic3[@"PictureURL"]];
                    [cell6.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell6.center2Img.image=[UIImage imageNamed:@""];
                    imageUrl2=string;
                }else{
                    cell6.add2Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell6.center2Img.image=[UIImage imageNamed:@"中间"];
                    [cell6.add2Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSDictionary *image1;
            NSDictionary *image2;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            NSString *VideoUrl2;
            for (int i=0; i<VideoArr.count; i++){
                
                NSString * String=[VideoArr[i] substringToIndex:VideoIndex.length];
                NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    VideoUrl1=[VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex2]) {
                    VideoUrl2=[VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            NSString *imageUrl;
            NSString *imageUrl1;
            NSString *imageUrl2;
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:wtextIndex3]){
                    imageUrl2=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            
            if (VideoUrl2.length>9) {
                image2=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl2};
            }else{
                image2=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl2};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":@"TEXT",@"Text":text,@"TextAlign":TextAlign};
            NSArray *arr=@[image,image1,image2,headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_3_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell6.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell6.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic2=[stand objectForKey:VideoIndex2];
        if (Videodic2.count>0) {
            cell6.center2Img.image=[UIImage imageNamed:@"zanting"];
        }
        return cell6;
    }
    
    
    
    else if ([currentString isEqualToString:@"Module_4_2"]){
        NSString *imageUrl;
        NSString *imageUrl1;
        NSString *imageUrl2;
        NSString *imageUrl3;
        Right1Cell *cell8 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid8" forIndexPath:indexPath];
        [cell8.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell8.leftButton.tag=indexPath.row;
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
        [cell8.addButton addTarget:self action:@selector(Cell8AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell8.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell8.centerImg.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell8.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell8.centerImg.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl=string;
            } else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell8.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl=string;
                }else{
                    cell8.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell8.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell8.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
            
        }
        
        [cell8.add1Button addTarget:self action:@selector(Cell8Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell8.add1Button.tag=indexPath.row;
        NSString *wtextIndex2=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic2=[stand objectForKey:wtextIndex2];
        if (wDic2.count==1) {
            NSData *data=wDic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell8.center1Img.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex2.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center1Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell8.add1Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell8.center1Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl1=string;
            }else{
                if (wDic2.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic2[@"PictureURL"]];
                    [cell8.add1Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center1Img.image=[UIImage imageNamed:@""];
                    imageUrl1=string;
                }else{
                    cell8.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell8.center1Img.image=[UIImage imageNamed:@"中间"];
                    [cell8.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        [cell8.add2Button addTarget:self action:@selector(Cell8Add2Button:) forControlEvents:UIControlEventTouchUpInside];
        cell8.add2Button.tag=indexPath.row;
        NSString *wtextIndex3=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic3=[stand objectForKey:wtextIndex3];
        if (wDic3.count==1) {
            NSData *data=wDic3[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.add2Button setBackgroundImage:image forState:UIControlStateNormal];
            cell8.center2Img.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex3.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex3]) {
                    imageUrl2=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[2];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center2Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell8.add2Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell8.center2Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl2=string;
            }else{
                if (wDic3.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic3[@"PictureURL"]];
                    [cell8.add2Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center2Img.image=[UIImage imageNamed:@""];
                    imageUrl2=string;
                }else{
                    cell8.add2Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell8.center2Img.image=[UIImage imageNamed:@"中间"];
                    [cell8.add2Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        
        [cell8.add3Button addTarget:self action:@selector(Cell8Add3Button:) forControlEvents:UIControlEventTouchUpInside];
        cell8.add3Button.tag=indexPath.row;
        NSString *wtextIndex4=[NSString stringWithFormat:@"%ld4%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic4=[stand objectForKey:wtextIndex4];
        if (wDic4.count==1) {
            NSData *data=wDic4[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.add3Button setBackgroundImage:image forState:UIControlStateNormal];
            cell8.center3Img.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex4.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex4]) {
                    imageUrl3=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[3];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell8.add3Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.center3Img.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld4%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell8.add3Button setBackgroundImage:video forState:UIControlStateNormal];
                    cell8.center3Img.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld4%@video",indexPath.row+1,self.ScrapbookId];
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld4%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl3=string;
            }else{
                if (wDic4.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic4[@"PictureURL"]];
                    [cell8.add3Button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell8.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl3=string;
                }else{
                    cell8.add3Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell8.center3Img.image=[UIImage imageNamed:@"中间"];
                    [cell8.add3Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
        if ([wancheng isEqualToString:@"1"]) {
            
            //添加数据
            NSDictionary *image;
            NSDictionary *image1;
            NSDictionary *image2;
            NSDictionary *image3;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoIndex3=[NSString stringWithFormat:@"%ld4%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            NSString *VideoUrl2;
            NSString *VideoUrl3;
            for (int i=0; i<VideoArr.count; i++){
                NSString * String=[VideoArr[i] substringToIndex:VideoIndex.length];
                NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    VideoUrl1=[VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex2]) {
                    VideoUrl2=[VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex3]) {
                    VideoUrl3=[VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
                
            }
            NSString *imageUrl;
            NSString *imageUrl1;
            NSString *imageUrl2;
            NSString *imageUrl3;
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:wtextIndex2]) {
                    imageUrl1=[ImageArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:wtextIndex3]) {
                    imageUrl2=[ImageArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:wtextIndex4]) {
                    imageUrl3=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            //添加数据
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            
            if (VideoUrl2.length>9) {
                image2=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl2};
            }else{
                image2=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl2};
            }
            if (VideoUrl3.length>9) {
                image3=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl3};
            }else{
                image3=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl3};
            }
            
            NSArray *arr=@[image,image1,image2,image3];
            NSDictionary *zong=@{@"ModuleId":@"Module_4_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell8.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell8.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic2=[stand objectForKey:VideoIndex2];
        if (Videodic2.count>0) {
            cell8.center2Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex3=[NSString stringWithFormat:@"%ld4%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic3=[stand objectForKey:VideoIndex3];
        if (Videodic3.count>0) {
            cell8.center3Img.image=[UIImage imageNamed:@"zanting"];
        }
        return cell8;
    }
    else if ([currentString isEqualToString:@"Module_4_1"]){
        NSString * text;
        NSString * FontFamily;
        NSString * FontSize;
        NSString * Color;
        NSString * TextAlign;
        NSString *imageUrl;
        Seven1Cell *cell7 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid7" forIndexPath:indexPath];
        [cell7.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell7.leftButton.tag=indexPath.row;
        [cell7.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
        cell7.editButton.tag=indexPath.row;
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
        NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic=[stand objectForKey:wtextIndex];
        
        if (wDic.count>2) {
            
            cell7.bottomLabel.text=wDic[@"Text"];
            cell7.bottomLabel.font=[UIFont fontWithName:wDic[@"FontFamily"] size:[wDic[@"FontSize"] intValue]];
            cell7.bottomLabel.textColor=UIColorFromHex([wDic[@"Color"] intValue]);
            if ([wDic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell7.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([wDic[@"TextAlign"] isEqualToString:@"Left"]) {
                cell7.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }else{
                cell7.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
            
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            //            if (height>kWidth(15)) {
            cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), height);
            cell7.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
            //            }else{
            //                cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), kWidth(15));
            //                cell7.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kWidth(15));
            //            }
            
        }else{
            //文字展示
            NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
            NSArray * paraArr=DetailDic[@"Parameters"];
            NSDictionary *dic=paraArr[1];
            
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
                
                
                
                text=dic[@"Text"];
                FontFamily=dic[@"FontFamily"];
                FontSize=dic[@"FontSize"];
                TextAlign=dic[@"TextAlign"];
                Color=dic[@"Color"];
                
                CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
                //                if (height>kWidth(15)) {
                cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), height);
                cell7.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
                //                }else{
                //                    cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), kWidth(15));
                //                    cell7.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kWidth(15));
                //                }
                //保存从服务器返回的数据
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                [self setValueName:dic withKey:textIndex];
            }
        }
        [cell7 setLFL];
        //        添加图片按钮的操作
        [cell7.addButton addTarget:self action:@selector(Cell7AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell7.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell7.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell7.centerImg.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[1];
                if (dic1.count>2) {
                    dic1=paraArr[0];
                }else{
                    dic1=paraArr[1];
                }
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell7.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell7.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell7.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell7.centerImg.image=[UIImage imageNamed:@"zanting"];
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                    NSData *imageData = UIImagePNGRepresentation(video);
                    NSDictionary * dataDic=@{@"image":imageData};
                    [self setValueName:dataDic withKey:wtextIndex1];
                    NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    [self setValueName:dic1 withKey:textIndex1];

                    
                }
                imageUrl=string;
            }
            else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell7.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell7.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl=string;
                }else{
                    cell7.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell7.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell7.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
            
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoUrl;
            for (int i=0; i<VideoArr.count; i++){
                NSString * String=[VideoArr[i] substringToIndex:VideoIndex1.length];
                NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex1]) {
                    VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                }
            }
            
            NSString *imageUrl;
            
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            NSDictionary * wDic=[stand objectForKey:wtextIndex];
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
            //添加数据
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":@"TEXT",@"Text":text,@"TextAlign":TextAlign};
            
            NSArray *arr=@[image,headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_4_1",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell7.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        return cell7;
    }
    else if ([currentString isEqualToString:@"Module_5_1"]){
        NSString *urlStr;
        Nine1Cell *cell9 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid9" forIndexPath:indexPath];
        [cell9.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell9.leftButton.tag=indexPath.row;
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
        [cell9.addButton addTarget:self action:@selector(Cell9AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell9.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell9.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell9.centerImg.image=[UIImage imageNamed:@""];
            
            if ([wancheng isEqualToString:@"1"]) {
                
                NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                NSString *VideoUrl;
                for (int i=0; i<VideoArr.count; i++){
                    NSString * String=[VideoArr[i] substringToIndex:VideoIndex1.length];
                    NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    if ([String isEqualToString:VideoIndex1]) {
                        VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                    }
                }
                
                if (VideoUrl.length>9)
                {
                    
                    //添加数据
                    NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
                    NSArray *arr=@[image];
                    NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                    [pamaArr addObject:zong];
                    
                }else
                {
                    for (int i=0; i<ImageArr.count; i++) {
                        NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                        NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                        if ([String isEqualToString:wtextIndex1]) {
                            urlStr=[ImageArr[i] substringFromIndex:range.location];
                        }
                    }
                    //添加数据
                    NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":urlStr};
                    NSArray *arr=@[image];
                    NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                    [pamaArr addObject:zong];
                }
                
            }
        }else{
            
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9)
                {
                    [cell9.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell9.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell9.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell9.centerImg.image=[UIImage imageNamed:@"zanting"];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    
                                        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        NSData *imageData = UIImagePNGRepresentation(video);
                                        NSDictionary * dataDic=@{@"image":imageData};
                                        [self setValueName:dataDic withKey:wtextIndex1];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                //                [cell2.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                //                cell2.centerImg.image=[UIImage imageNamed:@""];
                //                NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                //                [self setValueName:dic1 withKey:textIndex1];
                if ([wancheng isEqualToString:@"1"]) {
                    //添加数据
                    NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                    NSString *VideoUrl;
                    for (int i=0; i<VideoArr.count; i++){
                        NSString * String=[VideoArr[i] substringToIndex:VideoIndex1.length];
                        NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                        if ([String isEqualToString:VideoIndex1]) {
                            VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                        }
                    }
                    
                    if (VideoUrl.length>9)
                    {
                        
                        //添加数据
                        NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
                        NSArray *arr=@[image];
                        NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                        [pamaArr addObject:zong];
                        
                    }else{
                        NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":string};
                        NSArray *arr=@[image];
                        NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                        [pamaArr addObject:zong];
                    }
                    
                    
                }
            }else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell9.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell9.centerImg.image=[UIImage imageNamed:@""];
                    if ([wancheng isEqualToString:@"1"]) {
                        //添加数据
                        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                        
                        NSString *VideoUrl;
                        for (int i=0; i<VideoArr.count; i++){
                            NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                            NSString * String=[VideoArr[i] substringToIndex:range.location];
                            if ([String isEqualToString:VideoIndex1]) {
                                VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                            }
                        }
                        
                        if (VideoUrl.length>9)
                        {
                            
                            //添加数据
                            NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
                            NSArray *arr=@[image];
                            NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                            [pamaArr addObject:zong];
                            
                        }else{
                            NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":string};
                            NSArray *arr=@[image];
                            NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                            [pamaArr addObject:zong];
                        }
                        
                    }
                }else{
                    cell9.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);;
                    cell9.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell9.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
                
            }
            
            
            
        }
        
        //添加视屏播放的按钮
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell9.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        return cell9;
    }
    else
    {
        NSString * text;
        NSString * FontFamily;
        NSString * FontSize;
        NSString * Color;
        NSString * TextAlign;
        NSString *imageUrl;
        Ten1Cell *cell10 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid10" forIndexPath:indexPath];
        [cell10.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell10.leftButton.tag=indexPath.row;
        [cell10.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
        cell10.editButton.tag=indexPath.row;
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
        NSString *wtextIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic=[stand objectForKey:wtextIndex];
        
        if (wDic.count>2) {
            
            cell10.bottomLabel.text=wDic[@"Text"];
            cell10.bottomLabel.font=[UIFont fontWithName:wDic[@"FontFamily"] size:[wDic[@"FontSize"] intValue]];
            
            cell10.bottomLabel.textColor=UIColorFromHex([wDic[@"Color"] intValue]);
            if ([wDic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell10.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([wDic[@"TextAlign"] isEqualToString:@"Left"]) {
                cell10.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }else{
                cell10.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
            text=wDic[@"Text"];
            FontFamily=wDic[@"FontFamily"];
            FontSize=wDic[@"FontSize"];
            TextAlign=wDic[@"TextAlign"];
            Color=wDic[@"Color"];
            
            CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
            //            if (height>kWidth(32)) {
            cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280), height);
            cell10.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
            //            }else{
            //                cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280),kWidth(32));
            //                cell10.bottomLabel.frame=CGRectMake(0, 0, kWidth(280),kWidth(32));
            //            }
            
        }else{
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
                
                
                
                text=dic[@"Text"];
                FontFamily=dic[@"FontFamily"];
                FontSize=dic[@"FontSize"];
                TextAlign=dic[@"TextAlign"];
                Color=dic[@"Color"];
                
                CGFloat height= [self createHeightWithString:text withFont:[FontSize intValue]];
                
                //                if (height>kWidth(32)) {
                cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280), height);
                cell10.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), height);
                //                }else{
                //                    cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280),kWidth(32));
                //                    cell10.bottomLabel.frame=CGRectMake(0, 0, kWidth(280),kWidth(32));
                //                }
                NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
                [self setValueName:dic withKey:textIndex];
            }
        }
        [cell10 setLFL];
        //        添加图片按钮的操作
        [cell10.addButton addTarget:self action:@selector(Cell10AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell10.addButton.tag=indexPath.row;
        NSString *wtextIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
        NSDictionary * wDic1=[stand objectForKey:wtextIndex1];
        if (wDic1.count==1) {
            NSData *data=wDic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell10.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell10.centerImg.image=[UIImage imageNamed:@""];
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
        }else{
            if ([changeNum isEqualToString:@"0"]) {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic1=paraArr[0];
                NSString * string=[NSString stringWithFormat:@"%@",dic1[@"PictureURL"]];
                if (string.length>9) {
                    [cell10.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell10.centerImg.image=[UIImage imageNamed:@""];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                }
                else
                {
                    NSString * string=[NSString stringWithFormat:@"%@",dic1[@"VideoURL"]];
                    UIImage * video=[UIImage thumbnailImageForVideo:[NSURL URLWithString:string] atTime:1];
                    [cell10.addButton setBackgroundImage:video forState:UIControlStateNormal];
                    cell10.centerImg.image=[UIImage imageNamed:@"zanting"];
                    NSString *wtextIndex1=[NSString stringWithFormat:@"%ld4%@image",indexPath.row+1,self.ScrapbookId];
                    NSData *imageData = UIImagePNGRepresentation(video);
                    NSDictionary * dataDic=@{@"image":imageData};
                    [self setValueName:dataDic withKey:wtextIndex1];
                                        NSString *textIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
                                        [self setValueName:dic1 withKey:textIndex1];
                    
                }
                imageUrl=string;
            }
            else{
                if (wDic1.count==2) {
                    NSString * string=[NSString stringWithFormat:@"%@",wDic1[@"PictureURL"]];
                    [cell10.addButton sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
                    cell10.centerImg.image=[UIImage imageNamed:@""];
                    imageUrl=string;
                }else{
                    cell10.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
                    cell10.centerImg.image=[UIImage imageNamed:@"中间"];
                    [cell10.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
            
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
            NSString *VideoUrl;
            for (int i=0; i<VideoArr.count; i++){
                NSString * String=[VideoArr[i] substringToIndex:VideoIndex1.length];
                NSRange range = [VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex1]) {
                    VideoUrl=[VideoArr[i] substringFromIndex:range.location];
                }
            }
            
            NSString *imageUrl;
            
            for (int i=0; i<ImageArr.count; i++) {
                NSString * String=[ImageArr[i] substringToIndex:wtextIndex1.length];
                NSRange range = [ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:wtextIndex1]) {
                    imageUrl=[ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":Color,@"FontFamily":FontFamily,@"FontSize":FontSize,@"ParameterType":@"TEXT",@"Text":text,@"TextAlign":TextAlign};
            
            NSArray *arr=@[image,headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_5_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.ScrapbookId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell10.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        return cell10;
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}
//item之间的空隙为0
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1" forIndexPath:indexPath];
        NSArray *lfla=[FCAppInfo shareManager].huabanArr;
        NSDictionary *dic2=lfla[11];
        NSString *url=dic2[@"BackgroundImage"];
        if (headerButton) {
            [headerButton removeFromSuperview];
            headerButton=nil;
        }
        headerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        headerButton.frame=CGRectMake(0, 0, self.view.bounds.size.width, kheigh(167));
        [headerButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [headerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [reusableView addSubview:headerButton];
        
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(kWidth(20), kheigh(167)-kheigh(57), APP_SCREEN_WIDTH-2*kWidth(20), kheigh(24));
        label.numberOfLines=0;
        NSDictionary * lfl=[self objectValueWith:[NSString stringWithFormat:@"%@headerText",self.ScrapbookId]];
        NSDictionary *wmy=[self objectValueWith:[NSString stringWithFormat:@"%@imageheader",self.ScrapbookId]];
        if (lfl.count>0) {
            if (wmy.count==1) {
                
                [headerButton setBackgroundImage:[UIImage imageWithData:wmy[@"image"]] forState:UIControlStateNormal];
            }
            else
            {
                if (wmy.count==2) {
                    
                    if ([self objectValueWith:wmy[@"image"]]) {
                        NSLog(@"you");
                        
                        UIImage *image = [UIImage imageWithData:[self objectValueWith:wmy[@"image"]]];
                        [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                        
                    }else{
                        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:wmy[@"image"]]]; //得到图像数据
                        UIImage *image = [UIImage imageWithData:imgData];
                        [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                        [self setValueName:imgData withKey:wmy[@"image"]];
                        imgData=nil;
                        image=nil;
                       
                        
                    }
                }else{
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
                        url=nil;
                        
                    }
                    
                }
                
                
            }
            if (lfl.count>1) {
                
                label.text=lfl[@"Text"];
                label.font=[UIFont systemFontOfSize:[lfl[@"Text"]intValue]];
                label.textColor=UIColorFromHex([lfl[@"Color"] intValue]);
                label.font=[UIFont fontWithName:lfl[@"FontFamily"] size:[lfl[@"FontSize"] intValue]];
                if ([lfl[@"TextAlign"] isEqualToString:@"Center"]) {
                    label.textAlignment=NSTextAlignmentCenter;
                }
                else if ([lfl[@"TextAlign"] isEqualToString:@"Left"]) {
                    label.textAlignment=NSTextAlignmentLeft;
                }else{
                    label.textAlignment=NSTextAlignmentRight;
                }
                
            }
            else
            {
                if (ModulesArr.count<1) {
                    
                }else{
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
                }
                
            }
            UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
            button1.frame=CGRectMake(kWidth(20), kheigh(167)-kheigh(57), APP_SCREEN_WIDTH-2*kWidth(20), kheigh(24));
            [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
            [headerButton addSubview:button1];
            
            [headerButton addSubview:label];
            
            if ([StartJQ isEqualToString:@"yes"])
            {
                [border removeFromSuperlayer];
                
            }
            else
            {
                
                border = [CAShapeLayer layer];
                //虚线的颜色
                border.strokeColor = UIColorFromHex(0xabced6).CGColor;
                //填充的颜色
                border.fillColor = [UIColor clearColor].CGColor;
                //设置路径
                border.path = [UIBezierPath bezierPathWithRect:label.bounds].CGPath;
                border.frame = label.bounds;
                //虚线的宽度
                border.lineWidth = 1.f;
                //设置线条的样式
                //    border.lineCap = @"square";
                //虚线的间隔
                border.lineDashPattern = @[@4, @2];
                [label.layer addSublayer:border];
            }
        }
        else
        {
            if (ModulesArr.count<1) {
                
            }else{
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
                    [headerButton addSubview:label];
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
                    [headerButton addSubview:label];
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
                        url=nil;
                        
                    }
                }
                
            }
            }
             [headerButton addSubview:label];
        
        
        return reusableView;
        
    }else{
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer1" forIndexPath:indexPath];
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
        return footerView;
    }
    
    
}
#pragma header添加图片
-(void)buttonClick{
    [FCAppInfo shareManager].isHeader=@"yes";
    [FCAppInfo shareManager].bili=320.0/167.0;
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)button1Click{
    NSLog(@"点击编辑标题");
    NoWork=@"0";
    NSDictionary * lfl=[self objectValueWith:[NSString stringWithFormat:@"%@headerText",self.ScrapbookId]];
    if (lfl.count>1) {
        EditViewController * edit=[[EditViewController alloc]init];
        edit.temID=self.ScrapbookId;
        edit.temID1=self.TemplateId;
        edit.isHeader=@"1";
        edit.text=lfl[@"Text"];
        edit.textfont=[lfl[@"FontSize"] intValue];
        edit.textcolor=[lfl[@"Color"] intValue];
        edit.texttextAlign=lfl[@"TextAlign"];
        edit.textfontName=lfl[@"FontFamily"];
        edit.modeId=@"Module_Header";
        [self.navigationController pushViewController:edit animated:YES];
    }else{
        NSDictionary *dic=ModulesArr[0];
        NSArray *paraArr=dic[@"Parameters"];
        NSDictionary *dic1=paraArr[0];
        
        EditViewController * edit=[[EditViewController alloc]init];
        edit.modeId=@"Module_Header";
        edit.temID=self.ScrapbookId;
        edit.isHeader=@"1";
        edit.text=dic1[@"Text"];
        edit.textfont=[dic1[@"FontSize"] intValue];
        edit.textcolor=[dic1[@"Color"] intValue];
        edit.texttextAlign=dic1[@"TextAlign"];
        edit.textfontName=dic1[@"FontFamily"];
        [self.navigationController pushViewController:edit animated:YES];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([wancheng isEqualToString:@"1"]) {
        return CGSizeMake(APP_SCREEN_WIDTH, 1);
    }else{
        NSString * currentString=ModuleIdArr[indexPath.row];
        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
        if ([currentString isEqualToString:@"Module_1_1"]) {
            
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.ScrapbookId];
            NSDictionary *dic=[stand objectForKey:textIndex];
            
            
            
            if (dic.count>2)
            {
                
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                NSLog(@"height==%f",height);
                return CGSizeMake(APP_SCREEN_WIDTH, height+kWidth(21));
                
                
            }else
            {
                NSDictionary *DetailDic=ModulesArr[indexPath.row+1];
                NSArray * paraArr=DetailDic[@"Parameters"];
                NSDictionary *dic=paraArr[0];
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                //                    if (height>kheigh(58)) {
                return CGSizeMake(APP_SCREEN_WIDTH, height+kWidth(21));

            }
        }
        else if([currentString isEqualToString:@"Module_1_2"]){
            
            
            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(217));
        }
        else if([currentString isEqualToString:@"Module_2_1"]){
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

                if (height>kWidth(15)) {
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)+height-kWidth(15));
                }else{
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)-height+kWidth(15));
                }
                
            }
            
        }
        else if([currentString isEqualToString:@"Module_4_2"]) {
            
            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(219));
        }
        else if([currentString isEqualToString:@"Module_5_1"]) {
            
            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(326));
        }
        else  {
        
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

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if ([wancheng isEqualToString:@"1"]) {
        return CGSizeMake(APP_SCREEN_WIDTH, 1);
    }else{
        return CGSizeMake(APP_SCREEN_WIDTH, kheigh(187));
    }
}
//尾部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if ([wancheng isEqualToString:@"1"]) {
        return CGSizeMake(APP_SCREEN_WIDTH, 1);
    }else{
        return CGSizeMake(APP_SCREEN_WIDTH, 60);
    }
}
-(void)ButtonClick:(UIButton*)sender{
    
    if ([IsBack isEqualToString:@"1"]) {
        
    }
    else
    {
        NSString * string=[NSString stringWithFormat:@"%ld",(long)sender.tag];
        
        if ([string isEqualToString:@"0"]) {
            NewHBViewController *new=[[NewHBViewController alloc]init];
            [self.navigationController pushViewController:new animated:YES];
        }
        else{
            
            [self createButton];
            
        }
        
    }
    
}
//点击 删除某一模块  原理是 删除我们点击的当前页面所对应的key。开始遍历所有包含text的key，将所选的位置和遍历的位置比较，当所选的位置在前的时候，所有的位置都向上移一位。 并且删除之前的位置上的东西
-(void)LeftButton:(UIButton*)sender{
    NSLog(@"点击删除%ld这一页",(long)sender.tag);
    NSLog(@"--%@",ModuleIdArr);
    changeNum=@"1";
    NoWork=@"0";
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    
    //    删除文字部分
    
    NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",sender.tag+1,self.ScrapbookId];
    //    NSString *imageIndex=[NSString stringWithFormat:@"%ld%@image",sender.tag+1,self.ScrapbookId];
    //    NSString *videoIndex=[NSString stringWithFormat:@"%ld%@video",sender.tag+1,self.ScrapbookId];
    [stand removeObjectForKey:textIndex];
    
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys])
    {
        if ([key containsString:[NSString stringWithFormat:@"%@text",self.ScrapbookId]]) {
            NSRange range = [key rangeOfString:self.ScrapbookId];
            NSString *str = [key substringToIndex:range.location];
            NSString * index=[key substringToIndex:str.length];
            if (sender.tag+1<[index intValue]) {
                NSString *nextIndex=[NSString stringWithFormat:@"%d%@text",[index intValue]-1,self.ScrapbookId];
                NSString *Index=[NSString stringWithFormat:@"%d%@text",[index intValue],self.ScrapbookId];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [stand setObject:dictionary[key] forKey:nextIndex];
                });
                [stand removeObjectForKey:Index];
                [stand synchronize];
            }
            
        }
        
        //   删除图片部分
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld",sender.tag+1];
        NSString *first=[key substringToIndex:ImageIndex.length];
        if ([ImageIndex isEqualToString:first]) {
            [stand removeObjectForKey:key];
            
        }
    }
    
    
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@image",self.ScrapbookId]]&&![key containsString:[NSString stringWithFormat:@"%@imageheader",self.ScrapbookId]]) {
            NSLog(@"key==%@=ScrapbookId=%@",key,_ScrapbookId);
            NSRange range = [key rangeOfString:self.ScrapbookId];
            NSString *str = [key substringToIndex:range.location-1];
            
            NSString *first=[key substringToIndex:str.length];
            NSString * other=[key substringFromIndex:str.length];
            if (sender.tag+1<[first intValue])
            {
                NSString *nextIndex11=[NSString stringWithFormat:@"%d",[first intValue]-1];
                
                NSString *new=[NSString stringWithFormat:@"%@%@",nextIndex11,other];
                
                NSString *Index11=[NSString stringWithFormat:@"%d%@",[first intValue],other];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"new==%@",new);
                    [stand setObject:dictionary[key] forKey:new];
                    
                    //                    [stand synchronize];
                });
                [stand removeObjectForKey:Index11];
                
                
                
                
            }
        }
        if ([key containsString:[NSString stringWithFormat:@"%@video",self.ScrapbookId]]) {
            NSLog(@"key==%@",key);
            NSRange range = [key rangeOfString:self.ScrapbookId];
            NSString *str = [key substringToIndex:range.location-1];
            NSString *first=[key substringToIndex:str.length];
            NSString * other=[key substringFromIndex:str.length];
            if (sender.tag+1<[first intValue])
            {
                NSString *nextIndex11=[NSString stringWithFormat:@"%d",[first intValue]-1];
                
                NSString *new=[NSString stringWithFormat:@"%@%@",nextIndex11,other];
                
                NSString *Index11=[NSString stringWithFormat:@"%d%@",[first intValue],other];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [stand setObject:dictionary[key] forKey:new];
                });
                [stand removeObjectForKey:Index11];
                //                [stand synchronize];
                
                
                
            }
        }
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->ModuleIdArr removeObjectAtIndex:sender.tag];
        [self.DataCollectionView reloadData];
    });
    
}



-(void)EditButton:(UIButton*)sender{
    NoWork=@"0";
    NSLog(@"点击编辑文字%ld",(long)sender.tag);
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",sender.tag+1,self.ScrapbookId];
    NSDictionary *dic=[stand objectForKey:textIndex];
    NSString *text=  dic[@"Text"];
    
    NSString *key=[NSString stringWithFormat:@"%ld",sender.tag+1];
    EditViewController * edit=[[EditViewController alloc]init];
    edit.modeId=ModuleIdArr[sender.tag];
    edit.temID=self.ScrapbookId;
    
    edit.isHeader=@"0";
    edit.keyStr=key;
    edit.text=text;
    edit.textfont=[dic[@"FontSize"] intValue];
    edit.textcolor=[dic[@"Color"] intValue];
    edit.texttextAlign=dic[@"TextAlign"];
    edit.textfontName=dic[@"FontFamily"];
    [self.navigationController pushViewController:edit animated:YES];
    
}
-(void)createButton{
    changeNum=@"1";
    NoWork=@"0";
    NSString * currentindex=[NSString stringWithFormat:@"%lu%@text",(unsigned long)ModuleIdArr.count+1,self.ScrapbookId];
    
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    [guideAnimationView removeFromSuperview];
    ChooseMViewController *choose=[[ChooseMViewController alloc]init];
    [choose setMyBlock:^(NSString *index,NSString*ModuleId) {
        
        // 采用随机生成的诗句或者美句。
        if ([ModuleId isEqualToString:@"Module_1_2"]||[ModuleId isEqualToString:@"Module_4_2"]||[ModuleId isEqualToString:@"Module_5_1"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->ModuleIdArr addObject:ModuleId];
                [self.DataCollectionView reloadData];
                [self.DataCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self->ModuleIdArr.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            });
        }
        else
        {
            NSArray * currentA=[FCAppInfo shareManager].pDic[ModuleId];
            int y =(arc4random() % currentA.count);
            
            NSString *TextIndex=currentA[y];
            NSString *font1=@"15";
            NSString *font=@"1";
            NSDictionary *tdic=[self objectValueWith:[NSString stringWithFormat:@"%@tlist",self.TemplateId]];
            //            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"font":font,@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            [stand setObject:dic forKey:currentindex];
            [stand synchronize];
            NSLog(@"--%@",ModuleId);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->ModuleIdArr addObject:ModuleId];
                [self.DataCollectionView reloadData];
                [self.DataCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self->ModuleIdArr.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            });
        }
        
        
    }];
    
    [self.navigationController pushViewController:choose animated:YES];
}
//-(void)show2{
//    [guideAnimationView removeFromSuperview];
//}

#pragma mark - 添加图片
-(void)addImageviewTap
{
    NoWork=@"0";
    [FCAppInfo shareManager].isFrom=@"1";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        self->ChooseView.hidden=NO;
    }];
    
    UIAlertAction *takePic = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [FCAppInfo shareManager].FromVC=@"hand";
                                  self->chooseImg=YES;
                                  self->chooseVideo=NO;
                                  [self takePhoto];
                              }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [FCAppInfo shareManager].FromVC=@"hand";
                                self->chooseImg=YES;
                                self->chooseVideo=NO;
                                [self localPhoto];
                            }];
    UIAlertAction *video = [UIAlertAction actionWithTitle:@"选择视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                self->chooseVideo=YES;
                                self->chooseImg=NO;
                                [self chooseVideo];
                            }];
    [alert addAction:takePic];
    [alert addAction:photo];
    if ([[FCAppInfo shareManager].isHeader isEqualToString:@"yes"]) {
        
    }else{
        [alert addAction:video];
    }
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}
//开始拍照
-(void)takePhoto{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    }];
    [AVCaptureDevice requestAccessForMediaType:
     AVMediaTypeVideo completionHandler:^(BOOL granted)
     {//相机权限
         if (granted)
         {
             [self performSelectorOnMainThread:@selector(goCamera) withObject:nil waitUntilDone:YES];
         } else{
             [self performSelectorOnMainThread:@selector(showCameraAlerView) withObject:nil waitUntilDone:YES];
             
         }}
     ];
}
-(void)goCamera
{
    TakePhotoViewController *uitpVC = [TakePhotoViewController new];
    uitpVC.takePhotoBlock = ^(UIImage *photoImage) {
        
        NSLog(@"%@",photoImage);
    };
    [self presentViewController:uitpVC animated:NO completion:nil];
    [FCAppInfo shareManager].isfromPhoto=@"no";
    //     [self openImagePickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
}
//打开相册，可以多选
-(void)localPhoto{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
            [self performSelectorOnMainThread:@selector(openCamera) withObject:nil waitUntilDone:YES];
        }else
        {
            [self performSelectorOnMainThread:@selector(showPhotoAlerView) withObject:nil waitUntilDone:YES];
            
        }
    }];
}
-(void)showCameraAlerView
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在设置-隐私-相机中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
            [[UIApplication sharedApplication] openURL:url];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)showPhotoAlerView
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在设置-隐私-相册中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            //如果点击打开的话，需要记录当前的状态，从设置回到应用的时候会用到
            [[UIApplication sharedApplication] openURL:url];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
//打开相册
- (void)openCamera
{
    [FCAppInfo shareManager].isfromPhoto=@"yes";
    [self openImagePickerControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}


/// 打开ImagePickerController的方法
- (void)openImagePickerControllerWithType:(UIImagePickerControllerSourceType)type
{
    // 设备不可用  直接返回
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    _imgPicker = [[UIImagePickerController alloc] init];
    _imgPicker.sourceType = type;
    _imgPicker.delegate = self;
    _imgPicker.allowsEditing = NO;
    [self presentViewController:_imgPicker animated:YES completion:nil];
}

//选择视频
-(void)chooseVideo{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    }];
    [AVCaptureDevice requestAccessForMediaType:
     AVMediaTypeVideo completionHandler:^(BOOL granted)
     {//相机权限
         if (granted)
         {
             [self performSelectorOnMainThread:@selector(goVideo) withObject:nil waitUntilDone:YES];
         } else{
             [self performSelectorOnMainThread:@selector(showCameraAlerView) withObject:nil waitUntilDone:YES];
             
         }}
     ];
}
-(void)goVideo{
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[UIColorFromHex(0x252a85), UIColorFromHex(0x122e56)] gradientType:GradientTypeUpleftToLowright imgSize:self.navigationController.navigationBar.frame.size];
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    if ([ipc.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [ipc.navigationBar setBarTintColor:[UIColor colorWithPatternImage:bgImg]];
        [ipc.navigationBar setTranslucent:NO];
        [ipc.navigationBar setTintColor:[UIColor whiteColor]];
    }else{
        [ipc.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [ipc.navigationBar setTitleTextAttributes:attrs];
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
}
#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
// 选择照片之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (chooseImg)
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        UIImage * naorImg= [image fixOrientation];
        [self cropImage:naorImg];
    }
    else{
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *stringUrl=[NSString stringWithFormat:@"%@",sourceURL];
        NSData *data = [NSData dataWithContentsOfURL:sourceURL];
        NSLog(@"--%@--%lu",sourceURL,data.length/1024);
        if ([self getPictureData]+data.length/1024>1024*[[FCAppInfo shareManager].MaxXian intValue]) {
            [picker dismissViewControllerAnimated:YES completion:nil];
            [self showMessage:@"图片或视频过大"];
            
        }else{
            videoImage= [self getVideoPreViewImageWithPath:sourceURL];
            NSData * imageData= UIImageJPEGRepresentation(videoImage, 1);
            NSString *zuiIndex=[NSString stringWithFormat:@"%@%@%@image",lflimage,image1,self.ScrapbookId];
            NSString *zuiIndex1=[NSString stringWithFormat:@"%@%@%@video",lflimage,image1,self.ScrapbookId];
            NSDictionary * dic=@{@"image":imageData};
            NSDictionary * dic1=@{@"image":stringUrl};
            NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
                [stand setObject:dic forKey:zuiIndex];
                [stand setObject:dic1 forKey:zuiIndex1];
                [stand synchronize];
            });
            
            [picker dismissViewControllerAnimated:YES completion:^{
            }];
        }
        
    }
    
    
    
}

- (void)cropImage: (UIImage *)image {
    AlbumDetailsViewController *viewController = [[AlbumDetailsViewController alloc] init];
    viewController.image = image;
    
    [_imgPicker presentViewController:viewController animated:NO completion:nil];
    viewController.pictureSelectedBlock = ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    };
}

#pragma 点击添加图片按钮
-(void)Cell2AddButton:(UIButton*)sender{
    NSLog(@"cell2=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili2;
    [self addImageviewTap];
    
}
-(void)Cell3AddButton:(UIButton*)sender{
    NSLog(@"cell3=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili31;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell3Add1Button:(UIButton*)sender{
    NSLog(@"cell3=2=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili32;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell4AddButton:(UIButton*)sender{
    NSLog(@"cell4=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili4;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell5AddButton:(UIButton*)sender{
    NSLog(@"cell5=2=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili5;
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell5Add1Button:(UIButton*)sender{
    NSLog(@"cell5=2=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili5;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell5Add2Button:(UIButton*)sender{
    NSLog(@"cell5=3=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili5;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"3";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell6AddButton:(UIButton*)sender{
    NSLog(@"cell6=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili61;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell6Add1Button:(UIButton*)sender{
    NSLog(@"cell6=2=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili62;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell6Add2Button:(UIButton*)sender{
    NSLog(@"cell6=3=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili61;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"3";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8AddButton:(UIButton*)sender{
    NSLog(@"cell8=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8Add1Button:(UIButton*)sender{
    NSLog(@"cell8=2=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8Add2Button:(UIButton*)sender{
    NSLog(@"cell8=3=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"3";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8Add3Button:(UIButton*)sender{
    NSLog(@"cell8=4=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"4";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell7AddButton:(UIButton*)sender{
    NSLog(@"cell7=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].isHeader=@"no";
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili7;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell9AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell9=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili9;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell10AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell10=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili10;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
//获取视频的第一帧截图, 返回UIImage
//需要导入AVFoundation.h
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

#pragma 上传图片到OSS
-(void)loadPictureToken{
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:getOssStsToken WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        //        NSLog(@"获取上传图片的token%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            self.accessKeyId=dataDic[@"AccessKeyId"];
            self.accessKeySecret=dataDic[@"AccessKeySecret"];
            self.securityToken=dataDic[@"SecurityToken"];
            self.buketName=dataDic[@"BucketName"];
            self.AccessDomain=dataDic[@"AccessDomain"];
            self.EndPoint=dataDic[@"EndPoint"];
            [self lfl];
        }
        else if ([msgStr isEqualToString:@"0"])
        {
            [self getNewToken];
            self->IsBack=@"0";
            
        }
        else if ([msgStr isEqualToString:@"-1"])
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            self->IsBack=@"0";
            
        }
        else if ([msgStr isEqualToString:@"-2"])
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            self->IsBack=@"0";
            
        }
        else if ([msgStr isEqualToString:@"-3"])
        {
            [self gotoLogin];
            
        }
        else
        {
            [self showMessage:[obj objectForKey:@"Msg"]];
            self->IsBack=@"0";
            
        }
        
        
    } withfail:^(NSString *errorMsg) {
        
    }];
}
-(void)uploadPictureOSS:(NSString*)imageName{
    self.BobjectKey=[NSString createUuid];
    
    NSDictionary *dic = [self objectValueWith:imageName];
    NSData *data=dic[@"image"];
    NSString *endpoint =[NSString stringWithFormat:@"https://%@",self.EndPoint] ;
    // 明文设置secret的方式建议只在测试时使用，更多鉴权模式请参考后面的`访问控制`章节
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:self.accessKeyId secretKeyId:self.accessKeySecret securityToken:self.securityToken];
    
    //设置网络请求的一些参数
    OSSClientConfiguration * conf=[OSSClientConfiguration new];
    
    //最大重试次数
    conf.maxRetryCount=3;
    
    conf.timeoutIntervalForRequest=30;// 网络请求的超时时间
    
    OSSClient* client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // 必填字段
    put.bucketName = self.buketName;
    put.objectKey =[NSString stringWithFormat:@"%@.png",self.BobjectKey];
    put.uploadingData=data;
    NSString * picUrl=[NSString stringWithFormat:@"%@%@%@.png",imageName,self.AccessDomain,self.BobjectKey];
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->AlerayldData+=(bytesSent/1024);
            NSString *string=[NSString stringWithFormat:@"%f%%",(self->AlerayldData/self->SumData)];
            self.circleView.percent=[string floatValue];
            if ([string floatValue]==1) {
                
                 self.circleView=nil;
                [self.circleView removeFromSuperview];
            }else{
                
            }
        });
    };
    
    OSSTask * putTask = [client putObject:put];
    //[putTask waitUntilFinished]; // 阻塞直到上传完成
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            
            //            OSSPutObjectResult * result = task.result;
            
            [self->ImageArr addObject:picUrl];
            NSLog(@"-上传图片的数量-%lu--%d",(unsigned long)self->ImageArr.count,self->ZongSum);
            if (self->ImageArr.count==self->ZongSum&&self->VideoArr.count==self->SureSum) {
                
                [self startWork];
            }
        } else {
            NSLog(@"upload object failed, error: 0000000000000000%@" , task.error);
            
        }
        return nil;
    }];
    
    
}
#pragma 获取呈记详情
-(void)loadData{
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
    ChooseView.hidden=NO;
    self.background.hidden=YES;
    self.pickerBgView.hidden=YES;
}
-(void)uploadVideoOSS:(NSString*)imageName{
    self.BobjectKey=[NSString createUuid];
    
    NSDictionary *dic = [self objectValueWith:imageName];
    NSString *dataStr=dic[@"image"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dataStr]]; //可以使用上传到服务器或者其他的
    
    NSString *endpoint =[NSString stringWithFormat:@"https://%@",self.EndPoint] ;
    // 明文设置secret的方式建议只在测试时使用，更多鉴权模式请参考后面的`访问控制`章节
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:self.accessKeyId secretKeyId:self.accessKeySecret securityToken:self.securityToken];
    
    //设置网络请求的一些参数
    OSSClientConfiguration * conf=[OSSClientConfiguration new];
    
    //最大重试次数
    conf.maxRetryCount=3;
    
    conf.timeoutIntervalForRequest=30;// 网络请求的超时时间
    
    OSSClient* client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // 必填字段
    put.bucketName = self.buketName;
    put.objectKey =[NSString stringWithFormat:@"%@.mp4",self.BobjectKey];
    put.uploadingData=data;
    
    
    NSString * videoUrl=[NSString stringWithFormat:@"%@%@%@.mp4",imageName,self.AccessDomain,self.BobjectKey];
    //
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        dispatch_async(dispatch_get_main_queue(), ^{
            self->AlerayldData+=(bytesSent/1024);
            
            NSString *string=[NSString stringWithFormat:@"%f%%",(self->AlerayldData/self->SumData)];
            self.circleView.percent=[string floatValue];
            if ([string floatValue]==1) {
                
                self.circleView=nil;
                [self.circleView removeFromSuperview];
            }else{
                
            }
        });
    };
    
    OSSTask * putTask = [client putObject:put];
    //[putTask waitUntilFinished]; // 阻塞直到上传完成
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            
            //            OSSPutObjectResult * result = task.result;
            
            [self->VideoArr addObject:videoUrl];
            NSLog(@"-上传视频的数量-%lu--%d",(unsigned long)self->VideoArr.count,self->SureSum);
            if (self->ImageArr.count==self->ZongSum&&self->VideoArr.count==self->SureSum) {
                
                [self startWork];
            }
        } else {
            NSLog(@"upload object failed, error: 0000000000000000%@" , task.error);
            
        }
        return nil;
    }];
    
    
}
#pragma 获取所有上传图片的大小
-(CGFloat)getPictureData{
    CGFloat sumFloat=0;
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@image",self.ScrapbookId]]) {
            NSDictionary *dic = [self objectValueWith:key];
            NSData *data=dic[@"image"];
            CGFloat scout=data.length/1024;
            sumFloat+=scout;
        }else if([key containsString:[NSString stringWithFormat:@"%@video",self.ScrapbookId]]){
            NSDictionary *dic = [self objectValueWith:key];
            NSString *data=dic[@"image"];
            if ([data hasPrefix:@"https"]) {
                
            }else{
                NSData *numdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:data]];
                CGFloat scout=numdata.length/1024;
                sumFloat+=scout;
            }
            
        }
        
    }
    NSLog(@"--%f",sumFloat);
    return sumFloat;
}

//判断网络状态
- (void)findNetWorkStatus
{
    ZongSum=0;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
                NSLog(@"GPRS网络");
                break;
            case 2:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        if (status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            int sum=0;
            int sumimage=0;
            NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
            NSDictionary *dictionary = [stand dictionaryRepresentation];
            for(NSString *key in [dictionary allKeys]){
                if ([key containsString:[NSString stringWithFormat:@"%@image",self.ScrapbookId]]) {
                    sumimage+=1;
                }
                
            }
            
            //遍历查询应该有几个图片
            for (NSString * string in self->ModuleIdArr) {
                if ([string isEqualToString:@"Module_1_1"]) {
                    sum+=0;
                }else if ([string isEqualToString:@"Module_1_2"]) {
                    sum+=1;
                }
                else if ([string isEqualToString:@"Module_2_1"]) {
                    sum+=2;
                }
                else if ([string isEqualToString:@"Module_2_2"]) {
                    sum+=1;
                }
                else if ([string isEqualToString:@"Module_3_1"]) {
                    sum+=3;
                }
                else if ([string isEqualToString:@"Module_3_2"]) {
                    sum+=3;
                }
                else if ([string isEqualToString:@"Module_4_1"]) {
                    sum+=1;
                }
                else if ([string isEqualToString:@"Module_4_2"]) {
                    sum+=4;
                }
                else if ([string isEqualToString:@"Module_5_2"]) {
                    sum+=1;
                }
                else if ([string isEqualToString:@"Module_5_1"]) {
                    sum+=1;
                }
            }
            
            NSLog(@"sum==%d===sumimage=%d",sum,sumimage);
            if (sum>sumimage) {
                [self showMessage:@"存在未上传图片或视频"];
                self->isClick=@"1";
                self->StartJQ=@"no";
                self->IsBack=@"0";
//                [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                 [self.DataCollectionView reloadData];
                return;
            }
            if (sum==0) {
                [self showMessage:@"至少上传一张图片"];
                self->isClick=@"1";
                self->StartJQ=@"no";
                self->IsBack=@"0";
//                [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                 [self.DataCollectionView reloadData];
                return ;
            }
            
            self->ZongSum=sumimage;
            [self loadPictureToken];
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你当前处于非WIFI环境下，提交将会使用手机流量，确定继续？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                int sum=0;
                int sumimage=0;
                NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
                NSDictionary *dictionary = [stand dictionaryRepresentation];
                for(NSString *key in [dictionary allKeys]){
                    if ([key containsString:[NSString stringWithFormat:@"%@image",self.ScrapbookId]]) {
                        sumimage+=1;
                    }
                    
                }
                
                //遍历查询应该有几个图片
                for (NSString * string in self->ModuleIdArr) {
                    if ([string isEqualToString:@"Module_1_1"]) {
                        sum+=0;
                    }else if ([string isEqualToString:@"Module_1_2"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"Module_2_1"]) {
                        sum+=2;
                    }
                    else if ([string isEqualToString:@"Module_2_2"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"Module_3_1"]) {
                        sum+=3;
                    }
                    else if ([string isEqualToString:@"Module_3_2"]) {
                        sum+=3;
                    }
                    else if ([string isEqualToString:@"Module_4_1"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"Module_4_2"]) {
                        sum+=4;
                    }
                    else if ([string isEqualToString:@"Module_5_2"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"Module_5_1"]) {
                        sum+=1;
                    }
                }
                
                NSLog(@"sum==%d===sumimage=%d",sum,sumimage);
                if (sum>sumimage) {
                    [self showMessage:@"存在未上传图片或视频"];
                    self->isClick=@"1";
                    self->StartJQ=@"no";
                    self->IsBack=@"0";
//                    [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                     [self.DataCollectionView reloadData];
                    return;
                }
                if (sum==0) {
                    [self showMessage:@"至少上传一张图片"];
                    self->isClick=@"1";
                    self->StartJQ=@"no";
                    self->IsBack=@"0";
//                    [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                     [self.DataCollectionView reloadData];
                    return ;
                }
                self->ZongSum=sumimage;
                [self loadPictureToken];
                
            }];
            UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                self->isClick=@"1";
                self->StartJQ=@"no";
                self->IsBack=@"0";
//                [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                 [self.DataCollectionView reloadData];
            }];
            [alertController addAction:confirm];
            [alertController addAction:cance];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}
//开始调用接口
-(void)startWork{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self->hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self->hud setOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN)];
        NSLog(@"--%@",self->ImageArr);
        [self.DataCollectionView reloadData];
        [self performSelector:@selector(upDetail) withObject:self afterDelay:0.5];
    });
    
    
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
//获取view页面
- (UIImage *)captureWithFrame
{
    
    // 创建一个context
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    
    //把当前的全部画面导入到栈顶context中并进行渲染
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 从当前context中创建一个新图片
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    CGRect rect=CGRectMake(0, HEIGHT_TOP_MARGIN, APP_SCREEN_WIDTH, kWidth(166));
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGFloat x= rect.origin.x*scale;
    
    CGFloat y=rect.origin.y*scale;
    
    CGFloat w=rect.size.width*scale;
    
    CGFloat h=rect.size.height*scale;
    
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    
    
    //截取部分图片并生成新图片
    
    CGImageRef sourceImageRef = [img CGImage];
    
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    
    UIImage * lfl = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    //返回剪裁后的图片
    NSData *data = UIImageJPEGRepresentation(lfl, 1);
    
    [self setValueName:@{@"image":data} withKey:[NSString stringWithFormat:@"jianqie%@image",self.ScrapbookId]];
    //    UIImageWriteToSavedPhotosAlbum(lfl, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    return lfl;
}

//保存完成回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    NSLog(@"%@",msg);
}
@end
