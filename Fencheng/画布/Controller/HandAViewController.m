//
//  HandAViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/5/29.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "HandAViewController.h"
#import "AlbumViewController.h"
#import "AlbumDetailsViewController.h"
#import "TakePhotoViewController.h"
#import "ChooseMViewController.h"
#import "ChooseBViewController.h"
#import "EditViewController.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "FourCell.h"
#import "FiveCell.h"
#import "SixCell.h"
#import "SevenCell.h"
#import "RightCell.h"
#import "NineCell.h"
#import "TenCell.h"
#import <Photos/Photos.h>
//李发林
#import <UIImage+GIF.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FCTabBarViewController.h"
#import "header.h"
#import "LFLView.h"
#import "NewHBViewController.h"
@interface HandAViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout,TencentSessionDelegate>{
    UIView * guideAnimationView;
    UIView * ChooseView;
//    NSString *Currentstring;
//    UIImage *CurrentImage;
    NSDictionary *textAttribute;
    //测试
   
    NSString * lflimage; //看他是第几item
    
    NSString * image1;   //看他是第几item中的第几
    
//    NSArray * goodIdea;
    
    BOOL chooseImg;
    BOOL chooseVideo;
    
    UIImage *videoImage;
    
    NSString * wancheng;
    NSString * jiazai;
    NSMutableArray * pamaArr;
    
//    沙盒里面存在的总数据
    NSMutableArray * zongArr;
    MBProgressHUD *hud;
    
    NSString *yunxu;
    TencentOAuth *tencentOAuth;
    NSString *isClick;
    
    float YSVideo;
    NSString * isOne;
     MBProgressHUD *progressHUD;
    
    int ZongSum;
    int sum;
    
    int SureSum;
    float SumData;
    float AlerayldData;
    int gifCount;
    
    UITapGestureRecognizer *tapGes;
    
    NSString *StartJQ;
    CAShapeLayer *border;
    
     NSString *IsBack;
    UICollectionReusableView* reusableView;
    UIButton *button;
    UIButton *headerButton;

    NSString * currentImage;
    UIButton *TBbutton;
}





@property(nonatomic,strong)UICollectionView * DataCollectionView;
@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property (nonatomic,strong)NSMutableArray * dataNumberArr;
@property (nonatomic,strong)NSMutableArray * ModuleIdArr;
@property (nonatomic,strong)NSMutableArray * ImageArr;
@property (nonatomic,strong)NSMutableArray * VideoArr;
@property (nonatomic,strong)NSMutableArray * GIFArr;
@property(nonatomic,strong)NSString *accessKeyId;
@property(nonatomic,strong)NSString *accessKeySecret;
@property(nonatomic,strong)NSString *securityToken;
@property(nonatomic,strong)NSString *buketName;
@property(nonatomic,strong)NSString *AccessDomain;
@property(nonatomic,strong)NSString *EndPoint;
@property(nonatomic,strong)NSString *BobjectKey;
@property(nonatomic,strong)NSString *SobjectKey;
@property(nonatomic,strong)NSData * qietuData;
@property (nonatomic,strong)UIView *background;
@property (nonatomic,strong)UIView *pickerBgView;
@property (nonatomic, weak) LFLView *circleView;
@property (nonatomic, strong) UIImage *shareImg;

@end
@implementation HandAViewController
-(NSMutableArray *)dataNumberArr{
    if (!_dataNumberArr) {
        _dataNumberArr = [NSMutableArray arrayWithCapacity:0];
    }
    // 赋值处理 ...
    return _dataNumberArr;
}
-(NSMutableArray *)ModuleIdArr{
    if (!_ModuleIdArr) {
        _ModuleIdArr = [NSMutableArray arrayWithCapacity:0];
    }
    // 赋值处理 ...
    return _ModuleIdArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    NSString * radom=[NSString createUuid];
    self.view.backgroundColor=[UIColor whiteColor];
   
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    [self confinRightItemWithImg:[UIImage imageNamed:@"edityes"]];
    yunxu=@"1";
    [FCAppInfo shareManager].temID=radom;
    self.TemplateId=radom;
    _ImageArr = [NSMutableArray arrayWithCapacity:0];
    pamaArr=[NSMutableArray arrayWithCapacity:0];
    _VideoArr = [NSMutableArray arrayWithCapacity:0];
    _GIFArr = [NSMutableArray arrayWithCapacity:0];
    chooseVideo=NO;
    chooseImg=NO;
    lflimage=@"0";
    image1=@"0";
    

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _DataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) collectionViewLayout:layout];
    
//    _DataCollectionView.backgroundView.alpha=0;
    _DataCollectionView.dataSource = self;
    _DataCollectionView.delegate = self;
    _DataCollectionView.hidden=YES;
    _DataCollectionView.showsVerticalScrollIndicator=YES;
    _DataCollectionView.backgroundColor=[UIColor whiteColor];
    [_DataCollectionView registerClass:[OneCell class] forCellWithReuseIdentifier:@"cellid1"];
    [_DataCollectionView registerClass:[TwoCell class] forCellWithReuseIdentifier:@"cellid2"];
    [_DataCollectionView registerClass:[ThreeCell class] forCellWithReuseIdentifier:@"cellid3"];
    [_DataCollectionView registerClass:[FourCell class] forCellWithReuseIdentifier:@"cellid4"];
    [_DataCollectionView registerClass:[FiveCell class] forCellWithReuseIdentifier:@"cellid5"];
    [_DataCollectionView registerClass:[SixCell class] forCellWithReuseIdentifier:@"cellid6"];
    [_DataCollectionView registerClass:[SevenCell class] forCellWithReuseIdentifier:@"cellid7"];
    [_DataCollectionView registerClass:[RightCell class] forCellWithReuseIdentifier:@"cellid8"];
    [_DataCollectionView registerClass:[NineCell class] forCellWithReuseIdentifier:@"cellid9"];
    [_DataCollectionView registerClass:[TenCell class] forCellWithReuseIdentifier:@"cellid10"];
    [_DataCollectionView registerClass:[header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    [_DataCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer1"];
    [self.view addSubview:_DataCollectionView];
    
    
    [self didlfl];
    [self createUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeImage:) name:@"PicutreFromAlbum" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gifwmy) name:@"gifwmy" object:nil];
    
    [FCAppInfo shareManager].changeHB=@"11";
    
}
-(void)didlfl{
    
    _DataCollectionView.hidden=NO;
    
    NSArray *arr= [self objectValueWith:[NSString stringWithFormat:@"%@textNumArr",self.TemplateId]];
    NSArray *IDarr= [self objectValueWith:[NSString stringWithFormat:@"%@ModuleIdArr",self.TemplateId]];
    if (arr) {
        
        _dataNumberArr=[NSMutableArray arrayWithArray:arr];
        _ModuleIdArr=[NSMutableArray arrayWithArray:IDarr];
    }else{
        
        NSArray *arr1=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
        _dataNumberArr=[NSMutableArray arrayWithArray:arr1];
        NSArray*Arr=@[@"Module_1_1",@"Module_1_2",@"Module_2_1",@"Module_2_2",@"Module_3_1",@"Module_3_2",@"Module_4_1",@"Module_4_2",@"Module_5_1",@"Module_5_2"];
        _ModuleIdArr=[NSMutableArray arrayWithArray:Arr];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.DataCollectionView reloadData];
    });
    
    
   
}
-(void)popLeftItemView
{
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    if ([IsBack isEqualToString:@"1"]) {
        
    }
    else
    {
         [self.DataCollectionView setContentOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN) animated:YES];
        
        NSMutableArray * arr=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray * lflArr=[NSMutableArray arrayWithCapacity:0];
        lflArr=[self objectValueWith:@"DraftArr"];
        NSMutableArray *arr1=[NSMutableArray arrayWithArray:lflArr];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否保存到草稿" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->StartJQ=@"yes";
            [self.DataCollectionView reloadData];
            [self captureWithFrame1];
            
            [self setValueName:@"1" withKey:@"firstIn"];
            [self setValueName:self->_dataNumberArr withKey:[NSString stringWithFormat:@"%@textNumArr",self.TemplateId]];
            [self setValueName:self->_ModuleIdArr withKey:[NSString stringWithFormat:@"%@ModuleIdArr",self.TemplateId]];
            
            NSDictionary *Imagedic=[FCAppInfo shareManager].huabanArr[11];
            NSString *string=[NSString stringWithFormat:@"%@",Imagedic[@"BackgroundImage"]];
            
            NSDateFormatter * dateFor=[[NSDateFormatter alloc]init];
            [dateFor setDateFormat:@"YYYY-MM-dd HH:mm"];
            NSDate *date=[NSDate date];
            NSString *dateString= [dateFor stringFromDate:date];
            NSString *boxColor=[NSString stringWithFormat:@"%d",[FCAppInfo shareManager].boxColor];
            NSDictionary * dic=@{@"TemplateId":self.TemplateId1,@"TemplateName":[FCAppInfo shareManager].lflTemName,@"radom":self.TemplateId,@"date":dateString,@"image":string,@"boxColor":boxColor,@"fontColor":[FCAppInfo shareManager].TDic,@"huaban":[FCAppInfo shareManager].huabanArr,@"portroy":[FCAppInfo shareManager].pDic,@"qietu":self.qietuData,@"backgroundimage":[FCAppInfo shareManager].backgroundImage};
            if (lflArr.count>0) {
                 
                 [arr1 insertObject:dic atIndex:0];
                 [self setValueName:arr1 withKey:@"DraftArr"];
            }else{
                [arr addObject:dic];
                 [self setValueName:arr withKey:@"DraftArr"];
            }
           
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //移除所有有关的text沙盒
            for(NSString *key in [dictionary allKeys]){
                if ([key containsString:self.TemplateId]) {
                    [stand removeObjectForKey:key];
                    [stand synchronize];
                }
                
            }
            
            NSArray *arr=[self objectValueWith:@"DraftArr"];
            NSMutableArray *NsMarr=[NSMutableArray arrayWithArray:arr];
            for (NSDictionary * dic in arr) {
                if ([dic[@"radom"] isEqualToString:self.TemplateId]) {
                    [NsMarr removeObject:dic];
                }
            }
            [self setValueName:NsMarr withKey:@"DraftArr"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:confirm];
        [alertController addAction:cance];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PicutreFromAlbum" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"gifwmy" object:nil];
    }
    
    
    
   
    
}
-(void)lflButton{
    
    if ([isClick isEqualToString:@"1"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否完成编辑" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->StartJQ=@"yes";
            [self.DataCollectionView reloadData];
            [self captureWithFrame];
            self->isClick=@"0";
            [self findNetWorkStatus];
            self->IsBack=@"1";
            
            
        }];
        UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self->isClick=@"1";
            self->StartJQ=@"no";

        }];
        [alertController addAction:confirm];
        [alertController addAction:cance];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        
    }
    
}
-(void)popRightItemView{
    if ([IsBack isEqualToString:@"1"])
    {
        
    }
    else
    {
        NSLog(@"完成");
        
        
        
        [self.DataCollectionView setContentOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN) animated:YES];
        [self performSelector:@selector(lflButton) withObject:self afterDelay:0.5];
    }
    
    
    
}

-(void)gifwmy{
    SureSum=0;
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@video",self.TemplateId]])
        {
            self->SureSum+=1;
          
        }
    }
    
    if (sum==SureSum) {
        [self lfl];
    }
}

-(void)wmy{
    //    //圆圈
    int count = 0;
    int index = 0;
    self.DataCollectionView.userInteractionEnabled=NO;
    sum=0;
    [FCAppInfo shareManager].gifCount=0;
    
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@gif123",self.TemplateId]]){
            count+=1;
            
        }
    }
    
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@gif123",self.TemplateId]]) {
            self->sum+=1;
            NSDictionary * gifDic=[stand objectForKey:key];
                 NSLog(@"key==%@",key);
            index+=1;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.circleView.percent=(index/count)*0.1;
            });
            
               [gifDic[@"gifString"]creatVdeoUrl:key];
            
            }
           
        }
        NSLog(@"for==");
    
    if (sum==0) {
       [self lfl];
    }
    
}
-(void)lfl{
    
    
    gifCount=0;
    SureSum=0;
    
    SumData=[self getPictureData];
    AlerayldData=0;
    wancheng=@"1";
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    
    [self setValueName:self->_dataNumberArr withKey:[NSString stringWithFormat:@"%@textNumArr",self.TemplateId]];
    [self setValueName:self->_ModuleIdArr withKey:[NSString stringWithFormat:@"%@ModuleIdArr",self.TemplateId]];
    

   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
    
        
        for(NSString *key in [dictionary allKeys]){

            
            
            if ([key containsString:[NSString stringWithFormat:@"%@image",self.TemplateId]])
            {
                if ([key containsString:@"imageheader"]) {
                    NSDictionary *lfldic=[self objectValueWith:key];
                    if (lfldic.count==2) {
                        
                    }else{
                        [self uploadPictureOSS:key];
                    }
                }else{

                    [self uploadPictureOSS:key];
                    
                    NSLog(@"pickey==%@",key);
                    
                }
                
              
                
            }else if ([key containsString:[NSString stringWithFormat:@"%@video",self.TemplateId]])
            {
                self->SureSum+=1;
                [self uploadVideoOSS:key];
            }
            else if ([key containsString:[NSString stringWithFormat:@"%@gif",self.TemplateId]])
            {
                self->gifCount +=1;
                [self uploadgifOSS:key];
            }
            
        }
        NSLog(@"--%d--%d--%d",self->ZongSum,self->SureSum,self->gifCount);
        
    });
}
-(void)upDetail{
    self->StartJQ=@"no";
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    NSString * jianqie;
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@headerText",self.TemplateId]]) {
            NSDictionary *dic=[stand objectForKey:key];
            NSString * Color=dic[@"Color"];
            NSString *FontFamily=dic[@"FontFamily"];
            NSString *FontSize=dic[@"FontSize"];
            NSString *ParameterType=@"TEXT";
            NSString *Text=dic[@"Text"];
            NSString *TextAlign=dic[@"TextAlign"];
            
            NSDictionary *image;
            
            NSString *imageUrl;
            
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=_ImageArr[i];
                if ([String containsString:@"imageheader"]) {
                    NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }
                
             //   添加截图
                else if ([String containsString:@"jianqie"]){
                    NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    jianqie=[_ImageArr[i] substringFromIndex:range.location];
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
        [self showMessage:@"参数不全"];
        return;
    }
    NSLog(@"pamaArr==%@",pamaArr);
    
    NSDictionary *dic=@{@"Modules":pamaArr,@"TemplateId":self.TemplateId1};
    NSError *error;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *lfldic=@{@"AccessToken":AccessToken,@"Scrapbook":jsonString,@"Picture":jianqie};
    
    NSString *lflstring= [self createSign:lfldic];
    
    NSDictionary *param=@{@"Sign":lflstring,@"Scrapbook":jsonString,@"Picture":jianqie};
    
    
    
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:saveScrapbook WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"完成获取上传图片%@",obj);
        NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        if ([msgStr isEqualToString:@"1"])
        {
            self->wancheng=@"0";
            self->yunxu=@"0";
            self->isClick=@"1";
            [self->pamaArr removeAllObjects];
            [self->_ImageArr removeAllObjects];
           
            if(self->hud)
            {
                [self->hud hideAnimated:YES afterDelay:0.2];
            }
            //移除所有有关的text沙盒
            NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
            NSDictionary *dictionary = [stand dictionaryRepresentation];
            for(NSString *key in [dictionary allKeys]){
                if ([key containsString:self.TemplateId]) {
                    [stand removeObjectForKey:key];
                    [stand synchronize];
                }
                
            }
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PicutreFromAlbum" object:nil];
           [[NSNotificationCenter defaultCenter]removeObserver:self name:@"gifwmy" object:nil];
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

-(void)canceClick{
    ChooseView.hidden=NO;
    self.background.hidden=YES;
    self.pickerBgView.hidden=YES;
}
-(void)changeImage:(NSNotification*)notification{
    NSLog(@"--%@--%@",lflimage,image1);
    NSData * data=notification.userInfo[@"image"];
    NSDictionary * dic=@{@"image":data};
    NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
    if ([[FCAppInfo shareManager].isHeader isEqualToString:@"yes"]) {
        NSString *zuiIndex=[NSString stringWithFormat:@"%@imageheader",self.TemplateId];
        [stand setObject:dic forKey:zuiIndex];
        [stand synchronize];
        [self.DataCollectionView reloadData];
    }else{
        NSString *zuiIndex=[NSString stringWithFormat:@"%@%@%@image",self->lflimage,self->image1,self.TemplateId];
        NSString *zuiIndex1=[NSString stringWithFormat:@"%@%@%@video",self->lflimage,self->image1,self.TemplateId];
        NSString *zuiIndex2=[NSString stringWithFormat:@"%@%@%@gif",self->lflimage,self->image1,self.TemplateId];
        NSDictionary * video=[stand objectForKey:zuiIndex1];
        if (video.count>0)
        {
            [stand removeObjectForKey:zuiIndex1];
            [stand removeObjectForKey:zuiIndex2];
        }
        [stand setObject:dic forKey:zuiIndex];
        [stand synchronize];
        [self.DataCollectionView reloadData];
    }
    
    
    
    
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([currentImage isEqualToString:[FCAppInfo shareManager].backgroundImage]) {
        
    }else{
        UIImageView * imageView=[[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[FCAppInfo shareManager].backgroundImage] placeholderImage:[UIImage imageNamed:@""]];
        CGSize size = [UIImage getImageSizeWithURL:[FCAppInfo shareManager].backgroundImage];
        
        NSLog(@"kuang==%f,gao==%f",size.width,size.height);
        
        self.DataCollectionView.backgroundView=imageView;
        
        currentImage=[FCAppInfo shareManager].backgroundImage;
    }
    
    
    self.title=[FCAppInfo shareManager].lflTemName;
    self.TemplateId1=[FCAppInfo shareManager].lflTemID;
    IsBack=@"0";
    wancheng=@"0";
    isClick=@"1";
    ChooseView.hidden=NO;
    [self.DataCollectionView reloadData];
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
    return _dataNumberArr.count;
    
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
- (NSInteger)needLinesWithWithString:(NSString*)string withFont:(int)font{
    //创建一个labe
    UILabel * label = [[UILabel alloc]init];
    //font和当前label保持一致
    label.font = [UIFont systemFontOfSize:font];
    NSString * text = string;
    NSInteger sum = 0;
    //总行数受换行符影响，所以这里计算总行数，需要用换行符分隔这段文字，然后计算每段文字的行数，相加即是总行数。
    NSArray * splitText = [text componentsSeparatedByString:@"\n"];
    for (NSString * sText in splitText) {
        label.text = sText;
        //获取这段文字一行需要的size
        CGSize textSize = [label systemLayoutSizeFittingSize:CGSizeZero];
        //size.width/所需要的width 向上取整就是这段文字占的行数
        NSInteger lines = ceilf(textSize.width/335);
        //当是0的时候，说明这是换行，需要按一行算。
        lines = lines == 0?1:lines;
        sum += lines;
    }
    return sum;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string=[NSString stringWithFormat:@"%@",_dataNumberArr[indexPath.row]];
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    
    if ([string isEqualToString:@"1"]) {
        OneCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid1" forIndexPath:indexPath];
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
        
    
        [cell1.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell1.leftButton.tag=indexPath.row;
        [cell1.editButton addTarget:self action:@selector(EditButton:) forControlEvents:UIControlEventTouchUpInside];
        cell1.editButton.tag=indexPath.row;
       
        //文字展示
    
        NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:textIndex];
        if (dic.count>2) {
            cell1.bottomLabel.text=dic[@"Text"];
            cell1.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            
            cell1.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            if ([dic[@"TextAlign"] isEqualToString:@"Center"]) {
                cell1.bottomLabel.textAlignment=NSTextAlignmentCenter;
            }
            else if ([dic[@"TextAlign"] isEqualToString:@"Left"])
            {
                cell1.bottomLabel.textAlignment=NSTextAlignmentLeft;
            }else{
               cell1.bottomLabel.textAlignment=NSTextAlignmentRight;
            }
           
           CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
//            if (height>kheigh(58)){
                cell1.editButton.frame=CGRectMake(kheigh(20), 0, self.view.bounds.size.width-2*kWidth(20), height);
                cell1.bottomLabel.frame=CGRectMake(0, kWidth(1), self.view.bounds.size.width-2*kWidth(20), height);
            
//            }
//            else
//            {
//                cell1.editButton.frame=CGRectMake(kheigh(20),0, self.view.bounds.size.width-2*kWidth(20), kheigh(58));
//                cell1.bottomLabel.frame=CGRectMake(0, 0, self.view.bounds.size.width-2*kWidth(20), kheigh(58));
//            }
           
        }else{
            
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_1_1"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"在这个毕业季我们怀着感伤，怀着兴奋，怀着梦想，怀着留恋，最后终究是要平静的模样离开。";
                
            }
            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            cell1.bottomLabel.text=dic[@"Text"];
            cell1.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            cell1.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            cell1.bottomLabel.textAlignment=NSTextAlignmentLeft;
            [stand setObject:dic forKey:[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        [cell1 setLFL];
        if ([wancheng isEqualToString:@"1"]) {
            //添加数据
            NSDictionary * headerPara=@{@"Color":dic[@"Color"],@"FontFamily":dic[@"FontFamily"],@"FontSize":dic[@"FontSize"],@"ParameterType":@"TEXT",@"Text":dic[@"Text"],@"TextAlign":dic[@"TextAlign"]};
            NSArray *arr=@[headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_1_1",@"Parameters":arr};
            [pamaArr addObject:zong];
        }
       [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell1;
    }
    else if ([string isEqualToString:@"2"]){
        TwoCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid2" forIndexPath:indexPath];
        [cell2.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell2.leftButton.tag=indexPath.row;
        NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[1];
        NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
        cell2.tag=indexPath.row;
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
        
//        添加图片按钮的操作
        [cell2.addButton addTarget:self action:@selector(Cell2AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell2.addButton.tag=indexPath.row;
        
        
        
        
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:ImageIndex];
        if (dic) {
            NSData *data=dic[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell2.addButton setBackgroundImage:image forState:UIControlStateNormal];
             cell2.centerImg.image=[UIImage imageNamed:@""];
        }else{
             cell2.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
             cell2.centerImg.image=[UIImage imageNamed:@"中间"];
            [cell2.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        
        if ([wancheng isEqualToString:@"1"]) {
            
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            NSString *GIFIndex1=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            NSString *VimageUrl;
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                if ([String isEqualToString:ImageIndex]) {
                    NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    VimageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }
            }
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex1.length];
                if ([String isEqualToString:GIFIndex1]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }
            }
            for (int i=0; i<_VideoArr.count; i++){
                
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex1.length];
                if ([String isEqualToString:VideoIndex1]) {
                    NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    VideoUrl = [_VideoArr[i] substringFromIndex:range.location];
                }
            }
            if (VideoUrl.length>9) {
                //添加数据
                NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":VimageUrl};
                NSArray *arr=@[image];
                NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                [pamaArr addObject:zong];
                
            }
            else{
                
                NSString *imageUrl;
                for (int i=0; i<_ImageArr.count; i++) {
                    NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                    if ([String isEqualToString:ImageIndex]) {
                        NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                        imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                    }
                }
                //添加数据
               
                NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
                NSArray *arr=@[image];
                NSDictionary *zong=@{@"ModuleId":@"Module_1_2",@"Parameters":arr};
                [pamaArr addObject:zong];
            }
            
            
        }
        //添加视屏播放的按钮
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell2.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell2;
    }
    else if ([string isEqualToString:@"3"]){
        
        
        ThreeCell *cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid3" forIndexPath:indexPath];
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
       
        //文字展示
        NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:textIndex];
//        NSLog(@"dateDic==%@",dic);
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
        else{
            
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_2_1"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"在这个毕业季我们怀着感伤，怀着兴奋，怀着梦想，怀着留恋，最后终究是要平静的模样离开。";
                
            }
            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            cell3.bottomLabel.text=dic[@"Text"];
            cell3.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            cell3.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            cell3.bottomLabel.textAlignment=NSTextAlignmentLeft;
           [stand setObject:dic forKey:[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        
        //        添加图片按钮的操作
        [cell3.addButton addTarget:self action:@selector(Cell3AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell3.addButton.tag=indexPath.row;
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic1=[stand objectForKey:ImageIndex];
        if (dic1) {
            NSData *data=dic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell3.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell3.centerImg.image=[UIImage imageNamed:@""];
        }else{
            cell3.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell3.centerImg.image=[UIImage imageNamed:@"中间"];
            [cell3.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell3.add1Button addTarget:self action:@selector(Cell3Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell3.add1Button.tag=indexPath.row;
        
        NSString *ImageIndex1=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic2=[stand objectForKey:ImageIndex1];
        if (dic2) {
            NSData *data=dic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell3.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell3.center1Img.image=[UIImage imageNamed:@""];
        }else{
            cell3.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell3.center1Img.image=[UIImage imageNamed:@"中间"];
             [cell3.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSDictionary *image1;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            NSString *GIFIndex1=[NSString stringWithFormat:@"%ld2%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl1;
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex1.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:GIFIndex1]){
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl1 = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            for (int i=0; i<_VideoArr.count; i++){
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex.length];
                if ([String isEqualToString:VideoIndex]) {
                    NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    VideoUrl=[_VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    VideoUrl1=[_VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            NSString *imageUrl;
            NSString *imageUrl1;
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                if ([String isEqualToString:ImageIndex]) {
                    NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:ImageIndex1]) {
                    NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    imageUrl1=[_ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1,@"GifURL":GifUrl1,@"VideoPictureURL":imageUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            
            //添加数据
            NSDictionary * headerPara=@{@"Color":dic[@"Color"],@"FontFamily":dic[@"FontFamily"],@"FontSize":dic[@"FontSize"],@"ParameterType":@"TEXT",@"Text":dic[@"Text"],@"TextAlign":dic[@"TextAlign"]};
            NSArray *arr=@[headerPara,image,image1];
            NSDictionary *zong=@{@"ModuleId":@"Module_2_1",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell3.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell3.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell3;
    }
    else if ([string isEqualToString:@"4"]){
        FourCell *cell4 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid4" forIndexPath:indexPath];
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
        //文字展示
        NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:textIndex];
//        NSLog(@"dateDic==%@",dic);
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
            
        }
        else{
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_2_2"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"在这个毕业季我们怀着感伤，怀着兴奋，怀着梦想，怀着留恋，最后终究是要平静的模样离开。";
                
            }
            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            cell4.bottomLabel.text=dic[@"Text"];
            cell4.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            cell4.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            cell4.bottomLabel.textAlignment=NSTextAlignmentLeft;
            [stand setObject:dic forKey:[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        [cell4 setLFL];
        
        //        添加图片按钮的操作
        [cell4.addButton addTarget:self action:@selector(Cell4AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell4.addButton.tag=indexPath.row;
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic1=[stand objectForKey:ImageIndex];
        if (dic1) {
            NSData *data=dic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell4.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell4.centerImg.image=[UIImage imageNamed:@""];
        }else{
            cell4.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell4.centerImg.image=[UIImage imageNamed:@"中间"];
            [cell4.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        if ([wancheng isEqualToString:@"1"]) {
            
            NSDictionary *image;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            for (int i=0; i<_VideoArr.count; i++){
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex.length];
                if ([String isEqualToString:VideoIndex]) {
                    NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    VideoUrl=[_VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            NSString *imageUrl;
            
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:ImageIndex]) {
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
            }else{
               image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":dic[@"Color"],@"FontFamily":dic[@"FontFamily"],@"FontSize":dic[@"FontSize"],@"ParameterType":@"TEXT",@"Text":dic[@"Text"],@"TextAlign":dic[@"TextAlign"]};
            NSArray *arr=@[headerPara,image];
            NSDictionary *zong=@{@"ModuleId":@"Module_2_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
            
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell4.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell4;
    }
    else if ([string isEqualToString:@"5"]){
        FiveCell *cell5 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid5" forIndexPath:indexPath];
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
        //文字展示
        NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:textIndex];
     
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
//
        }
        else{
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_3_1"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"在这个毕业季我们怀着感伤，怀着兴奋，怀着梦想，怀着留恋，最后终究是要平静的模样离开。";
                
            }
            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            cell5.bottomLabel.text=dic[@"Text"];
            cell5.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            cell5.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            cell5.bottomLabel.textAlignment=NSTextAlignmentLeft;
            [stand setObject:dic forKey:[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        [cell5 setLFL];
        //        添加图片按钮的操作
        [cell5.addButton addTarget:self action:@selector(Cell5AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell5.addButton.tag=indexPath.row;
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic1=[stand objectForKey:ImageIndex];
        if (dic1) {
            NSData *data=dic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell5.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell5.centerImg.image=[UIImage imageNamed:@""];
        }else{
            cell5.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell5.centerImg.image=[UIImage imageNamed:@"中间"];
             [cell5.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell5.add1Button addTarget:self action:@selector(Cell5Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell5.add1Button.tag=indexPath.row;
        NSString *ImageIndex2=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic2=[stand objectForKey:ImageIndex2];
        if (dic2) {
            NSData *data=dic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell5.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell5.center1Img.image=[UIImage imageNamed:@""];
        }else{
            cell5.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell5.center1Img.image=[UIImage imageNamed:@"中间"];
             [cell5.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell5.add2Button addTarget:self action:@selector(Cell5Add2Button:) forControlEvents:UIControlEventTouchUpInside];
        cell5.add2Button.tag=indexPath.row;
        NSString *ImageIndex3=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic3=[stand objectForKey:ImageIndex3];
        if (dic3) {
            NSData *data=dic3[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell5.add2Button setBackgroundImage:image forState:UIControlStateNormal];
            cell5.center2Img.image=[UIImage imageNamed:@""];
        }else{
            cell5.add2Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell5.center2Img.image=[UIImage imageNamed:@"中间"];
             [cell5.add2Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        if ([wancheng isEqualToString:@"1"]) {
            
            NSDictionary *image;
            NSDictionary *image1;
            NSDictionary *image2;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            NSString *VideoUrl2;
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            NSString *GIFIndex1=[NSString stringWithFormat:@"%ld2%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl1;
            NSString *GIFIndex2=[NSString stringWithFormat:@"%ld3%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl2;
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else if ([String isEqualToString:GIFIndex1]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl1 = [_GIFArr[i] substringFromIndex:range.location];
                }else if ([String isEqualToString:GIFIndex2]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl2 = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            for (int i=0; i<_VideoArr.count; i++){
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex.length];
                NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[_VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    VideoUrl1=[_VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex2]) {
                    VideoUrl2=[_VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            NSString *imageUrl;
            NSString *imageUrl1;
             NSString *imageUrl2;
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:ImageIndex]) {
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:ImageIndex2]) {
                    imageUrl1=[_ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:ImageIndex3]){
                   imageUrl2=[_ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            if (VideoUrl.length>9) {
                 image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                 image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1,@"GifURL":GifUrl1,@"VideoPictureURL":imageUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            
            if (VideoUrl2.length>9) {
                 image2=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl2,@"GifURL":GifUrl2,@"VideoPictureURL":imageUrl2};
            }else{
                image2=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl2};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":dic[@"Color"],@"FontFamily":dic[@"FontFamily"],@"FontSize":dic[@"FontSize"],@"ParameterType":@"TEXT",@"Text":dic[@"Text"],@"TextAlign":dic[@"TextAlign"]};
           
            NSArray *arr=@[headerPara,image,image1,image2];
            NSDictionary *zong=@{@"ModuleId":@"Module_3_1",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell5.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell5.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic2=[stand objectForKey:VideoIndex2];
        if (Videodic2.count>0) {
            cell5.center2Img.image=[UIImage imageNamed:@"zanting"];
        }
        
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell5;
    }
    else if ([string isEqualToString:@"6"]){
        SixCell *cell6 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid6" forIndexPath:indexPath];
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
        //文字展示
        NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:textIndex];
        
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
//            if (height>kWidth(33)) {
                cell6.editButton.frame=CGRectMake(kWidth(20), kWidth(165), kWidth(280), height);
                cell6.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
//            }else{
//                cell6.editButton.frame=CGRectMake(kWidth(20), kWidth(165),kWidth(280), kWidth(33));
//                cell6.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kWidth(33));
//            }
            
        }
        else{
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_3_2"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"在这个毕业季我们怀着感伤，怀着兴奋，怀着梦想，怀着留恋，最后终究是要平静的模样离开。";
                
            }
            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            cell6.bottomLabel.text=dic[@"Text"];
            cell6.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            cell6.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            cell6.bottomLabel.textAlignment=NSTextAlignmentLeft;
           [stand setObject:dic forKey:[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        
        [cell6 setLFL];
        //        添加图片按钮的操作
        [cell6.addButton addTarget:self action:@selector(Cell6AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell6.addButton.tag=indexPath.row;
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic1=[stand objectForKey:ImageIndex];
        if (dic1) {
            NSData *data=dic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell6.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell6.centerImg.image=[UIImage imageNamed:@""];
        }else{
            cell6.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell6.centerImg.image=[UIImage imageNamed:@"中间"];
             [cell6.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell6.add1Button addTarget:self action:@selector(Cell6Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell6.add1Button.tag=indexPath.row;
        NSString *ImageIndex2=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic2=[stand objectForKey:ImageIndex2];
        if (dic2) {
            NSData *data=dic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell6.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell6.center1Img.image=[UIImage imageNamed:@""];
        }else{
            cell6.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell6.center1Img.image=[UIImage imageNamed:@"中间"];
             [cell6.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell6.add2Button addTarget:self action:@selector(Cell6Add2Button:) forControlEvents:UIControlEventTouchUpInside];
        cell6.add2Button.tag=indexPath.row;
        NSString *ImageIndex3=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic3=[stand objectForKey:ImageIndex3];
        if (dic3) {
            NSData *data=dic3[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell6.add2Button setBackgroundImage:image forState:UIControlStateNormal];
            cell6.center2Img.image=[UIImage imageNamed:@""];
        }else{
            cell6.add2Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell6.center2Img.image=[UIImage imageNamed:@"中间"];
             [cell6.add2Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        if ([wancheng isEqualToString:@"1"]) {
            
            NSDictionary *image;
            NSDictionary *image1;
            NSDictionary *image2;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            NSString *VideoUrl2;
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            NSString *GIFIndex1=[NSString stringWithFormat:@"%ld2%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl1;
            NSString *GIFIndex2=[NSString stringWithFormat:@"%ld3%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl2;
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else if ([String isEqualToString:GIFIndex1]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl1 = [_GIFArr[i] substringFromIndex:range.location];
                }else if ([String isEqualToString:GIFIndex2]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl2 = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            for (int i=0; i<_VideoArr.count; i++){
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex.length];
                NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[_VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    VideoUrl1=[_VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex2]) {
                    VideoUrl2=[_VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            NSString *imageUrl;
            NSString *imageUrl1;
            NSString *imageUrl2;
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:ImageIndex]) {
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:ImageIndex2]) {
                    imageUrl1=[_ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:ImageIndex3]){
                    imageUrl2=[_ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1,@"GifURL":GifUrl1,@"VideoPictureURL":imageUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            
            if (VideoUrl2.length>9) {
                image2=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl2,@"GifURL":GifUrl2,@"VideoPictureURL":imageUrl2};
            }else{
                image2=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl2};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":dic[@"Color"],@"FontFamily":dic[@"FontFamily"],@"FontSize":dic[@"FontSize"],@"ParameterType":@"TEXT",@"Text":dic[@"Text"],@"TextAlign":dic[@"TextAlign"]};
            NSArray *arr=@[image,image1,image2,headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_3_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell6.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell6.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic2=[stand objectForKey:VideoIndex2];
        if (Videodic2.count>0) {
            cell6.center2Img.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell6;
    }
    else if ([string isEqualToString:@"8"]){
        RightCell *cell8 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid8" forIndexPath:indexPath];
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
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic1=[stand objectForKey:ImageIndex];
        if (dic1) {
            NSData *data=dic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell8.centerImg.image=[UIImage imageNamed:@""];
        }
        else{
            cell8.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell8.centerImg.image=[UIImage imageNamed:@"中间"];
            [cell8.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell8.add1Button addTarget:self action:@selector(Cell8Add1Button:) forControlEvents:UIControlEventTouchUpInside];
        cell8.add1Button.tag=indexPath.row;
        NSString *ImageIndex2=[NSString stringWithFormat:@"%ld2%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic2=[stand objectForKey:ImageIndex2];
        if (dic2) {
            NSData *data=dic2[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.add1Button setBackgroundImage:image forState:UIControlStateNormal];
            cell8.center1Img.image=[UIImage imageNamed:@""];
        }else{
            cell8.add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell8.center1Img.image=[UIImage imageNamed:@"中间"];
             [cell8.add1Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell8.add2Button addTarget:self action:@selector(Cell8Add2Button:) forControlEvents:UIControlEventTouchUpInside];
        cell8.add2Button.tag=indexPath.row;
        NSString *ImageIndex3=[NSString stringWithFormat:@"%ld3%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic3=[stand objectForKey:ImageIndex3];
        if (dic3) {
            NSData *data=dic3[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.add2Button setBackgroundImage:image forState:UIControlStateNormal];
            cell8.center2Img.image=[UIImage imageNamed:@""];
        }else{
            cell8.add2Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell8.center2Img.image=[UIImage imageNamed:@"中间"];
             [cell8.add2Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [cell8.add3Button addTarget:self action:@selector(Cell8Add3Button:) forControlEvents:UIControlEventTouchUpInside];
        cell8.add3Button.tag=indexPath.row;
        NSString *ImageIndex4=[NSString stringWithFormat:@"%ld4%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic4=[stand objectForKey:ImageIndex4];
        if (dic4) {
            NSData *data=dic4[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell8.add3Button setBackgroundImage:image forState:UIControlStateNormal];
            cell8.center3Img.image=[UIImage imageNamed:@""];
        }else{
            cell8.add3Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell8.center3Img.image=[UIImage imageNamed:@"中间"];
             [cell8.add3Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        if ([wancheng isEqualToString:@"1"]) {
            
            NSDictionary *image;
            NSDictionary *image1;
            NSDictionary *image2;
            NSDictionary *image3;
            NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoIndex3=[NSString stringWithFormat:@"%ld4%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            NSString *VideoUrl1;
            NSString *VideoUrl2;
            NSString *VideoUrl3;
            for (int i=0; i<_VideoArr.count; i++){
                NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex.length];
                if ([String isEqualToString:VideoIndex]) {
                    VideoUrl=[_VideoArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:VideoIndex1]) {
                    VideoUrl1=[_VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex2]) {
                    VideoUrl2=[_VideoArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:VideoIndex3]) {
                    VideoUrl3=[_VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
                
            }
            
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            NSString *GIFIndex1=[NSString stringWithFormat:@"%ld2%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl1;
            NSString *GIFIndex2=[NSString stringWithFormat:@"%ld3%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl2;
            NSString *GIFIndex3=[NSString stringWithFormat:@"%ld4%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl3;
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else if ([String isEqualToString:GIFIndex1]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl1 = [_GIFArr[i] substringFromIndex:range.location];
                }else if ([String isEqualToString:GIFIndex2]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl2 = [_GIFArr[i] substringFromIndex:range.location];
                }else if ([String isEqualToString:GIFIndex3]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl3 = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            
            NSString *imageUrl;
            NSString *imageUrl1;
            NSString *imageUrl2;
             NSString *imageUrl3;
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:ImageIndex]) {
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }else if([String isEqualToString:ImageIndex2]) {
                    imageUrl1=[_ImageArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:ImageIndex3]) {
                    imageUrl2=[_ImageArr[i] substringFromIndex:range.location];
                }
                else if([String isEqualToString:ImageIndex4]) {
                    imageUrl3=[_ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            //添加数据
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            
            if (VideoUrl1.length>9) {
                image1=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl1,@"GifURL":GifUrl1,@"VideoPictureURL":imageUrl1};
            }else{
                image1=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl1};
            }
            
            if (VideoUrl2.length>9) {
                image2=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl2,@"GifURL":GifUrl2,@"VideoPictureURL":imageUrl2};
            }else{
                image2=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl2};
            }
            if (VideoUrl3.length>9) {
                image3=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl3,@"GifURL":GifUrl3,@"VideoPictureURL":imageUrl3};
            }else{
                image3=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl3};
            }
            NSArray *arr=@[image,image1,image2,image3];
            NSDictionary *zong=@{@"ModuleId":@"Module_4_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell8.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        
        NSString *VideoIndex1=[NSString stringWithFormat:@"%ld2%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic1=[stand objectForKey:VideoIndex1];
        if (Videodic1.count>0) {
            cell8.center1Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex2=[NSString stringWithFormat:@"%ld3%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic2=[stand objectForKey:VideoIndex2];
        if (Videodic2.count>0) {
            cell8.center2Img.image=[UIImage imageNamed:@"zanting"];
        }
        NSString *VideoIndex3=[NSString stringWithFormat:@"%ld4%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic3=[stand objectForKey:VideoIndex3];
        if (Videodic3.count>0) {
            cell8.center3Img.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell8;
    }
    else if ([string isEqualToString:@"7"]){
        SevenCell *cell7 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid7" forIndexPath:indexPath];
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
        //文字展示
        NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:textIndex];
       
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
//             if (height>kWidth(15)) {
                 cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), height);
                 cell7.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
//             }else{
//                 cell7.editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), kWidth(15));
//                 cell7.bottomLabel.frame=CGRectMake(0, 0, kWidth(280), kWidth(15));
//             }
//
        }
        else{
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_4_1"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"在这个毕业季我们怀着感伤，怀着兴奋，怀着梦想，怀着留恋，最后终究是要平静的模样离开。";
                
            }
            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            cell7.bottomLabel.text=dic[@"Text"];
            cell7.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            cell7.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            cell7.bottomLabel.textAlignment=NSTextAlignmentLeft;
            [stand setObject:dic forKey:[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        [cell7 setLFL];
        //        添加图片按钮的操作
        
        [cell7.addButton addTarget:self action:@selector(Cell7AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell7.addButton.tag=indexPath.row;
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic1=[stand objectForKey:ImageIndex];
        if (dic1) {
            NSData *data=dic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell7.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell7.centerImg.image=[UIImage imageNamed:@""];
        }else{
            cell7.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell7.centerImg.image=[UIImage imageNamed:@"中间"];
             [cell7.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            for (int i=0; i<_VideoArr.count; i++){
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex1.length];
                NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex1]) {
                    VideoUrl=[_VideoArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            NSString *imageUrl;
            
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:ImageIndex]) {
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":dic[@"Color"],@"FontFamily":dic[@"FontFamily"],@"FontSize":dic[@"FontSize"],@"ParameterType":@"TEXT",@"Text":dic[@"Text"],@"TextAlign":dic[@"TextAlign"]};
           
            NSArray *arr=@[image,headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_4_1",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell7.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell7;
    }
    
    else if ([string isEqualToString:@"9"]){
        NineCell *cell9 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid9" forIndexPath:indexPath];
        [cell9.leftButton addTarget:self action:@selector(LeftButton:) forControlEvents:UIControlEventTouchUpInside];
        cell9.leftButton.tag=indexPath.row;
        NSDictionary *dic111=[FCAppInfo shareManager].huabanArr[8];
        NSString *string111=[NSString stringWithFormat:@"%@",dic111[@"BackgroundImage"]];
        cell9.tag=indexPath.row;
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
        
        //        添加图片按钮的操作
        [cell9.addButton addTarget:self action:@selector(Cell9AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell9.addButton.tag=indexPath.row;
        
        
        
        
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:ImageIndex];
        if (dic) {
            NSData *data=dic[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell9.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell9.centerImg.image=[UIImage imageNamed:@""];
        }else{
            cell9.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell9.centerImg.image=[UIImage imageNamed:@"中间"];
            [cell9.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        
        
        if ([wancheng isEqualToString:@"1"]) {
            
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            for (int i=0; i<_VideoArr.count; i++){
                
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex1.length];
                if ([String isEqualToString:VideoIndex1]) {
                    NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    VideoUrl = [_VideoArr[i] substringFromIndex:range.location];
                }
            }
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            NSString *imageUrl;
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                if ([String isEqualToString:ImageIndex]) {
                    NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }
            }
            if (VideoUrl.length>9) {
                //添加数据
                NSDictionary *image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
                NSArray *arr=@[image];
                NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                [pamaArr addObject:zong];
                
            }
            else{
                
                
                //添加数据
                NSDictionary *image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
                NSArray *arr=@[image];
                NSDictionary *zong=@{@"ModuleId":@"Module_5_1",@"Parameters":arr};
                [pamaArr addObject:zong];
            }
            
            
        }
        //添加视屏播放的按钮
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell9.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        return cell9;
    }else{
        TenCell *cell10 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid10" forIndexPath:indexPath];
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
        //文字展示
        NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
        NSDictionary *dic=[stand objectForKey:textIndex];
        
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
//            if (height>kWidth(32)) {
                cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280), height);
                cell10.bottomLabel.frame=CGRectMake(0, kWidth(1), kWidth(280), height);
//            }else{
//                cell10.editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280),kWidth(32));
//                cell10.bottomLabel.frame=CGRectMake(0, 0, kWidth(280),kWidth(32));
//            }
            
        }
        else{
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_5_2"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"在这个毕业季我们怀着感伤，怀着兴奋，怀着梦想，怀着留恋，最后终究是要平静的模样离开。";
                
            }
            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            cell10.bottomLabel.text=dic[@"Text"];
            cell10.bottomLabel.font=[UIFont fontWithName:dic[@"FontFamily"] size:[dic[@"FontSize"] intValue]];
            cell10.bottomLabel.textColor=UIColorFromHex([dic[@"Color"] intValue]);
            cell10.bottomLabel.textAlignment=NSTextAlignmentLeft;
            [stand setObject:dic forKey:[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        [cell10 setLFL];
        //        添加图片按钮的操作
        
        [cell10.addButton addTarget:self action:@selector(Cell10AddButton:) forControlEvents:UIControlEventTouchUpInside];
        cell10.addButton.tag=indexPath.row;
        NSString *ImageIndex=[NSString stringWithFormat:@"%ld1%@image",indexPath.row+1,self.TemplateId];
        NSDictionary *dic1=[stand objectForKey:ImageIndex];
        if (dic1) {
            NSData *data=dic1[@"image"];
            UIImage *image=[UIImage imageWithData:data];
            [cell10.addButton setBackgroundImage:image forState:UIControlStateNormal];
            cell10.centerImg.image=[UIImage imageNamed:@""];
        }else{
            cell10.addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
            cell10.centerImg.image=[UIImage imageNamed:@"中间"];
            [cell10.addButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        if ([wancheng isEqualToString:@"1"]) {
            NSDictionary *image;
            NSString *VideoIndex1=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
            NSString *VideoUrl;
            for (int i=0; i<_VideoArr.count; i++){
                NSString * String=[_VideoArr[i] substringToIndex:VideoIndex1.length];
                NSRange range = [_VideoArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:VideoIndex1]) {
                    VideoUrl=[_VideoArr[i] substringFromIndex:range.location];
                }
            }
            
            NSString *GIFIndex=[NSString stringWithFormat:@"%ld1%@gif",indexPath.row+1,self.TemplateId];
            NSString *GifUrl;
            
            for (int i=0; i<_GIFArr.count; i++){
                
                NSString * String=[_GIFArr[i] substringToIndex:GIFIndex.length];
                
                if ([String isEqualToString:GIFIndex]) {
                    NSRange range = [_GIFArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                    GifUrl = [_GIFArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            
            NSString *imageUrl;
            
            for (int i=0; i<_ImageArr.count; i++) {
                NSString * String=[_ImageArr[i] substringToIndex:ImageIndex.length];
                NSRange range = [_ImageArr[i] rangeOfString:@"https:"]; //现获取要截取的字符串位置
                if ([String isEqualToString:ImageIndex]) {
                    imageUrl=[_ImageArr[i] substringFromIndex:range.location];
                }else{
                    
                }
            }
            if (VideoUrl.length>9) {
                image=@{@"ParameterType":@"VIDEO",@"VideoURL":VideoUrl,@"GifURL":GifUrl,@"VideoPictureURL":imageUrl};
            }else{
                image=@{@"ParameterType":@"PICTURE",@"PictureURL":imageUrl};
            }
            //添加数据
            NSDictionary * headerPara=@{@"Color":dic[@"Color"],@"FontFamily":dic[@"FontFamily"],@"FontSize":dic[@"FontSize"],@"ParameterType":@"TEXT",@"Text":dic[@"Text"],@"TextAlign":dic[@"TextAlign"]};
            
            NSArray *arr=@[image,headerPara];
            NSDictionary *zong=@{@"ModuleId":@"Module_5_2",@"Parameters":arr};
            [pamaArr addObject:zong];
            
            
        }
        NSString *VideoIndex=[NSString stringWithFormat:@"%ld1%@video",indexPath.row+1,self.TemplateId];
        NSDictionary *Videodic=[stand objectForKey:VideoIndex];
        if (Videodic.count>0) {
            cell10.centerImg.image=[UIImage imageNamed:@"zanting"];
        }
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
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
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *textdic=[stand objectForKey:[NSString stringWithFormat:@"%@headerText",self.TemplateId]];
    
    NSDictionary *imagedic=[stand objectForKey:[NSString stringWithFormat:@"%@imageheader",self.TemplateId]];
//    NSString * headerStr=imagedic[@"image"];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1" forIndexPath:indexPath];
        NSDictionary *dic=[FCAppInfo shareManager].huabanArr[11];
        NSString *string=[NSString stringWithFormat:@"%@",dic[@"BackgroundImage"]];
        if (headerButton) {
            [headerButton removeFromSuperview];
            headerButton=nil;
        }
            headerButton=[UIButton buttonWithType:UIButtonTypeCustom];
            headerButton.frame=CGRectMake(0, 0, self.view.bounds.size.width, kheigh(167));
            [headerButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
            [headerButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
            if (imagedic.count==1) {
                
                [headerButton setBackgroundImage:[UIImage imageWithData:imagedic[@"image"]] forState:UIControlStateNormal];
                
            }
            else
            {
                
                if ([self objectValueWith:string]) {
                    NSLog(@"you");
                    
                    UIImage *image = [UIImage imageWithData:[self objectValueWith:string]];
                    [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                    
                }else{
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]]; //得到图像数据
                    UIImage *image = [UIImage imageWithData:imgData];
                    [headerButton setBackgroundImage:image forState:UIControlStateNormal];
                    [self setValueName:imgData withKey:string];
                    imgData=nil;
                    image=nil;
                    string=nil;
                    
                }
            }
            UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
            button1.frame=CGRectMake(kWidth(20), kheigh(167)-kheigh(57), APP_SCREEN_WIDTH-2*kWidth(20), kheigh(24));
            [button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
            [headerButton addSubview:button1];
            
            
            UILabel *label=[[UILabel alloc]init];
            label.numberOfLines=0;
            label.frame=CGRectMake(kWidth(20), kheigh(167)-kheigh(57), APP_SCREEN_WIDTH-2*kWidth(20), kheigh(24));
            if (textdic.count>2) {
                label.text=textdic[@"Text"];
                NSString *color1=[NSString stringWithFormat:@"%@",textdic[@"Color"]];
                
                label.textColor=UIColorFromHex([color1 intValue]);
                label.font=[UIFont fontWithName:textdic[@"FontFamily"] size:[textdic[@"FontSize"] intValue]];
                if ([textdic[@"TextAlign"] isEqualToString:@"Center"]) {
                    label.textAlignment=NSTextAlignmentCenter;
                }
                else if ([textdic[@"TextAlign"] isEqualToString:@"Left"]) {
                    label.textAlignment=NSTextAlignmentLeft;
                }else{
                    label.textAlignment=NSTextAlignmentRight;
                }
                
            }
            else
            {
                NSArray * currentA=[FCAppInfo shareManager].pDic[@"Module_Header"];
                // 采用随机生成的诗句或者美句。
                if (currentA.count<1) {
                    label.text=@"";
                    label.font=[UIFont systemFontOfSize:15];
                    label.textColor=UIColorFromHex(0xb0d9cd);
                    label.textAlignment=NSTextAlignmentCenter;
                }else{
                    int y =(arc4random() % currentA.count);
                    if (currentA.count>0) {
                        NSString *TextIndex=currentA[y];
                        NSString *font1=@"19";
                        
                        
                        label.text=TextIndex;
                        NSDictionary *tdic=[FCAppInfo shareManager].TDic;
                        NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
                        NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
                        label.textColor=UIColorFromHex([color1 intValue]);
                        
                        label.textAlignment=NSTextAlignmentCenter;
                        label.font=[UIFont fontWithName:@"KaiTi" size:19];
                        
                        
                        
                        NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Center"};
                        [stand setObject:dic forKey:[NSString stringWithFormat:@"%@headerText",self.TemplateId]];
                        [stand synchronize];
                    }else{
                        
                    }
                }
            }
            [headerButton addSubview:label];
            
            if ([StartJQ isEqualToString:@"yes"]) {
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
            
        
        
        
        
        
        [reusableView addSubview:headerButton];
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
       
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
//        if ([self objectValueWith:string]) {
//            NSLog(@"you");
//
//            UIImage *image = [UIImage imageWithData:[self objectValueWith:string]];
//            [button setBackgroundImage:image forState:UIControlStateNormal];
//        }else{
//            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]]; //得到图像数据
//            UIImage *image = [UIImage imageWithData:imgData];
//            [button setBackgroundImage:image forState:UIControlStateNormal];
//            [self setValueName:imgData withKey:string];
//            imgData=nil;
//            image=nil;
//            string=nil;
//        }
//        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]]; //得到图像数据
//        UIImage *image = [UIImage imageWithData:imgData];
//        [self setValueName:string withKey:[NSString stringWithFormat:@"%@footerImage",self.TemplateId]];
//        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal];
        [footerView addSubview:button];
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
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
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSString *textIndex=[NSString stringWithFormat:@"%@headerText",self.TemplateId];
    NSDictionary *dic=[stand objectForKey:textIndex];
    
    EditViewController * edit=[[EditViewController alloc]init];
    edit.modeId=@"Module_Header";
    edit.temID=self.TemplateId;
    edit.isHeader=@"1";
    edit.text=dic[@"Text"];
    edit.textfont=[dic[@"FontSize"] intValue];
    edit.textcolor=[dic[@"Color"] intValue];
    edit.texttextAlign=dic[@"TextAlign"];
    edit.textfontName=dic[@"FontFamily"];
    [self.navigationController pushViewController:edit animated:YES];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([wancheng isEqualToString:@"1"]) {
        return CGSizeMake(APP_SCREEN_WIDTH, 1);
    }
    else
    {
        NSString *string=[NSString stringWithFormat:@"%@",_dataNumberArr[indexPath.row]];
        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
        if ([string isEqualToString:@"1"]) {
//            UIImage *image=[UIImage imageNamed:@"byj1"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            CGFloat zuihou=fixelH*bl;
//            OneCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid1" forIndexPath:indexPath];
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
            NSDictionary *dic=[stand objectForKey:textIndex];
            
//            if (dic.count>2)
//            {
            
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
            
                NSLog(@"height==%f",height);
//                if (height>kheigh(58)) {
            if (height==0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.DataCollectionView reloadData];
                });
            }
            return CGSizeMake(APP_SCREEN_WIDTH, height+kWidth(21));
            
            
        }
        else if([string isEqualToString:@"2"]){
//            UIImage *image=[UIImage imageNamed:@"byj2"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            CGFloat zuihou=fixelH*bl;
            
            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(217));
        }
        else if([string isEqualToString:@"3"]){
//            UIImage *image=[UIImage imageNamed:@"byj3"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            CGFloat zuihou=fixelH*bl;
            
            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(211));
        }
        else if([string isEqualToString:@"4"]){
//            UIImage *image=[UIImage imageNamed:@"byj4"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            CGFloat zuihou=fixelH*bl;
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
            NSDictionary *dic=[stand objectForKey:textIndex];
            
//            if (dic.count>2)
//            {
            
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                NSLog(@"height==%f",height);
                
                if (height>kheigh(31)) {
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(263)+height-kheigh(31));
                }else{
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(263)-height+kheigh(31));
                }
//
//            }else
//            {
//            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(263));
//            }
        }
        else if([string isEqualToString:@"5"]){
//            UIImage *image=[UIImage imageNamed:@"byj5"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            CGFloat zuihou=fixelH*bl;
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
            NSDictionary *dic=[stand objectForKey:textIndex];
            
//            if (dic.count>2)
//            {
            
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                NSLog(@"height==%f",height);
                
                if (height>kheigh(15)) {
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(180)+height-kheigh(15));
                }else{
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(180)-height+kheigh(15));
                }
            
//            }else
//            {
//            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(180));
//            }
        }
        else if([string isEqualToString:@"6"]){
//            UIImage *image=[UIImage imageNamed:@"byj6"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            CGFloat zuihou=fixelH*bl;
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
            NSDictionary *dic=[stand objectForKey:textIndex];
            
//            if (dic.count>2)
//            {
            
                CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                NSLog(@"height==%f",height);
                
                if (height>kWidth(33)) {
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(222)+height-kWidth(33));
                }else{
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(222)-height+kWidth(33));
                }
//
//            }else
//            {
//            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(222));
//            }
        }
        else if([string isEqualToString:@"7"]){
//            UIImage *image=[UIImage imageNamed:@"byj7"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat zuihou=fixelH*bl;
            NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
            NSDictionary *dic=[stand objectForKey:textIndex];
            
//            if (dic.count>2)
//            {
            
                 CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                NSLog(@"height==%f",height);
                if (height>kWidth(15)) {
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)+height-kWidth(15));
                }else{
                    return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201)-height+kWidth(15));
                }
//
//            }else
//            {
//            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(201));
//            }
        }
         else if([string isEqualToString:@"8"]) {
//            UIImage *image=[UIImage imageNamed:@"byj8"];
//            CGFloat width= CGImageGetWidth(image.CGImage);
//            float bl=APP_SCREEN_WIDTH/width;
//            CGFloat fixelH = CGImageGetHeight(image.CGImage);
//            CGFloat zuihou=fixelH*bl;
            
            return CGSizeMake(APP_SCREEN_WIDTH, kheigh(219));
        }
         else if([string isEqualToString:@"9"]) {
             //            UIImage *image=[UIImage imageNamed:@"byj8"];
             //            CGFloat width= CGImageGetWidth(image.CGImage);
             //            float bl=APP_SCREEN_WIDTH/width;
             //            CGFloat fixelH = CGImageGetHeight(image.CGImage);
             //            CGFloat zuihou=fixelH*bl;
             
             return CGSizeMake(APP_SCREEN_WIDTH, kheigh(326));
         }
         else  {
             //            UIImage *image=[UIImage imageNamed:@"byj8"];
             //            CGFloat width= CGImageGetWidth(image.CGImage);
             //            float bl=APP_SCREEN_WIDTH/width;
             //            CGFloat fixelH = CGImageGetHeight(image.CGImage);
             //            CGFloat zuihou=fixelH*bl;
             NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",indexPath.row+1,self.TemplateId];
             NSDictionary *dic=[stand objectForKey:textIndex];
             
//             if (dic.count>2)
//             {
             
                  CGFloat height= [self createHeightWithString:dic[@"Text"] withFont:[dic[@"FontSize"] intValue]];
                 NSLog(@"height==%f",height);
                 if (height>kWidth(32)) {
                     return CGSizeMake(APP_SCREEN_WIDTH, kheigh(372)+height-kWidth(32));
                 }else{
                     return CGSizeMake(APP_SCREEN_WIDTH, kheigh(372)-height+kWidth(32));
                 }
//
//             }else
//             {
//                 return CGSizeMake(APP_SCREEN_WIDTH, kheigh(372));
//             }
//
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
        
    }else{
        [self setValueName:@"1" withKey:@"firstIn"];
        NSString * string=[NSString stringWithFormat:@"%ld",(long)sender.tag];
        
        if ([string isEqualToString:@"0"]) {
            [FCAppInfo shareManager].changeHB=@"12";
            [self setValueName:self->_dataNumberArr withKey:[NSString stringWithFormat:@"%@textNumArr",self.TemplateId]];
            [self setValueName:self->_ModuleIdArr withKey:[NSString stringWithFormat:@"%@ModuleIdArr",self.TemplateId]];
            
            NewHBViewController *newb=[[NewHBViewController alloc]init];
            [self.navigationController pushViewController:newb animated:YES];
            
        }
        else
        {
            
            [self createButton];
            
        }
    }
    
    
    

}
//点击 删除某一模块  原理是 删除我们点击的当前页面所对应的key。开始遍历所有包含text的key，将所选的位置和遍历的位置比较，当所选的位置在前的时候，所有的位置都向上移一位。 并且删除之前的位置上的东西
-(void)LeftButton:(UIButton*)sender{

    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    
//    删除文字部分
    NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",sender.tag+1,self.TemplateId];
    [stand removeObjectForKey:textIndex];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys])
    {
        if ([key containsString:[NSString stringWithFormat:@"%@text",self.TemplateId]]) {
            
            NSRange range = [key rangeOfString:self.TemplateId];
            NSString *str = [key substringToIndex:range.location];
          
            NSLog(@"%@",str);
            NSString * index=[key substringToIndex:str.length];
            
            if (sender.tag+1<[index intValue]) {
                NSString *nextIndex=[NSString stringWithFormat:@"%d%@text",[index intValue]-1,self.TemplateId];
                NSString *Index=[NSString stringWithFormat:@"%d%@text",[index intValue],self.TemplateId];
                
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
//            NSLog(@"--%@",key);
        }
    }
    
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@image",self.TemplateId]]&&![key containsString:[NSString stringWithFormat:@"%@imageheader",self.TemplateId]]) {
            NSLog(@"key==%@",key);
            NSRange range = [key rangeOfString:self.TemplateId];
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
               
                
              
                
            }
        }
        if ([key containsString:[NSString stringWithFormat:@"%@video",self.TemplateId]]) {
            NSLog(@"key==%@",key);
            NSRange range = [key rangeOfString:self.TemplateId];
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
                [stand synchronize];
                
                
                
            }
        }
        if ([key containsString:[NSString stringWithFormat:@"%@gif",self.TemplateId]]) {
            NSLog(@"key==%@",key);
            NSRange range = [key rangeOfString:self.TemplateId];
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
                [stand synchronize];
                
                
                
            }
        }
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_dataNumberArr removeObjectAtIndex:sender.tag];
         [self->_ModuleIdArr removeObjectAtIndex:sender.tag];
        [self.DataCollectionView reloadData];
    });
   
}


-(void)EditButton:(UIButton*)sender{
    NSLog(@"点击编辑文字%ld",(long)sender.tag);
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSString *textIndex=[NSString stringWithFormat:@"%ld%@text",sender.tag+1,self.TemplateId];
    NSDictionary *dic=[stand objectForKey:textIndex];
    NSString *text=  dic[@"Text"];
    
    NSString *key=[NSString stringWithFormat:@"%ld",sender.tag+1];
    EditViewController * edit=[[EditViewController alloc]init];
    edit.modeId=_ModuleIdArr[sender.tag];;
    edit.temID=self.TemplateId;
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
    
    NSString * currentindex=[NSString stringWithFormat:@"%lu%@text",(unsigned long)_dataNumberArr.count+1,self.TemplateId];
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    [guideAnimationView removeFromSuperview];
    ChooseView.hidden=YES;
    ChooseMViewController *choose=[[ChooseMViewController alloc]init];
    [choose setMyBlock:^(NSString *index,NSString*ModuleId) {
        
        if ([ModuleId isEqualToString:@"Module_1_2"]||[ModuleId isEqualToString:@"Module_4_2"]||[ModuleId isEqualToString:@"Module_5_1"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_dataNumberArr addObject:index];
                [self->_ModuleIdArr addObject:ModuleId];
                [self.DataCollectionView reloadData];
                [self.DataCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self->_dataNumberArr.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            });
        }else{
            NSArray * currentA=[FCAppInfo shareManager].pDic[ModuleId];
            // 采用随机生成的诗句或者美句。
            int y =(arc4random() % currentA.count);
            NSString *TextIndex=currentA[y];
            NSString *font1=@"15";
            NSDictionary *tdic=[self objectValueWith:[NSString stringWithFormat:@"%@tlist",self.TemplateId1]];
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            [stand setObject:dic forKey:currentindex];
            [stand synchronize];
            NSLog(@"--%@",currentA);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_dataNumberArr addObject:index];
                [self->_ModuleIdArr addObject:ModuleId];
                [self.DataCollectionView reloadData];
                [self.DataCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self->_dataNumberArr.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
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
                                  self->chooseImg=NO;
                                  self->chooseVideo=YES;
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
    TakePhotoViewController * vc=[TakePhotoViewController new];
    vc.takePhotoBlock = ^(UIImage *photoImage) {

        NSLog(@"%@",photoImage);
    };
    [self presentViewController:vc animated:NO completion:nil];
    [FCAppInfo shareManager].isfromPhoto=@"no";
//    [self openImagePickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
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
    _imgPicker.delegate = self;
    _imgPicker.allowsEditing = NO;
    _imgPicker.sourceType = type;
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
    _imgPicker = [[UIImagePickerController alloc] init];
    _imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    if ([_imgPicker.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [_imgPicker.navigationBar setBarTintColor:[UIColor colorWithPatternImage:bgImg]];
        [_imgPicker.navigationBar setTranslucent:NO];
        [_imgPicker.navigationBar setTintColor:[UIColor whiteColor]];
    }else{
        [_imgPicker.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [_imgPicker.navigationBar setTitleTextAttributes:attrs];
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
//    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[0]];//设置媒体类型为public.movie
    _imgPicker.mediaTypes=[NSArray arrayWithObjects:availableMedia[1], nil];
    [self presentViewController:_imgPicker animated:YES completion:nil];
    _imgPicker.delegate = self;//设置委托
}
#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
// 选择照片之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

     @autoreleasepool {
    
    if (chooseImg)
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
//        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage * naorImg= [image fixOrientation];
//            UIImage *jianqie= [UIImage thumbnailWithImage:naorImg size:CGSizeMake(APP_SCREEN_WIDTH+250, APP_SCREEN_HEIGHT+250)];
            [self cropImage:naorImg];
//        });
      
        
        
    }
    else{
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        
        NSString *stringUrl=[NSString stringWithFormat:@"%@",sourceURL];
        
        NSData *data = [NSData dataWithContentsOfURL:sourceURL]; //可以使用上传到服务器或者其他的
        NSLog(@"--%@--%lu",sourceURL,data.length/1024);
        if ([self getPictureData]+data.length/1024>1024*[[FCAppInfo shareManager].MaxXian intValue]) {
            [picker dismissViewControllerAnimated:YES completion:nil];
            [self showMessage:@"图片或视频过大"];
            
        }else{
            videoImage= [self getVideoPreViewImageWithPath:sourceURL];
            NSData * imageData= UIImageJPEGRepresentation(videoImage, 1);
            NSString *zuiIndex=[NSString stringWithFormat:@"%@%@%@image",lflimage,image1,self.TemplateId];
            NSString *zuiIndex1=[NSString stringWithFormat:@"%@%@%@video",lflimage,image1,self.TemplateId];
            
            NSString *zuiIndex2=[NSString stringWithFormat:@"%@%@%@gif123",lflimage,image1,self.TemplateId];
            NSDictionary * gifDic=@{@"gifString":stringUrl};
            
            NSDictionary * dic=@{@"image":imageData};
            NSDictionary * dic1=@{@"image":stringUrl};
            
            NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
                [stand setObject:dic forKey:zuiIndex];
                [stand setObject:dic1 forKey:zuiIndex1];
                [stand setObject:gifDic forKey:zuiIndex2];
                [stand synchronize];
            });
            
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
       
        
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
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell2=1=%ld",(long)sender.tag);
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili2;
    [self addImageviewTap];

}
-(void)Cell3AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell3=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili31;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell3Add1Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell3=2=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili32;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell4AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell4=1=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili4;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell5AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell5=2=%ld",(long)sender.tag);
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili5;
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell5Add1Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell5=2=%ld",(long)sender.tag);
     [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili5;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell5Add2Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell5=3=%ld",(long)sender.tag);
     [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili5;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"3";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell6AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
   NSLog(@"cell6=1=%ld",(long)sender.tag);
     [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili61;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell6Add1Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell6=2=%ld",(long)sender.tag);
     [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili62;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell6Add2Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell6=3=%ld",(long)sender.tag);
     [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili61;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"3";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell8=1=%ld",(long)sender.tag);
     [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"1";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8Add1Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell8=2=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"2";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8Add2Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell8=3=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"3";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell8Add3Button:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell8=4=%ld",(long)sender.tag);
    [FCAppInfo shareManager].bili=[FCAppInfo shareManager].bili8;
    lflimage=[NSString stringWithFormat:@"%ld",sender.tag+1];
    image1=@"4";
    ChooseView.hidden=YES;
    [self addImageviewTap];
}
-(void)Cell7AddButton:(UIButton*)sender{
    [FCAppInfo shareManager].isHeader=@"no";
    NSLog(@"cell7=1=%ld",(long)sender.tag);
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
    LFLView *circleView = [[LFLView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH/2.0-30, APP_SCREEN_HEIGHT/2.0-30, 60, 60)];
    circleView.arcFinishColor =UIColorFromHex(0x75AB33);
    circleView.arcUnfinishColor =UIColorFromHex(0x0D6FAE);
    circleView.arcBackColor =UIColorFromHex(0xEAEAEA);
    [self.view addSubview:circleView];
    self.circleView = circleView;
    self.circleView.percent=0.01;
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:getOssStsToken WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"获取上传图片的token%@",obj);
        
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
            [self wmy];
            
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
    
    //
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self->AlerayldData+=(bytesSent/1024);
           
            NSString *string=[NSString stringWithFormat:@"%f%%",0.1+(self->AlerayldData/self->SumData)*0.9];
             self.circleView.percent=[string floatValue]-0.01;
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
            
            [self->_ImageArr addObject:picUrl];
            NSLog(@"-上传图片的数量-%lu--%d",(unsigned long)self->_ImageArr.count,self->ZongSum);
            if (self->_ImageArr.count==self->ZongSum&&self.VideoArr.count==self->SureSum&&self->_GIFArr.count==self->SureSum) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self startWork];
                });
                
            }
            
        } else {
            NSLog(@"upload object failed, error: 0000000000000000%@" , task.error);
            
        }
        return nil;
    }];
    
    
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
            
            NSString *string=[NSString stringWithFormat:@"%f%%",0.1+(self->AlerayldData/self->SumData)*0.9];
            self.circleView.percent=[string floatValue]-0.01;
            if ([string floatValue]==1) {
                
                 self.circleView=nil;
                [self.circleView removeFromSuperview];
            }else{
               
            }
        });
    };
    
    
    
    OSSTask * putTask = [client putObject:put];

//    [putTask waitUntilFinished]; // 阻塞直到上传完成
    [putTask continueWithBlock:^id(OSSTask *task) {
        
        if (!task.error) {
            
            [self->_VideoArr addObject:videoUrl];
            NSLog(@"-上传视频的数量-%lu--%d",(unsigned long)self->_VideoArr.count,self->SureSum);
            if (self->_ImageArr.count==self->ZongSum&&self.VideoArr.count==self->SureSum&&self->_GIFArr.count==self->SureSum) {
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [self startWork];
                });
            }
        } else {
            NSLog(@"upload object failed, error: 0000000000000000%@" , task.error);
            
        }
        return nil;
    }];
//    [putTask waitUntilFinished];
    
    
}
-(void)uploadgifOSS:(NSString*)imageName{
    
    self.BobjectKey=[NSString createUuid];
    
    NSDictionary *dic = [self objectValueWith:imageName];
    NSString *dataStr=dic[@"image"];
    NSData *data1 = [NSData dataWithContentsOfFile:dataStr];//可以使用上传到服务器或者其他的
    NSLog(@"大小==%lu",data1.length/1024);
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
    put.objectKey =[NSString stringWithFormat:@"%@.gif",self.BobjectKey];
    put.uploadingData=data1;
    NSString * gifUrl=[NSString stringWithFormat:@"%@%@%@.gif",imageName,self.AccessDomain,self.BobjectKey];
     NSLog(@"走过的gifUrl==%@",gifUrl);
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        dispatch_async(dispatch_get_main_queue(), ^{
            self->AlerayldData+=(bytesSent/1024);
            
            NSString *string=[NSString stringWithFormat:@"%f%%",0.1+(self->AlerayldData/self->SumData)*0.9];
            self.circleView.percent=[string floatValue]-0.01;
            if ([string floatValue]==1) {
                
                self.circleView=nil;
                [self.circleView removeFromSuperview];
            }else{
                
            }
        });
    };
    
    
    
    OSSTask * putTask = [client putObject:put];
    
    //    [putTask waitUntilFinished]; // 阻塞直到上传完成
    [putTask continueWithBlock:^id(OSSTask *task) {
        
        if (!task.error) {
            NSLog(@"gifUrl==%@",gifUrl);
            [self->_GIFArr addObject:gifUrl];
            NSLog(@"-上传gif的数量-%lu--%d",(unsigned long)self->_VideoArr.count,self->SureSum);
            if (self->_ImageArr.count==self->ZongSum&&self.VideoArr.count==self->SureSum&&self->_GIFArr.count==self->SureSum) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self startWork];
                });
            }
        }
        else
        {
            NSLog(@"upload object failed, error: 0000000000000000%@" , task.error);
            
        }
        return nil;
    }];
    //    [putTask waitUntilFinished];
    
    
}
-(void)goNext{
    
    
}
#pragma 获取所有上传图片的大小
-(CGFloat)getPictureData{
    CGFloat sumFloat=0;
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [stand dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        if ([key containsString:[NSString stringWithFormat:@"%@image",self.TemplateId]]) {
            NSDictionary *dic = [self objectValueWith:key];
            NSData *data=dic[@"image"];
            CGFloat scout=data.length/1024;
            sumFloat+=scout;
        }else if([key containsString:[NSString stringWithFormat:@"%@video",self.TemplateId]]){
            NSDictionary *dic = [self objectValueWith:key];
            NSString *data=dic[@"image"];
            NSData *numdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:data]];
            CGFloat scout=numdata.length/1024;
            sumFloat+=scout;
        }
        else if([key containsString:[NSString stringWithFormat:@"%@gif",self.TemplateId]]){
            NSDictionary *dic = [self objectValueWith:key];
            NSString *data=dic[@"image"];
            NSData *numdata = [NSData dataWithContentsOfFile:data];
            CGFloat scout=numdata.length/1024;
            sumFloat+=scout;
        }
        
    }
    NSLog(@"--%f",sumFloat);
    return sumFloat;
}


#pragma 判断网络状态

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
            if ([self->yunxu isEqualToString:@"1"]) {
                int sum=0;
                int sumimage=0;
                int sumimage1=0;
                NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
                NSDictionary *dictionary = [stand dictionaryRepresentation];
                for(NSString *key in [dictionary allKeys]){
                    if ([key containsString:[NSString stringWithFormat:@"%@image",self.TemplateId]]) {
                        sumimage1+=1;
                        
                        NSLog(@"Sumkey==%@",key);
                         if ([key containsString:[NSString stringWithFormat:@"%@image",self.TemplateId]]&&![key containsString:@"jianqie"]&&![key containsString:@"imageheader"]){
                            sumimage+=1;
                        }
                    }
                    
                }
                
                //遍历查询应该有几个图片
                for (NSString * string in self->_dataNumberArr) {
                    if ([string isEqualToString:@"1"]) {
                        sum+=0;
                    }else if ([string isEqualToString:@"2"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"3"]) {
                        sum+=2;
                    }
                    else if ([string isEqualToString:@"4"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"5"]) {
                        sum+=3;
                    }
                    else if ([string isEqualToString:@"6"]) {
                        sum+=3;
                    }
                    else if ([string isEqualToString:@"7"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"8"]) {
                        sum+=4;
                    }
                    else if ([string isEqualToString:@"9"]) {
                        sum+=1;
                    }
                    else if ([string isEqualToString:@"10"]) {
                        sum+=1;
                    }
                }
                
                NSLog(@"sum==%d===sumimage=%d",sum,sumimage);
                if (sum==0) {
                    [self showMessage:@"至少上传一张图片"];
                    self->isClick=@"1";
                    self->StartJQ=@"no";
                    self->IsBack=@"0";
//                    [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                    [self.DataCollectionView reloadData];
                    return ;
                }
                if (sum>sumimage) {
                    [self showMessage:@"存在未上传图片或视频"];
                    self->isClick=@"1";
                    self->StartJQ=@"no";
                    self->IsBack=@"0";
//                     [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                    [self.DataCollectionView reloadData];
                    return;
                }
                //            [self getPictureData];
                
                self->ZongSum=sumimage1;
                [self loadPictureToken];
            }else{
                
            }
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你当前处于非WIFI环境下，提交将会使用手机流量，确定继续？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([self->yunxu isEqualToString:@"1"]) {
                    int sum=0;
                    int sumimage=0;
                    int sumimage1=0;
                    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
                    NSDictionary *dictionary = [stand dictionaryRepresentation];
                    for(NSString *key in [dictionary allKeys]){
                        if ([key containsString:[NSString stringWithFormat:@"%@image",self.TemplateId]]) {
                            sumimage1+=1;
                            
                            NSLog(@"Sumkey==%@",key);
                            if ([key containsString:[NSString stringWithFormat:@"%@image",self.TemplateId]]&&![key containsString:@"jianqie"]&&![key containsString:@"imageheader"]){
                                sumimage+=1;
                            }
                        }
                        
                    }
                    
                    //遍历查询应该有几个图片
                    for (NSString * string in self->_dataNumberArr) {
                        if ([string isEqualToString:@"1"]) {
                            sum+=0;
                        }else if ([string isEqualToString:@"2"]) {
                            sum+=1;
                        }
                        else if ([string isEqualToString:@"3"]) {
                            sum+=2;
                        }
                        else if ([string isEqualToString:@"4"]) {
                            sum+=1;
                        }
                        else if ([string isEqualToString:@"5"]) {
                            sum+=3;
                        }
                        else if ([string isEqualToString:@"6"]) {
                            sum+=3;
                        }
                        else if ([string isEqualToString:@"7"]) {
                            sum+=1;
                        }
                        else if ([string isEqualToString:@"8"]) {
                            sum+=4;
                        }
                        else if ([string isEqualToString:@"9"]) {
                            sum+=1;
                        }
                        else if ([string isEqualToString:@"10"]) {
                            sum+=1;
                        }
                    }
                    
                    NSLog(@"sum==%d===sumimage=%d",sum,sumimage);
                    if (sum>sumimage) {
                        [self showMessage:@"存在未上传图片或视频"];
                        self->isClick=@"1";
                        self->StartJQ=@"no";
                        self->IsBack=@"0";
//                         [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                         [self.DataCollectionView reloadData];
                        return;
                    }
                    if (sum==0) {
                        [self showMessage:@"至少上传一张图片"];
                        self->isClick=@"1";
                        self->StartJQ=@"no";
                        self->IsBack=@"0";
                         [self.DataCollectionView reloadData];
                        return ;
                    }
                    //            [self getPictureData];
                    
                     self->ZongSum=sumimage1;
                    [self loadPictureToken];
                }else{
                    self->StartJQ=@"no";
                    self->IsBack=@"0";
//                     [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                     [self.DataCollectionView reloadData];
                }
                
            }];
            UIAlertAction *cance=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
               self->isClick=@"1";
                self->StartJQ=@"no";
                self->IsBack=@"0";
//                 [self.DataCollectionView setContentOffset:CGPointMake(0, HEIGHT_TOP_MARGIN+kWidth(166)) animated:YES];
                 [self.DataCollectionView reloadData];
            }];
            [alertController addAction:confirm];
            [alertController addAction:cance];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil)   { // 视图是否正在使用
//        self.imgPicker = nil;
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        
    }
    
}
//开始调用接口
-(void)startWork{

    dispatch_async(dispatch_get_main_queue(), ^{
        self->hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self->hud setOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN)];
        NSLog(@"--%@",self->_ImageArr);
        [self.DataCollectionView reloadData];
        [self performSelector:@selector(upDetail) withObject:self afterDelay:0.5];
    });
    
   
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
    
    [self setValueName:@{@"image":data} withKey:[NSString stringWithFormat:@"jianqie%@image",self.TemplateId]];
//    UIImageWriteToSavedPhotosAlbum(lfl, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    return lfl;
}

- (UIImage *)captureWithFrame1
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
    
    self.qietuData=data;
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
