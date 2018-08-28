//
//  AlbumDetailsViewController.m
//  CameraDemo
//
//  Created by yml_hubery on 2017/6/10.
//  Copyright © 2017年 yh. All rights reserved.
//

#import "AlbumDetailsViewController.h"
#import "PhotoClipCoverView.h"
@interface AlbumDetailsViewController (){
    MBProgressHUD *hud;
}

/** 图片显示 */
@property (strong, nonatomic) UIImageView *imageV;

/** 图片加载后的初始位置 */
@property (assign, nonatomic) CGRect norRect;

/** 裁剪框frame */
@property (assign, nonatomic) CGRect showRect;

/** 用于判断是否是放大操作 */
@property (assign, nonatomic) CGFloat lastImageW;


@end

@implementation AlbumDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self createSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)createSubViews{
    
    self.imageV = [[UIImageView alloc] init];
    if (self.image) {
        CGFloat ret = self.image.size.height / self.image.size.width;
        CGFloat imageViewW = SCREEN_WIDTH;
        CGFloat imageViewH = imageViewW * ret;
        self.imageV.frame = CGRectMake(0, (SCREEN_HEIGHT - imageViewH) / 2.0, imageViewW, imageViewH);
        self.norRect = self.imageV.frame;
        self.imageV.image = self.image;
    }
    [self.view addSubview:self.imageV];
    
    PhotoClipCoverView *coverView = [[PhotoClipCoverView alloc] initWithFrame:self.view.bounds];
    [coverView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGR:)]];
    [coverView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGR:)]];
    CGFloat width=SCREEN_WIDTH;
    CGFloat height=width/[FCAppInfo shareManager].bili;
    NSLog(@"--%f---%f",[FCAppInfo shareManager].bili,height);
    self.showRect = CGRectMake(0, APP_SCREEN_HEIGHT/2.0-height/2.0,width ,height);
    coverView.showRect = self.showRect;
    [self.view addSubview:coverView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60)];
    bottomView.backgroundColor = [UIColor blackColor];
    [coverView addSubview:bottomView];
    
    if ([[FCAppInfo shareManager].isfromPhoto isEqualToString:@"yes"]) {
        //重拍
        UIButton *remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        remarkBtn.frame = CGRectMake(10, 15, 60, 30);
        [remarkBtn setTitle:@"重选" forState:UIControlStateNormal];
        [remarkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        remarkBtn.backgroundColor = [UIColor clearColor];
        remarkBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [remarkBtn addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:remarkBtn];
        
        //使用照片
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(bottomView.frame.size.width - 90, 15, 80, 30);
        [sureBtn setTitle:@"使用照片" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.backgroundColor = [UIColor clearColor];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [sureBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:sureBtn];
    }else{
        
        //使用照片
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(bottomView.frame.size.width - 90, 15, 80, 30);
        [sureBtn setTitle:@"使用照片" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.backgroundColor = [UIColor clearColor];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [sureBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:sureBtn];
    }
    
    
}

- (void)setImage:(UIImage *)image{
    
    if (image) {
        CGFloat ret = image.size.height / image.size.width;
        _imageV.height = _imageV.width * ret;
        _imageV.frame = CGRectMake(1, (SCREEN_HEIGHT - _imageV.height) / 2.0, SCREEN_WIDTH - 2, _imageV.height);
        _norRect = _imageV.frame;
        _imageV.image = image;
    }
    
    _image = image;
}

#pragma mark -- 拖动

- (void)panGR:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender translationInView:self.view];
    
    _imageV.center = CGPointMake(_imageV.centerX + point.x, _imageV.centerY + point.y);
    [sender setTranslation:CGPointZero inView:self.view];
    
    //手势结束，调整 imageView 位置
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (_imageV.origin.x > _showRect.origin.x ||
            _imageV.origin.y > _showRect.origin.y ||
            _imageV.origin.x + _imageV.size.width < _showRect.origin.x + _showRect.size.width ||
            _imageV.origin.y + _imageV.size.height < _showRect.origin.y + _showRect.size.height) {
            
            CGRect newRect = _imageV.frame;
            if (_imageV.origin.x > _showRect.origin.x) {
                newRect.origin.x = _showRect.origin.x;
            }
            
            if (_imageV.origin.y > _showRect.origin.y &&
                _imageV.frame.size.height > _showRect.size.height)
            {
                newRect.origin.y = _showRect.origin.y;
            }
            else if (_imageV.origin.y > _showRect.origin.y &&
                     _imageV.frame.size.height <= _showRect.size.height)
            {
                newRect.origin.y = (SCREEN_HEIGHT - _imageV.frame.size.height) / 2.0;
            }
            
            if ((_imageV.origin.x + _imageV.size.width < _showRect.origin.x + _showRect.size.width) )
            {
                newRect.origin.x += _showRect.origin.x + _showRect.size.width - (_imageV.origin.x + _imageV.size.width);
            }
            
            
            if ((_imageV.origin.y + _imageV.size.height < _showRect.origin.y + _showRect.size.height) &&
                (_imageV.frame.size.height > _showRect.size.height)) {
                newRect.origin.y += _showRect.origin.y + _showRect.size.height - (_imageV.origin.y + _imageV.size.height);
            }
            else if ((_imageV.origin.y + _imageV.size.height < _showRect.origin.y + _showRect.size.height) &&
                     (_imageV.frame.size.height <= _showRect.size.height))
            {
                newRect.origin.y = (SCREEN_HEIGHT - _imageV.frame.size.height) / 2.0;
            }
            
            [UIView animateWithDuration:0.3f animations:^{
                self->_imageV.frame = newRect;
            }];
        }
    }
}

#pragma mark -- 缩放

- (void)pinGR:(UIPinchGestureRecognizer *)sender{
    
    _imageV.transform = CGAffineTransformScale(_imageV.transform, sender.scale, sender.scale);
    
    //缩放结束，调整 imageView 位置
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        CGRect newRect = _imageV.frame;
        if (_imageV.frame.size.width <= _showRect.size.width) {
            
            CGFloat ret = _image.size.height / _image.size.width;
            newRect.size.width = _showRect.size.width;
            newRect.size.height = _showRect.size.width * ret;
            newRect.origin.x = _showRect.origin.x;
            newRect.origin.y = (SCREEN_HEIGHT - newRect.size.height) / 2.0;
            
        }
        else{
            
            if (newRect.size.width < _lastImageW){
                
                if (_imageV.centerX <= _showRect.origin.x + _showRect.size.width / 2.0) {
                    newRect.origin.x = _showRect.origin.x + _showRect.size.width - newRect.size.width;
                }else{
                    newRect.origin.x = _showRect.origin.x;
                }
                
                if (_imageV.centerY <= _showRect.origin.y + _showRect.size.height / 2.0) {
                    newRect.origin.y = _showRect.origin.y + _showRect.size.height - newRect.size.height;
                }else{
                    newRect.origin.y = _showRect.origin.y;
                }
            }
            
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            self->_imageV.frame = newRect;
        }];
        
        _lastImageW = newRect.size.width;
    }
    
    sender.scale = 1.0;
}

#pragma mark -- 取消

- (void)leftButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 完成

- (void)rightButtonClicked{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [self nextButton];
    });
}

-(void)nextButton{
    CGRect clipRect = CGRectZero;
    CGFloat h = 0;
    CGFloat w = 0;
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat clipW = 0;
    CGFloat clipH = 0;
    
    if (_imageV.size.width <= _showRect.size.width) {   //图片没有放大
        
        if (_imageV.size.height <= _showRect.size.height)  //图片高度小于等于裁剪框高度，按图片高度截取正方形
        {
            h = _imageV.size.height;
            w = _imageV.size.width;
            
            originX = (_imageV.size.width - w) / 2.0 / _imageV.size.width * _image.size.width;
            originY = 0;
        }
        else{  //图片高度大于裁剪框高度，按裁剪框截取
            
            h = _showRect.size.height;
            w = _showRect.size.width;
            
            originX = 0;
            originY = (_showRect.origin.y - _imageV.frame.origin.y) / _imageV.size.height * _image.size.height;
        }
        
    }else{   //图片被放大
        
        if (_imageV.size.height <= _showRect.size.height) {  //图片高度小于等于裁剪框高度，按图片高度截取正方形
            
            h = _imageV.size.height;
            w = _imageV.size.width;
            
            originX = (_showRect.origin.x - _imageV.frame.origin.x + (_showRect.size.width - w) / 2.0) / _imageV.size.width * _image.size.width;
            originY = 0;
            
        }
        else{  //图片高度大于裁剪框高度，按裁剪框截取
            
            h = _showRect.size.height;
            w = _showRect.size.width;
            
            originX = (_showRect.origin.x - _imageV.frame.origin.x) / _imageV.frame.size.width * _image.size.width;
            originY = (_showRect.origin.y - _imageV.frame.origin.y) / _imageV.frame.size.height * _image.size.height;
        }
    }
    
    clipW = w / _imageV.size.width * _image.size.width;
    clipH = h / _imageV.size.height * _image.size.height;
    
    clipRect = CGRectMake(originX, originY, clipW, clipH);
    
    if ([[FCAppInfo shareManager].isFrom isEqualToString:@"header"] ) {
        if (self.pictureSelectedBlock) {
            self.pictureSelectedBlock();
        }
        [_imageV removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PicutreFromPerson" object:nil userInfo:@{@"image":self.image}];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
       
        
        UIImage *image = [self imageFromImage:self.image inRect:clipRect]; //先剪裁
        //后压缩图片
        NSData * data=[UIImage compressQualityImage:image WithMaxLength:300];
        NSLog(@"%lu",data.length/1024);
        
        
        if (self.pictureSelectedBlock) {
            self.pictureSelectedBlock();
        }
        
        [_imageV removeFromSuperview];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PicutreFromAlbum" object:nil userInfo:@{@"image":data}];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
        
        if ([[FCAppInfo shareManager].isfromPhoto isEqualToString:@"yes"]) {
            
        }else{
            [self saveImageToPhotoAlbum:image];
        }
    }
}
//裁剪方法
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    @autoreleasepool {
        //将UIImage转换成CGImageRef
        CGImageRef sourceImageRef = [image CGImage];
        
        //按照给定的矩形区域进行剪裁
        CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
        
        //将CGImageRef转换成UIImage
        UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
        
        //返回剪裁后的图片
       
//        UIGraphicsBeginImageContextWithOptions(newImage.size, NO, newImage.scale);
//        [newImage drawInRect:(CGRect){0, 0, newImage.size}];
//        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//       UIImage *imageName= [newImage fixOrientation];
       return newImage;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showMessage:(NSString *)message;
{
    UIWindow *win=[[UIApplication sharedApplication].windows objectAtIndex:1];
    
    if (win != nil) {
        hud = [MBProgressHUD showHUDAddedTo:win animated:YES];
    }else if (self.view.window != nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    }
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [hud setOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN)];
    if (message) {
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont fontWithName:@"Calibri" size:15.0]; //Johnkui - added
        hud.margin = 20.f;
    }
   
}
- (void)saveImageToPhotoAlbum:(UIImage *)savedImage{
    
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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
