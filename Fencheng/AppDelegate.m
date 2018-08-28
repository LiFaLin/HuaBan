//
//  AppDelegate.m
//  Fencheng
//
//  Created by lifalin on 2018/5/28.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "AppDelegate.h"
#import "FCLoginViewController.h"
#import "FCTabBarViewController.h"


@interface AppDelegate (){
    int openTime;
    int closeTime;
    int UsageTime;
    NSString *banben;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    FCTabBarViewController *login=[[FCTabBarViewController alloc]init];
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = login;
//    [self.window makeKeyAndVisible];
   [AvoidCrash makeAllEffective];
    
    
//    NSDictionary *lfldic=@{@"lfl":nilStr};
    
    
    FCTabBarViewController *login=[[FCTabBarViewController alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = login;
    [self.window makeKeyAndVisible];
    NSLog(@"--%@",NSHomeDirectory());
    NSLog(@"--%@",[NSString deviceModelName]);
    [WXApi registerApp:@"wx43b458fb2f33fc68"];
    
    NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [stand dictionaryRepresentation];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"fengchengFirstLaunch"])
    {
        for (id  key in dic) {
            if (![key isEqualToString:@"MyLawFirstLaunch"]||![key isEqualToString:@"DraftArr"]) {
                [stand removeObjectForKey:key];
            }
            
        }
        
        [stand synchronize];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"fengchengFirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   
    return YES;
}

-(void) onReq:(BaseReq*)req
{
    
}

-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]]) //判断是否为授权请求，否则与微信支付等功能发生冲突
    {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (![aresp.code isEmptyString])
        {
            NSLog(@"code %@",aresp.code);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatDidLoginNotification" object:self userInfo:@{@"code":aresp.code}];
        }
       
    }
    
    
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{

//
    
    NSString *urlStr=[url absoluteString];
    NSLog(@"url==%@",url);
    
    //
    if ([urlStr containsString:@"tencent"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else{
        return  [WXApi handleOpenURL:url delegate:self];
    }



    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
     NSLog(@"开始进入后台");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //后台关闭APP时 进行下面的设置 可调用 -(void)applicationDidBecomeActive:(UIApplication *)application;
    __block UIBackgroundTaskIdentifier identifier = [[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:^{
        if (identifier != UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:identifier];
            identifier = UIBackgroundTaskInvalid;
        }
    }];
    NSDateFormatter * dateFor=[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate date];
    int time= [date timeIntervalSince1970];
    NSString *dateString= [dateFor stringFromDate:date];
    closeTime=time;
    NSLog(@"进入后台的时间==%@--%d",dateString,closeTime);
    [self recordUserUsageTime];
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSDateFormatter * dateFor=[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate date];
    int time= [date timeIntervalSince1970];
    NSString *dateString= [dateFor stringFromDate:date];
    openTime=time;
    NSLog(@"重新进入app的时间==%@--%d",dateString,time);
//    [self openAPP];//没一次退回到后台，或者是关闭都要调用一下
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSDateFormatter * dateFor=[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate date];
    int time= [date timeIntervalSince1970];
    NSString *dateString= [dateFor stringFromDate:date];
    
    openTime=time;
    NSLog(@"进入app的时间==%@--%d",dateString,openTime);
    [self openAPP];//没一次退回到后台，或者是关闭都要调用一下
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    NSDateFormatter * dateFor=[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate date];
    int time= [date timeIntervalSince1970];
    NSString *dateString= [dateFor stringFromDate:date];
    
    NSLog(@"关闭后台的时间==%@---%d",dateString,time);
//    if ([[FCAppInfo shareManager].isBack isEqualToString:@"0"]) {
//        NSLog(@"删除所有");
//        //移除所有有关的text沙盒
//        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
//        NSDictionary *dictionary = [stand dictionaryRepresentation];
//        for(NSString *key in [dictionary allKeys]){
//            if ([key containsString:[NSString stringWithFormat:@"%@text",[FCAppInfo shareManager].TemplateId]]||[key containsString:[NSString stringWithFormat:@"%@image",[FCAppInfo shareManager].TemplateId]]||[key containsString:[NSString stringWithFormat:@"%@headerText",[FCAppInfo shareManager].TemplateId]]||[key containsString:[NSString stringWithFormat:@"%@video",[FCAppInfo shareManager].TemplateId]]) {
//                [stand removeObjectForKey:key];
//                [stand synchronize];
//            }
//        }
//    }else{
//        NSLog(@"不删");
//    }
//    
//    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
//    NSDictionary *dictionary = [stand dictionaryRepresentation];
//    for(NSString *key in [dictionary allKeys]){
//        if ([key containsString:[NSString stringWithFormat:@"%@text",[FCAppInfo shareManager].ScrapbookId]]||[key containsString:[NSString stringWithFormat:@"%@image",[FCAppInfo shareManager].ScrapbookId]]||[key containsString:[NSString stringWithFormat:@"%@headerText",[FCAppInfo shareManager].ScrapbookId]]) {
//            [stand removeObjectForKey:key];
//            [stand synchronize];
//        }
//        
//    }
    
}

#pragma 打开APP调用的接口
-(void)openAPP{
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSDictionary *dic=@{@"Device":[NSString deviceModelName],@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"Device":[NSString deviceModelName]};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:openApp WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
         NSString *msgStr = [NSString stringWithFormat:@"%@",[obj objectForKey:@"MsgCode"]];
        NSLog(@"-打开APP-%@",obj);
        if ([msgStr isEqualToString:@"1"])
        {
            NSDictionary *dataDic=[obj objectForKey:@"Data"];
            NSString * AccessToken=[NSString stringWithFormat:@"%@",dataDic[@"AccessToken"]];
            NSString * UserToken=[NSString stringWithFormat:@"%@",dataDic[@"UserToken"]];
            [self setValueName:AccessToken withKey:@"AccessToken"];
            [self setValueName:UserToken withKey:@"UserToken"];
            
        }
        else 
        {
            [self getNewToken];
            
        }
    } withfail:^(NSString *errorMsg) {
        
    }];
}


#pragma 记录时间的接口
-(void)recordUserUsageTime{
    UsageTime=closeTime-openTime;
    NSLog(@"--%d--%d--%d",closeTime,openTime,UsageTime);
    NSString *AccessToken= [self objectValueWith:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
//    NSString *device=[[NSString deviceModelName] removeString];
    NSDictionary *dic=@{@"Device":[NSString deviceModelName],@"UsageTime":[NSString stringWithFormat:@"%d",UsageTime],@"AccessToken":AccessToken};
    
    NSString *string= [self createSign:dic];
    
    NSDictionary *param=@{@"Sign":string,@"Device":[NSString deviceModelName],@"UsageTime":[NSString stringWithFormat:@"%d",UsageTime]};
    [[TBHttpClient shareManager]FMAFNetWorkingPOS21TwithUrlString:recordUserUsageTime WithParameters:param WithHUDshowText:@"" withView:nil withCompletion:^(NSString *returnCode, id obj) {
        NSLog(@"-记录时间APP-%@",obj);
        
    } withfail:^(NSString *errorMsg) {
        
    }];
    
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
-(void)setValueName:(id)value withKey:(NSString*)keyName{
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    [stand setObject:value forKey:keyName];
    
    [stand synchronize];
}
-(id)objectValueWith:(NSString*)key{
    NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
    return [stand objectForKey:key];
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
//                [self getSecond];
            }
            else if ([msgStr isEqualToString:@"0"])
            {
                [self getNewToken];
                
            }
            else if ([msgStr isEqualToString:@"-1"])
            {
//                [self showMessage:[obj objectForKey:@"Msg"]];
                
            }
            else if ([msgStr isEqualToString:@"-2"])
            {
//                [self showMessage:[obj objectForKey:@"Msg"]];
                
            }
            else if ([msgStr isEqualToString:@"-3"])
            {
//                [self gotoLogin];
                
            }
            else
            {
//                [self showMessage:[obj objectForKey:@"Msg"]];
                
            }
            
            
        }
    } withfail:^(NSString *errorMsg) {
        
    }];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"AppDelegate中调用applicationDidReceiveMemoryWarning:");
    //清除缓存
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",cachePath);
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}
-(void)loadUserInfo{
    //    [self getNewToken];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
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
            self->banben=dataDic[@"iPhoneClientVersion"];
            if ([self->banben isEqualToString:app_Version]) {
                
                
                NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
                
                NSDictionary *dictionary = [stand dictionaryRepresentation];
        
                for(NSString *key in [dictionary allKeys]){
                    
                    [stand removeObjectForKey:key];
                    [stand synchronize];
                }
                
            }
        
        }
        
        
        
        
    } withfail:^(NSString *errorMsg) {
        
    }];
}

@end
