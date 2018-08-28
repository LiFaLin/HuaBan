//
//  HeaderImageViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/6/7.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "HeaderImageViewController.h"
#import "TakePhotoViewController.h"
#import "AlbumDetailsViewController.h"

@interface HeaderImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
     UIImage *HeaderImage;
     NSData *headImageData;
}
@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property(nonatomic,strong)NSString *accessKeyId;
@property(nonatomic,strong)NSString *accessKeySecret;
@property(nonatomic,strong)NSString *securityToken;
@property(nonatomic,strong)NSString *buketName;
@property(nonatomic,strong)NSString *AccessDomain;
@property(nonatomic,strong)NSString *EndPoint;
@property(nonatomic,strong)NSString *BobjectKey;
@property(nonatomic,strong)NSString *SobjectKey;
@property(nonatomic,strong)UIImageView*headerImage;
@end

@implementation HeaderImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人头像";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"] withBackStr:@"个人信息"];
    [self confinRightItemWithName:@"选择"];
    
    _headerImage=[[UIImageView alloc]init];
    _headerImage.frame=CGRectMake(0, 100, APP_SCREEN_WIDTH, APP_SCREEN_WIDTH);
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:self.headUrl] placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:_headerImage];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeImage:) name:@"PicutreFromPerson" object:nil];
    
}
-(void)popRightItemView{
    [self loadPictureToken];
    self.SobjectKey=[NSString createUuid];
    self.BobjectKey=[NSString createUuid];
    [self addImageviewTap];
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)changeImage:(NSNotification*)notification{
    HeaderImage=notification.userInfo[@"image"];
    
    _headerImage.image=HeaderImage;
//    if (self.headerImageBlock) {
//        self.headerImageBlock(HeaderImage);
//    }
//    NSLog(@"--%@--%@--%@--%@--%@",self.accessKeyId,self.accessKeySecret,self.securityToken,self.EndPoint,self.buketName);
    
//    [self updateUserPhoto];
    [self uploadBigOSS];
    [self uploadSmallOSS];
}

#pragma mark - 添加图片
-(void)addImageviewTap
{
    [FCAppInfo shareManager].isFrom=@"header";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *takePic = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [FCAppInfo shareManager].FromVC=@"person";
                                  [self takePhoto];
                              }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                [FCAppInfo shareManager].FromVC=@"person";
                                [self localPhoto];
                            }];
    [alert addAction:takePic];
    [alert addAction:photo];
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
    [FCAppInfo shareManager].bili=1;
    [FCAppInfo shareManager].isfromPhoto=@"no";
    TakePhotoViewController *uitpVC = [TakePhotoViewController new];
    uitpVC.takePhotoBlock = ^(UIImage *photoImage) {
        
        NSLog(@"%@",photoImage);
    };
    [self presentViewController:uitpVC animated:NO completion:nil];
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
    [FCAppInfo shareManager].bili=1;
    // 设备不可用  直接返回
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    _imgPicker = [[UIImagePickerController alloc] init];
    _imgPicker.sourceType = type;
    _imgPicker.delegate = self;
    _imgPicker.allowsEditing = NO;
    [self presentViewController:_imgPicker animated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
// 选择照片之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage * naorImg= [image fixOrientation];
//    UIImage *jianqie= [UIImage thumbnailWithImage:naorImg size:CGSizeMake(APP_SCREEN_WIDTH+250, APP_SCREEN_HEIGHT+250)];
    [self cropImage:naorImg];
    
    
}

- (void)cropImage: (UIImage *)image {
    AlbumDetailsViewController *viewController = [[AlbumDetailsViewController alloc] init];
    viewController.image = image;
    
    [_imgPicker presentViewController:viewController animated:NO completion:nil];
    viewController.pictureSelectedBlock = ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    };
}
-(void)loadPictureToken{
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

#pragma 上传头像
-(void)updateUserPhoto{
    
    NSString *bigUrl=[NSString stringWithFormat:@"%@%@.png",self.AccessDomain,self.BobjectKey];
    NSString *smallUrl=[NSString stringWithFormat:@"%@%@.png",self.AccessDomain,self.SobjectKey];
    
    
    NSLog(@"--%@--%@",bigUrl,smallUrl);
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Photo_Big":bigUrl,@"Photo_Small":smallUrl,@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Photo_Big":bigUrl,@"Photo_Small":smallUrl,@"Sign":string};
    [[TBHttpClient shareManager]FMAFNetWorkingPOSTwithUrlString:updateUserPhoto WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"上传头像%@",obj);
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

-(void)uploadBigOSS{
    
    UIImage *big=[UIImage thumbnailWithImage:HeaderImage size:CGSizeMake(600, 600)];
    
    NSData *data = [UIImage compressQualityImage:big WithMaxLength:300];
     NSLog(@"BobjectKey==%lu",data.length/2014);
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
    
    //
    //
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        
    };
    
    OSSTask * putTask = [client putObject:put];
    //[putTask waitUntilFinished]; // 阻塞直到上传完成
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            
            OSSPutObjectResult * result = task.result;
            NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
            
            
            
        } else {
            NSLog(@"upload object failed, error: 0000000000000000%@" , task.error);
            
        }
        return nil;
    }];
    [putTask waitUntilFinished];
    
    
}
-(void)uploadSmallOSS{
    UIImage *big=[UIImage thumbnailWithImage:HeaderImage size:CGSizeMake(100, 100)];
    
    NSData *data = [UIImage compressQualityImage:big WithMaxLength:300];
    NSLog(@"BobjectKey==%lu",data.length/2014);
     NSString *endpoint =[NSString stringWithFormat:@"https://%@",self.EndPoint];
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
    put.objectKey = [NSString stringWithFormat:@"%@.png",self.SobjectKey];;
    put.uploadingData=data;
    
    //
    
    //
    // 可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        
    };
    
    OSSTask * putTask = [client putObject:put];
    //[putTask waitUntilFinished]; // 阻塞直到上传完成
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            
            OSSPutObjectResult * result = task.result;
            NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUserPhoto];
            });
            
            
        } else {
            NSLog(@"upload object failed, error: 0000000000000000%@" , task.error);
            
        }
        return nil;
    }];
    [putTask waitUntilFinished];
    
    
}
@end
