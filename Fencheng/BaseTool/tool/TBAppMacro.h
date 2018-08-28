//
//  AppMacro.h
//  XiCiNewApp
//
//  Created by GaoLin on 15/4/23.
//  Copyright (c) 2015年 www.xici.net  All rights reserved.
//

#ifndef XiCiNewApp_AppMacro_h
#define XiCiNewApp_AppMacro_h

#ifdef DEBUG
#define NSLog(xx, ...)  NSLog(@"%s(%d): \n" xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog                     //关闭log
#endif

#pragma mark - 应用信息
//=====================应用信息=====================
//应用提示语
#define APP_GuideView1_Title    @"title"
#define APP_GuideView1_Content  @"Rich legal resources at your fingertips"
#define APP_GuideView2_Title    @""
#define APP_GuideView2_Content  @"Bring everything in your pocket"
#define APP_GuideView3_Title    @"title"
#define APP_GuideView3_Content  @"No more worry about leaving away from your computer"
#define APP_GuideView4_Title    @"title"
#define APP_GuideView4_Content  @"content"
//=====================单例==================
// @interface
#define singleton_interface(className) \
+ (className *)shared;
#define CREATE_SHARED_MANAGER(CLASS_NAME) \
+ (instancetype)sharedManager { \
static CLASS_NAME *_instance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[CLASS_NAME alloc] init]; \
}); \
\
return _instance; \
}

#define CREATE_SHARED_INSTANCE(CLASS_NAME) \
+ (instancetype)sharedInstance { \
static CLASS_NAME *_instance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[CLASS_NAME alloc] init]; \
}); \
\
return _instance; \
}

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}
//========================end==================



//应用AppDelegate
#define _APPDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
//设备屏幕宽度
#define APP_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width

//设备屏幕高度
#define APP_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

//应用名称
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

//应用软件版本
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//应用软件build版本 一般作为开发内部使用
#define APP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//应用ITUNES_ID
#define APP_ITUNES_ID  @"985035633"

//应用下载地址
#define APP_ITUNES_URL  [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",APP_ITUNES_ID]

//应用在itunes的信息地址,用于版本检测
#define APP_ITUNES_LOOKUP_URL     [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APP_ITUNES_ID]

//数据库名称
#define APP_DATABASE_NAME @"XiCiNewApp.sqlite"
//导航条颜色
#define NAV_BAR_TINT_COLOR       UIColorFromHex(0x122e56)
//工具栏颜色
#define TAB_BAR_TINT_COLOR       [UIColor colorWithRed:244/255.0 green:244/255.0 blue:246/255.0 alpha:1.0f]
//UIColor颜色RGB转换
#define UIColorFromRGB(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

#define UIColorFromRGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define lflbl()

#define WEAK_SELF __weak typeof(self) weakSelf = self

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#pragma mark - 设备信息
//=====================设备信息=====================
#define  Max_OffsetWidth  40
#define HalfF(x) ((x)/2.0f)

#define ScreenScale             UIScreen.mainScreen.scale
//设备屏幕宽度
#define APP_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
//设备屏幕高度
#define APP_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

#define HEIGHT_TAB_BAR         49
#define HEIGHT_BOTTOM_MARGIN   (APP_SCREEN_HEIGHT==812?34:0) // 因为只有iPhoneX的高度为812pt
#define HEIGHT_TOP_MARGIN      (APP_SCREEN_HEIGHT==812?88:64) // 因为只有iPhoneX的高度为812pt
#define HEIGHT_NAVBAR_MARGIN      (APP_SCREEN_HEIGHT==812?44:20) // 因为只有iPhoneX的高度为812pt
#define HEIGHT_NAVBARHeight_MARGIN      (APP_SCREEN_HEIGHT==812?24:0) // 因为只有iPhoneX的高度为812pt
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define ISiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define ISLittleScreen ((APP_SCREEN_WIDTH <= 320)? YES: NO)

#define ISLargeScreen ((APP_SCREEN_WIDTH >= 545)? YES: NO)

#define ISiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define ISiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//设备系统版本
#define APP_CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define UsePhotoKit             __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#define iphoneModel              [[UIDevice currentDevice] model]
#define A4Height    @"842"
#define A4Width     @"595"

#define kWidth(R) (R)*(APP_SCREEN_WIDTH)/320
#define LWidth(R) (R)*(APP_SCREEN_WIDTH)/375
#define kheigh(R) (R)*(APP_SCREEN_WIDTH)/320
#define lflnum (APP_SCREEN_WIDTH)/320
#define kHeight(R) (iPhone4?((R)*(kScreenHeight)/480):((R)*(kScreenHeight)/667))
#define kFONT16                  [UIFont fontWithName:@"Calibri" size:16.0f]

#define kFONT17                  [UIFont fontWithName:@"Calibri" size:17.0f]

//UIFont字体
#define FONT_SYS_SIZE(X) [UIFont fontWithName:@"Calibri" size:X]
#define FONT_BOLDSYS_SIZE(X) [UIFont boldSystemFontOfSize:X]


#pragma mark - 系统目录
//=====================系统目录=====================
//沙盒Documents目录
#define APP_DOC_DIR     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

//沙盒Library目录
#define APP_LIB_DIR     [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

//沙盒Library下的cache目录
#define APP_LIB_CACHE_DIR  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

//沙盒tmp下的cache目录,这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息
#define APP_TMP_DIR        NSTemporaryDirectory()

#define SAFE_SEND_MESSAGE(obj, msg) if ((obj) && [(obj) respondsToSelector:@selector(msg)])

#define HUTONG_DATA    @"HuTongData"

#define DOC_PLAIN @"Manual"


#define UICollectionJianGe 5

#define UIVCollectionJianGe 20

#define UICollectionGeShu 4

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kNavigationBarHeight (kDevice_Is_iPhoneX ? 88 : 64)
#define kTopMargin (kDevice_Is_iPhoneX ? 24 : 0)
#define kBottomMargin (kDevice_Is_iPhoneX ? 34 : 0)

#define iOS11_Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define iOS9_Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

#define iOS8_2Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.2f)
//#define UICollectionWidth ((APP_SCREEN_WIDTH - UICollectionJianGe*(UICollectionGeShu+1)) / UICollectionGeShu)

//#define UICollectionWidth (APP_SCREEN_WIDTH-50)/4

#define UICollectionWidth (APP_SCREEN_WIDTH / 4 - 20)

#pragma mark - TCAPI


//正式环境
#define TCAPI_CLIENT_ID             @"b7a61eca-a94d-4d7d-abaf-d93074a19665"
#define TCAPI_CLIENT_SECRET         @"94be107ba2e4f8133fbe04b5ec9a252b240cfa56"
#define TCAPI_GRANT_TYPE            @"client_credentials"

static NSString* const UMS_Text = @"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";

static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";

static NSString* const UMS_WebLink = @"http://mobile.umeng.com/social";

static NSString *UMS_SHARE_TBL_CELL = @"UMS_SHARE_TBL_CELL";

#endif
