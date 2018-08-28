//
//  NSString+Utilities.h
//  XiCiNewApp
//
//  Created by GaoLin on 15/10/27.
//  Copyright © 2015年 www.xici.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
typedef NS_ENUM(NSInteger, GIFSize) { GIFSizeVeryLow = 2, GIFSizeLow = 3, GIFSizeMedium = 5, GIFSizeHigh = 7, GIFSizeOriginal = 10 };
//帧率15/s
static NSInteger const FTPNumber = 15;
static NSString  *gifName = @"test.gif";
@interface NSString (Utilities)

@property (nonatomic, strong) PHFetchResult *assets;

/**
 要获取的资源结果的筛选条件
 */
@property (nonatomic, strong) PHFetchOptions * fetchOptions;

/**
 获取图片的筛选类型
 */
@property (nonatomic, strong) PHVideoRequestOptions *imageOptions;

@property (nonatomic, strong) NSString *gifPath;

- (void)creatVdeoUrl:(NSString*)prefix;
//获取字符串大小
-(CGSize)boundingRectWithSize:(UIFont *)font constrainedToSize:(CGSize)size;
+ (BOOL)checkPassword:(NSString *) password;
-(NSString*)ckeckEmailStyle;
//去除首尾空格以及换行符号
- (NSString *)trimString;
//去除字符串中的空格
- (NSString *)removeString;

//判断字符串是否为空
-(BOOL)isEmptyString;

//判断字符串是否为邮箱格式
- (BOOL)checkEmail;

//判断字符串是否为手机号
-(BOOL)checkPhoneNo;
//手机号码中间用****代替
-(NSString*)replacePhone;

//将字符串转成MD5
- (NSString *)MD5Value;

//转换成万
-(NSString *)MillionValue;

- (NSString *) sha1;

//字符串长度计算
-(NSUInteger)unicodeLengthOfString;

- (NSMutableArray *)getRangeStr:(NSString *)text;

- (NSString *)stringFromHexString:(NSString *)hexString;
+(NSString *)ret32bitString;
+(NSString *)parseMonthInt:(NSInteger)month;


//密码校验
+ (NSString*)checkPasswordStrength:(NSString *)passwordStr;

+(NSString*)createUuid; //自动生成32位字符串

+ (NSString*)deviceModelName;//获取设备具体信息

+ (NSString *)returndate:(int)num;//秒数转时间
+ (NSString *)converStrToDate:(NSString*)dateStr;
+ (NSString *)converStrToDate1:(NSString*)dateStr;
- (void)createGIFfromURL:(NSURL*)videoURL loopCount:(int)loopCount delayTime:(CGFloat )time gifImagePath:(NSString *)imagePath;
- (void)methodSync:(NSString*)string ;
-(void)imagegeneratorWith:(AVAssetImageGenerator *)imagegenerator with:(NSMutableArray*)timeArray with:(NSMutableArray*)totalImageArray with:(NSString*)prefix :(void(^)(NSInteger result))callBack;
@end
