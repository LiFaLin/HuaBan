//
//  HttpClient.m
//  XiCiNewApp
//
//  Created by GaoLin on 15/4/24.
//  Copyright (c) 2015年 www.xici.net  All rights reserved.
//

#import "TBHttpClient.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "FCAppInfo.h"
@interface TBHttpClient (){
    NSString *_reqUrl;
    MBProgressHUD *progressHUD;

}
@property (nonatomic, readwrite, strong)NSDictionary  *requestParams;
@property(nonatomic,strong)NSURLSessionUploadTask *task;

@end


@implementation TBHttpClient
-(void)cancelRequest
{
    if(self.task) {
        [self.task cancel];//取消当前界面的数据请求.
    }
}
#pragma mark - instancetype
+(TBHttpClient *)shareManager
{
    static TBHttpClient *requestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[self alloc] init];
    });
    return requestManager;
}


-(instancetype)init
{
    self = [super init];
    if (self) {

        
    }
    return self;
}


-(NSString *)getServiceUrl:(ServiceType)type{
    NSString *url = @"";
    switch (type) {

        case sendRegistSecCode:
            url = SERVICE_URL_SendRegistSecCode;
            break;
        case openApp:
            url = SERVICE_URL_openApp;
            break;
        case recordUserUsageTime:
            url = SERVICE_URL_recordUserUsageTime;
            break;
        case register1:
            url = SERVICE_URL_REGIST;
            break;
        case login:
            url = SERVICE_URL_Login;
            break;
        case logout:
            url = SERVICE_URL_logout;
            break;
        case getUserInfo:
            url = SERVICE_URL_getUserInfo;
            break;
        case updateUserNickname:
            url = SERVICE_URL_updateUserNickname;
            break;
        case updateUserSex:
            url = SERVICE_URL_updateUserSex;
            break;
        case updateUserBirthday:
            url = SERVICE_URL_updateUserBirthday;
            break;
        case getNewToken:
            url = SERVICE_URL_getNewToken;
            break;
        case updateUserEmail:
            url = SERVICE_URL_updateUserEmail;
            break;
        case getOssStsToken:
            url = SERVICE_URL_getOssStsToken;
            break;
        case updateUserPhoto:
            url = SERVICE_URL_updateUserPhoto;
            break;
        case sendChangePhoneNumberSecCode:
            url = SERVICE_URL_sendChangePhoneNumberSecCode;
            break;
        case checkChangePhoneNumberSecCode:
            url = SERVICE_URL_checkChangePhoneNumberSecCode;
            break;
        case sendSetPhoneNumberSecCode:
            url = SERVICE_URL_sendSetPhoneNumberSecCode;
            break;
        case updateUserPhoneNumber:
            url = SERVICE_URL_updateUserPhoneNumber;
            break;
        case thirdPartyLogin:
            url = SERVICE_URL_thirdPartyLogin;
            break;
        case setUserPhoneNumberUserPassword:
            url = SERVICE_URL_setUserPhoneNumberUserPassword;
            break;
        case sendSetPhoneNumberUserPasswordSecCode:
            url = SERVICE_URL_sendSetPhoneNumberUserPasswordSecCode;
            break;
        case sendForgetUserPasswordSecCode:
            url = SERVICE_URL_sendForgetUserPasswordSecCode;
            break;
        case resetUserPasswordBySecCode:
            url = SERVICE_URL_resetUserPasswordBySecCode;
            break;
        case getTemplateList:
            url = SERVICE_URL_getTemplateList;
            break;
        case getTemplateBackgroundImageList:
            url = SERVICE_URL_getTemplateBackgroundImageList;
            break;
        case saveScrapbook:
            url = SERVICE_URL_saveScrapbook;
            break;
        case getMyScrapbookList:
            url = SERVICE_URL_getMyScrapbookList;
            break;
        case deleteScrapbook:
            url = SERVICE_URL_deleteScrapbook;
            break;
        case getScrapbookDetailByScrapbookId:
            url = SERVICE_URL_getScrapbookDetailByScrapbookId;
            break;
        case updateScrapbook:
            url = SERVICE_URL_updateScrapbook;
            break;
        case updateScrapbookName:
            url = SERVICE_URL_updateScrapbookName;
            break;
        case sendFirstSetPhoneNumberSecCode:
            url = SERVICE_URL_sendFirstSetPhoneNumberSecCode;
            break;
        case checkFirstSetPhoneNumberSecCode:
            url = SERVICE_URL_checkFirstSetPhoneNumberSecCode;
            break;
        case setFirstUserPassword:
            url = SERVICE_URL_setFirstUserPassword;
            break;
        case bindingAccount:
            url = SERVICE_URL_bindingAccount;
            break;
        case changeScrapbookLike:
            url = SERVICE_URL_changeScrapbookLike;
            break;
        case changeCommentLike:
            url = SERVICE_URL_changeCommentLike;
            break;
        case changeCommentStatus:
            url = SERVICE_URL_changeCommentStatus;
            break;
        case addScrapbookComment:
            url = SERVICE_URL_addScrapbookComment;
            break;
        default:
            break;
    }

    return url;
}
#pragma mark -新版AFNetworking
-(void)get:(ServiceType)type param:(id)p success:(void (^)(id))success failure:(void (^)(id))failure{
        __weak typeof(self) weakSelf = self;
    //使用cookie
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cookiename=[defaults objectForKey:@"cookie.name"];
    NSString *cookievalue=[defaults objectForKey:@"cookie.value"];
    [defaults synchronize];
    
    NSString *service = [weakSelf getServiceUrl:type];
    NSString *url = [NSString stringWithFormat:@"%@%@",XICI_TCAPI_BASE_URL,service];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //网络请求超时
    [manager.requestSerializer setTimeoutInterval:30];
    //使用cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@", cookiename, cookievalue] forHTTPHeaderField:@"Cookie"];
    [manager GET:url parameters:p progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //以及获取cookie和使用cookie
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for(NSHTTPCookie *cookie in [cookieJar cookies])
        {
            
            if ([cookie.name isEqualToString:@"JSESSIONID"]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:cookie.name forKey:@"cookie.name"];
                [defaults setObject:cookie.value forKey:@"cookie.value"];
                [defaults synchronize];
            }
            
        }
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        if (responseObject) {
            success(obj);
        }
        
    }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (error) {
                 failure(error);
             }
         }];
    
}
-(void)post:(ServiceType)type param:(id)p success:(void (^)(id))success failure:(void (^)(id))failure{
        __weak typeof(self) weakSelf = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *AccessToken=[defaults objectForKey:@"AccessToken"];
    NSString *UserToken=[defaults objectForKey:@"UserToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    NSString *service = [weakSelf getServiceUrl:type];
    NSString *url = [NSString stringWithFormat:@"%@%@",XICI_TCAPI_BASE_URL,service];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //网络请求超时
    [manager.requestSerializer setTimeoutInterval:30];
    //使用cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",AccessToken] forHTTPHeaderField:@"AccessToken"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",UserToken] forHTTPHeaderField:@"UserToken"];
    [manager POST:url parameters:p progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        if (responseObject) {
            success(obj);
        }
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (error) {
                  failure(error);
              }
          }];
    
}
- (void)del:(ServiceType)type param:(id)p success:(void (^)(id responseObject))success failure:(void(^)(id responseObject))failure{
        __weak typeof(self) weakSelf = self;
    //使用cookie
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cookiename=[defaults objectForKey:@"cookie.name"];
    NSString *cookievalue=[defaults objectForKey:@"cookie.value"];
    
    NSString *service = [weakSelf getServiceUrl:type];
    NSString *url = [NSString stringWithFormat:@"%@%@",XICI_TCAPI_BASE_URL,service];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //网络请求超时
    [manager.requestSerializer setTimeoutInterval:30];
    //使用cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@", cookiename, cookievalue] forHTTPHeaderField:@"Cookie"];
    [manager DELETE:url parameters:p success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //以及获取cookie和使用cookie
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for(NSHTTPCookie *cookie in [cookieJar cookies])
        {
            
            if ([cookie.name isEqualToString:@"JSESSIONID"]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:cookie.name forKey:@"cookie.name"];
                [defaults setObject:cookie.value forKey:@"cookie.value"];
                [defaults synchronize];
            }
            
        }
        
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        if (responseObject) {
            success(obj);
        }
        
    }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    
                    failure(error);
                    
                }
                
            }];
    
}

- (void)put:(ServiceType)type param:(id)p success:(void (^)(id responseObject))success failure:(void(^)(id responseObject))failure{
        __weak typeof(self) weakSelf = self;
    //使用cookie
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cookiename=[defaults objectForKey:@"cookie.name"];
    NSString *cookievalue=[defaults objectForKey:@"cookie.value"];
    
    NSString *service = [weakSelf getServiceUrl:type];
    NSString *url = [NSString stringWithFormat:@"%@%@",XICI_TCAPI_BASE_URL,service];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //网络请求超时
    [manager.requestSerializer setTimeoutInterval:30];
    //使用cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@", cookiename, cookievalue] forHTTPHeaderField:@"Cookie"];
    [manager PUT:url parameters:p success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //以及获取cookie和使用cookie
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for(NSHTTPCookie *cookie in [cookieJar cookies])
        {
            
            if ([cookie.name isEqualToString:@"JSESSIONID"]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:cookie.name forKey:@"cookie.name"];
                [defaults setObject:cookie.value forKey:@"cookie.value"];
                [defaults synchronize];
            }
            
        }
        
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        if (responseObject) {
            success(obj);
        }
        
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             if (error) {
                 
                 failure(error);
                 
             }
         }];
}

-(void)FMAFNetWorkingPOSTwithUrlString:(ServiceType)type
                        WithParameters:(id)IDparameters
                       WithHUDshowText:(NSString *)text
                              withView:(UIView*)currentView
                        withCompletion:(void(^)(NSString * returnCode,id obj))block withfail:(void(^)(NSString * errorMsg))failblock{
    __weak typeof(self) weakSelf = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *AccessToken=[defaults objectForKey:@"AccessToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    MBProgressHUD *hud = nil;
    
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    NSString *service = [weakSelf getServiceUrl:type];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",XICI_TCAPI_BASE_URL,service];
    if (![text isEqualToString:@"NOHUD"])
    {
        hud = [MBProgressHUD showHUDAddedTo:currentView?:frontWindow animated:YES];
        [hud setOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN)];
        if (text.length != 0)
        {
            hud.label.text = text;
            hud.mode = MBProgressHUDModeText;
        }
        
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //允许非权威机构颁发的证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    //使用cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",AccessToken] forHTTPHeaderField:@"AccessToken"];
    //也不验证域名一致性
    manager.securityPolicy.validatesDomainName = NO;
    //关闭缓存避免干扰测试
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = HTTP_TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:url parameters:IDparameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(hud)
        {
            [hud hideAnimated:YES afterDelay:0.2];
        }
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"FMNetWorking error %@===%@",error.localizedDescription,error.localizedRecoverySuggestion);
        }else{
            
            
            block(nil,obj);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"FMNetWorking fail %@===%@",error.localizedDescription,error.localizedRecoverySuggestion);
        if(hud)
        {
            [hud hideAnimated:YES afterDelay:0.2];
        }
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        failblock(error.localizedDescription);
    }];
}
-(void)FMAFNetWorkingPOS11TwithUrlString:(ServiceType)type
                          WithParameters:(id)IDparameters
                         WithHUDshowText:(NSString *)text
                                withView:(UIView*)currentView
                          withCompletion:(void(^)(NSString * returnCode,id obj))block withfail:(void(^)(NSString * errorMsg))failblock{
    __weak typeof(self) weakSelf = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *AccessToken=[defaults objectForKey:@"AccessToken"];
    NSString *UserToken=[defaults objectForKey:@"UserToken"];
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    MBProgressHUD *hud = nil;
    
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    NSString *service = [weakSelf getServiceUrl:type];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",XICI_TCAPI_BASE_URL,service];
    if (![text isEqualToString:@"NOHUD"])
    {
        hud = [MBProgressHUD showHUDAddedTo:currentView?:frontWindow animated:YES];
        [hud setOffset:CGPointMake(0, -HEIGHT_TOP_MARGIN)];
        if (text.length != 0)
        {
            hud.label.text = text;
            hud.mode = MBProgressHUDModeText;
        }
        
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //允许非权威机构颁发的证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    //使用cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",AccessToken] forHTTPHeaderField:@"AccessToken"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",UserToken] forHTTPHeaderField:@"UserToken"];
    //也不验证域名一致性
    manager.securityPolicy.validatesDomainName = NO;
    //关闭缓存避免干扰测试
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = HTTP_TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:url parameters:IDparameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(hud)
        {
            [hud hideAnimated:YES afterDelay:0.2];
        }
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"FMNetWorking error %@===%@",error.localizedDescription,error.localizedRecoverySuggestion);
        }else{
            
            
            block(nil,obj);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"FMNetWorking fail %@===%@",error.localizedDescription,error.localizedRecoverySuggestion);
        if(hud)
        {
            [hud hideAnimated:YES afterDelay:0.2];
        }
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        failblock(error.localizedDescription);
    }];
}

-(void)FMAFNetWorkingPOS21TwithUrlString:(ServiceType)type
                          WithParameters:(id)IDparameters
                         WithHUDshowText:(NSString *)text
                                withView:(UIView*)currentView
                          withCompletion:(void(^)(NSString * returnCode,id obj))block withfail:(void(^)(NSString * errorMsg))failblock{
    __weak typeof(self) weakSelf = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *AccessToken=[defaults objectForKey:@"AccessToken"];
    
    if (AccessToken.length<1) {
        AccessToken=@"12123456789878765453423456789876";
    }
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    NSString *service = [weakSelf getServiceUrl:type];
    NSString *url = [NSString stringWithFormat:@"%@%@",XICI_TCAPI_BASE_URL,service];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //允许非权威机构颁发的证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    //使用cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",AccessToken] forHTTPHeaderField:@"AccessToken"];
    //也不验证域名一致性
    manager.securityPolicy.validatesDomainName = NO;
    //关闭缓存避免干扰测试
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = HTTP_TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:url parameters:IDparameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"FMNetWorking error %@===%@",error.localizedDescription,error.localizedRecoverySuggestion);
        }else{
            
            
            block(nil,obj);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"FMNetWorking fail %@===%@",error.localizedDescription,error.localizedRecoverySuggestion);
       
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        failblock(error.localizedDescription);
    }];
}
@end
