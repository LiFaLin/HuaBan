//
//  HttpClient.h
//  XiCiNewApp
//
//  Created by GaoLin on 15/4/24.
//  Copyright (c) 2015年 www.xici.net  All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "TBHttpConst.h"

@interface TBHttpClient : NSObject
@property (nonatomic, readonly)NSDictionary  *requestParams;
+(TBHttpClient *)shareManager;
/// 请求失败的Block
typedef void(^TBHttpClientFailed)(NSError *error);
/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^TBHttpClientProgress)(NSProgress *progress);

- (void)get:(ServiceType)type param:(id)p success:(void (^)(id responseObject))success failure:(void(^)(id responseObject))failure;
//- (void)post:(ServiceType)type param:(id)p success:(void (^)(id responseObject))success failure:(void(^)(id responseObject))failure;
- (void)del:(ServiceType)type param:(id)p success:(void (^)(id responseObject))success failure:(void(^)(id responseObject))failure;
- (void)put:(ServiceType)type param:(id)p success:(void (^)(id responseObject))success failure:(void(^)(id responseObject))failure;
-(void)FMAFNetWorkingPOSTwithUrlString:(ServiceType)type
                        WithParameters:(id)IDparameters
                       WithHUDshowText:(NSString *)text
                              withView:(UIView*)currentView
                        withCompletion:(void(^)(NSString * returnCode,id obj))block withfail:(void(^)(NSString * errorMsg))failblock;
-(void)FMAFNetWorkingPOS11TwithUrlString:(ServiceType)type
                        WithParameters:(id)IDparameters
                       WithHUDshowText:(NSString *)text
                              withView:(UIView*)currentView
                        withCompletion:(void(^)(NSString * returnCode,id obj))block withfail:(void(^)(NSString * errorMsg))failblock;
-(void)FMAFNetWorkingPOS21TwithUrlString:(ServiceType)type
                          WithParameters:(id)IDparameters
                         WithHUDshowText:(NSString *)text
                                withView:(UIView*)currentView
                          withCompletion:(void(^)(NSString * returnCode,id obj))block withfail:(void(^)(NSString * errorMsg))failblock;
@end
