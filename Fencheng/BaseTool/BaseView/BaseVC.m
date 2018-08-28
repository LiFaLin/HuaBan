//
//  BaseVC.m
//  Fencheng
//
//  Created by lifalin on 2018/5/29.
//  Copyright © 2018年 lifalin. All rights reserved.
//
//#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#import "BaseVC.h"
#import "FCLoginViewController.h"
#import "FCNavViewController.h"
@interface BaseVC ()<UIGestureRecognizerDelegate>

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//    [AvoidCrash makeAllEffective];
}
- (void)resetNav{
    //设置界面风格，每个新导航入口都要设定
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[UIColorFromHex(0x252a85), UIColorFromHex(0x122e56)] gradientType:GradientTypeUpleftToLowright imgSize:self.navigationController.navigationBar.frame.size];
    
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:bgImg];
        self.navigationController.navigationBar.translucent=NO;
    }else
    {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:bgImg];
        
    }
}

-(void)confinRightItemWithImg:(UIImage*)barItemImg
{
    if (barItemImg)
    {
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        menu.frame = CGRectMake(0, 0, 40, 40);
        [menu setImage:barItemImg forState:UIControlStateNormal];
        menu.contentMode = UIViewContentModeScaleAspectFit;
        [menu addTarget:self action:@selector(popRightItemView) forControlEvents:UIControlEventTouchUpInside];
        menu.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, -10);
        UIBarButtonItem *backItem =    [[UIBarButtonItem alloc] initWithCustomView:menu];
        [self.navigationItem setRightBarButtonItems:@[backItem]];
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;
        
    }
}

-(void)confinRightItemWithImg:(UIImage*)barItemImg withImage:(UIImage*)image{
    if (barItemImg)
    {
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        menu.frame = CGRectMake(0, 0, 40, 40);
        [menu setImage:barItemImg forState:UIControlStateNormal];
        menu.contentMode = UIViewContentModeScaleAspectFit;
        [menu addTarget:self action:@selector(popRightItemView) forControlEvents:UIControlEventTouchUpInside];
        menu.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, -10);
        UIBarButtonItem *backItem =    [[UIBarButtonItem alloc] initWithCustomView:menu];
        
        UIButton *menu1 = [UIButton buttonWithType:UIButtonTypeCustom];
        menu1.frame = CGRectMake(40, 0, 40, 40);
        [menu1 setImage:image forState:UIControlStateNormal];
        menu1.contentMode = UIViewContentModeScaleAspectFit;
        [menu1 addTarget:self action:@selector(popRight1ItemView) forControlEvents:UIControlEventTouchUpInside];
        menu1.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, -10);
        UIBarButtonItem *backItem1 =    [[UIBarButtonItem alloc] initWithCustomView:menu1];
        
        [self.navigationItem setRightBarButtonItems:@[backItem,backItem1]];
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;
        
    }
}
-(void)confinRightItemWithName:(NSString*)name{
    if (name)
    {
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        menu.frame = CGRectMake(0, 0, 40, 40);
        [menu setTitle:name forState:UIControlStateNormal];
        [menu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        menu.contentMode = UIViewContentModeScaleAspectFit;
        menu.titleLabel.font=[UIFont systemFontOfSize:15];
        [menu addTarget:self action:@selector(popRightItemView) forControlEvents:UIControlEventTouchUpInside];
        menu.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 10, -5);
        menu.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        UIBarButtonItem *backItem =    [[UIBarButtonItem alloc] initWithCustomView:menu];
        [self.navigationItem setRightBarButtonItems:@[backItem]];
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;
        
    }
}
-(void)confinRight1ItemWithName:(NSString*)name{
    if (name)
    {
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        menu.frame = CGRectMake(0, 0, 40, 40);
        [menu setTitle:name forState:UIControlStateNormal];
        [menu setTitleColor:UIColorFromHex(0x979797) forState:UIControlStateNormal];
        menu.contentMode = UIViewContentModeScaleAspectFit;
        menu.titleLabel.font=[UIFont systemFontOfSize:15];
        [menu addTarget:self action:@selector(popRightItemView) forControlEvents:UIControlEventTouchUpInside];
        menu.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 10, -5);
        menu.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        UIBarButtonItem *backItem =    [[UIBarButtonItem alloc] initWithCustomView:menu];
        [self.navigationItem setRightBarButtonItems:@[backItem]];
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;
        
    }
}
-(void)confinLeftItemWithImg:(UIImage*)barItemImg{
    if (barItemImg)
    {
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        menu.frame = CGRectMake(0, 0, 40, 40);
        [menu setImage:barItemImg forState:UIControlStateNormal];
        menu.contentMode = UIViewContentModeScaleAspectFit;
        [menu addTarget:self action:@selector(popLeftItemView) forControlEvents:UIControlEventTouchUpInside];
        menu.imageEdgeInsets = UIEdgeInsetsMake(10, -30, 10, 10);
        UIBarButtonItem *backItem =    [[UIBarButtonItem alloc] initWithCustomView:menu];
        [self.navigationItem setLeftBarButtonItems:@[backItem]];
    }else
    {
        self.navigationItem.leftBarButtonItems = nil;
        
    }
}
-(void)popLeftItemView
{
   
}
-(void)popRightItemView
{
    
}
-(void)popRight1ItemView
{
    
}
/**
 *  后退按钮
 */
-(void)confinLeftItemWithImg:(UIImage*)barItemImg withBackStr:(NSString*)backStr
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 40);
    [backButton setImage:barItemImg forState:UIControlStateNormal];
    backButton.contentMode = UIViewContentModeScaleAspectFit;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    
    CGSize textSize = [backStr boundingRectWithSize:CGSizeMake((APP_SCREEN_WIDTH-150), 44) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    if (backStr.length != 0)
    {
        
        if (textSize.width > 80)
        {
            textSize.width = 80;
        }
        backButton.titleLabel.font =[UIFont fontWithName:@"Calibri" size:15.0];
        backButton.frame = CGRectMake(0, 0, barItemImg.size.width+textSize.width+10, 40);
        [backButton setTitle:backStr forState:UIControlStateNormal];
        backButton.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;
        backButton.backgroundColor = [UIColor clearColor];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
        }else
        {
            backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, textSize.width+5);
            //button标题的偏移量，这个偏移量是相对于图片的
            backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
            backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }else
        {
            backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        }
    }
    [backButton addTarget:self action:@selector(popLeftItemView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem =    [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationItem setLeftBarButtonItems:@[backItem]];
    
    if (backStr.length != 0)
    {
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.navigationItem.leftBarButtonItem.customView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:barItemImg.size.width+textSize.width+10];
        
        NSLayoutConstraint *heightConstraintWidth = [NSLayoutConstraint constraintWithItem:self.navigationItem.leftBarButtonItem.customView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:barItemImg.size.width+textSize.width+10];
        
        [self.navigationItem.leftBarButtonItem.customView addConstraint:heightConstraint];
        [self.navigationItem.leftBarButtonItem.customView addConstraint:heightConstraintWidth];
    }
    
}
-(void)showMessage:(NSString *)message;
{
    UIWindow *win=[[UIApplication sharedApplication].windows objectAtIndex:1];
    MBProgressHUD *hud;
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
    [hud hideAnimated:YES afterDelay:1];
}
-(void)showMessage1:(NSString *)message
{
    UIWindow *win=[[UIApplication sharedApplication].windows objectAtIndex:1];
    MBProgressHUD *hud;
    if (win != nil) {
        hud = [MBProgressHUD showHUDAddedTo:win animated:YES];
    }else if (self.view.window != nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    }
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    [hud setOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN)];
    if (message) {
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont fontWithName:@"Calibri" size:15.0]; //Johnkui - added
        hud.margin = 20.f;
    }
    [hud hideAnimated:YES afterDelay:1];
    
}
-(void)setValueName:(id)value withKey:(NSString*)keyName{
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    [stand setObject:value forKey:keyName];
    
    [stand synchronize];
}
-(id)objectValueWith:(NSString*)key{
     NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    return [stand objectForKey:key];
}
-(NSString*)removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}
-(NSString*)createSign:(NSDictionary*)dic{
    NSString *sign=@"";
    NSArray *keys = [dic allKeys];
    // 按照ASCII 码排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    // 拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (![[dic objectForKey:categoryId] isEqualToString:@""]&&![[dic objectForKey:categoryId] isEqualToString:@"key"]&&![[dic objectForKey:categoryId] isEqualToString:@"sign"]) {
            
            sign= [sign stringByAppendingFormat:@"%@=%@&",categoryId,dic[categoryId]];
        }
    }
    sign=[self removeLastOneChar:sign];
    NSString *string= [sign MD5Value];
    return string;
}
-(void)getNewToken{
    
    
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"AccessToken":AccessToken};
    NSString *string=[self createSign:dic];
    NSDictionary *param=@{@"Sign":string};

    [[TBHttpClient shareManager]FMAFNetWorkingPOS11TwithUrlString:getNewToken WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"更新token--%@",obj);
        {
            
            NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
            
            
            if ([msgStr isEqualToString:@"1"])
            {
                
                NSDictionary *dataDic=[obj objectForKey:@"Data"];
                NSString * AccessToken=[NSString stringWithFormat:@"%@",dataDic[@"AccessToken"]];
                NSString * UserToken=[NSString stringWithFormat:@"%@",dataDic[@"UserToken"]];
                [self setValueName:AccessToken withKey:@"AccessToken"];
                [self setValueName:UserToken withKey:@"UserToken"];
                
                //监听当调用getNewtoken成功时，再次访问原来接口
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"getNewToken" object:self userInfo:nil];
                [self getSecond];
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
            
            
        }
    } withfail:^(NSString *errorMsg) {
        
    }];
}
-(void)gotoLogin{
    FCLoginViewController *fc=[[FCLoginViewController alloc]init];
    FCNavViewController *nav=[[FCNavViewController alloc]initWithRootViewController:fc];
    UIWindow *window=[[UIApplication sharedApplication]delegate].window;
    window.rootViewController=nav;
//    [self presentViewController:nav animated:YES completion:nil];
}
-(void)getSecond{
    NSLog(@"");
}
@end
