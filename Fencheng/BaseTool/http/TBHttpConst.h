//
//  HttpConst.h
//  XiCiNewApp
//
//  Created by GaoLin on 15/4/24.
//  Copyright (c) 2015年 www.xici.net  All rights reserved.
//

#import "FCAppInfo.h"
#ifndef XiCiNewApp_HttpConst_h
#define XiCiNewApp_HttpConst_h

//接口类型枚举
typedef enum {
    getRegistPageData = 1,
    sendRegistSecCode,
    register1,
    login,
    getUserInfo,
    updateUserNickname,
    updateUserSex,
    updateUserBirthday,
    getNewToken,
    updateUserEmail,
    getOssStsToken,
    updateUserPhoto,
    sendChangePhoneNumberSecCode,
    checkChangePhoneNumberSecCode,
    sendSetPhoneNumberSecCode,
    updateUserPhoneNumber,
    thirdPartyLogin,
    setUserPhoneNumberUserPassword,
    sendSetPhoneNumberUserPasswordSecCode,
    sendForgetUserPasswordSecCode,
    resetUserPasswordBySecCode,
    logout,
    openApp,
    recordUserUsageTime,
    getTemplateList,
    getTemplateBackgroundImageList,
    saveScrapbook,
    getMyScrapbookList,
    deleteScrapbook,
    getScrapbookDetailByScrapbookId,
    updateScrapbook,
    updateScrapbookName,
    
    sendFirstSetPhoneNumberSecCode,
    checkFirstSetPhoneNumberSecCode,
    setFirstUserPassword,
    bindingAccount,
    changeScrapbookLike,
    changeCommentLike,
    changeCommentStatus,
    addScrapbookComment
    
    
    
}ServiceType;

//服务器地址宏定义
//#define XICI_TCAPI_BASE_URL               @"http://192.168.1.66:8080/FC_DSI/"//线下内网数据接口
//#define XICI_TCAPI_BASE_URL               @"http://221.178.153.117:9083/FC_DSI/"//线下外网

#define XICI_TCAPI_BASE_URL               @"https://www.fenchengtech.com/FC_DSI/"//外网数据接口


// #define XICI_TCAPI_BASE_URL                @"http://221.178.153.117:9083/FC_DSI/"

//接口地址
#define SERVICE_URL_openApp        @"user/openApp"//打开APP时发送
#define SERVICE_URL_recordUserUsageTime       @"user/recordUserUsageTime"//记录在线次数
#define SERVICE_URL_SendRegistSecCode        @"login/sendRegistSecCode"//注册验证码
#define SERVICE_URL_REGIST                   @"login/register"//注册
#define SERVICE_URL_Login                    @"login/login"//登录
#define SERVICE_URL_logout                    @"login/logout"//退出登录
#define SERVICE_URL_getUserInfo              @"user/getUserInfo"//获取个人信息
#define SERVICE_URL_updateUserNickname       @"user/updateUserNickname"//更新昵称
#define SERVICE_URL_updateUserSex            @"user/updateUserSex"//更新性别
#define SERVICE_URL_updateUserBirthday       @"user/updateUserBirthday"//更新生日
#define SERVICE_URL_updateUserEmail          @"user/updateUserEmail"//更新email
#define SERVICE_URL_getNewToken              @"user/getNewToken"//更新AccessToken
#define SERVICE_URL_getOssStsToken           @"user/getOssStsToken"//获取上传图片的token
#define SERVICE_URL_updateUserPhoto          @"user/updateUserPhoto"//上传图片
#define SERVICE_URL_sendChangePhoneNumberSecCode          @"user/sendChangePhoneNumberSecCode"//发送短信给老手机号
#define SERVICE_URL_checkChangePhoneNumberSecCode          @"user/checkChangePhoneNumberSecCode"//检查老手机号的验证码是否错误
#define SERVICE_URL_sendSetPhoneNumberSecCode            @"user/sendSetPhoneNumberSecCode"//发送短信给新手机号
#define SERVICE_URL_updateUserPhoneNumber          @"user/updateUserPhoneNumber"//更改手机号
#define SERVICE_URL_thirdPartyLogin          @"login/thirdPartyLogin"//第三方登录返回给服务器
#define SERVICE_URL_setUserPhoneNumberUserPassword          @"user/setUserPhoneNumberUserPassword"//第三方设置用户账号和密码
#define SERVICE_URL_sendSetPhoneNumberUserPasswordSecCode          @"user/sendSetPhoneNumberUserPasswordSecCode"//第三方设置用户账号和密码时发送验证码
#define SERVICE_URL_sendForgetUserPasswordSecCode          @"login/sendForgetUserPasswordSecCode"//忘记密码发送验证码
#define SERVICE_URL_resetUserPasswordBySecCode          @"login/resetUserPasswordBySecCode"//忘记密码修改密码
#define SERVICE_URL_getTemplateList          @"scrapbook/getTemplateList"//获取画布列表
#define SERVICE_URL_getTemplateBackgroundImageList          @"scrapbook/getTemplateBackgroundImageList"//获取画布模块背景图
#define SERVICE_URL_saveScrapbook          @"scrapbook/saveScrapbook"//上传具体的数据
#define SERVICE_URL_getMyScrapbookList          @"scrapbook/getMyScrapbookList"//获取呈记列表
#define SERVICE_URL_deleteScrapbook          @"scrapbook/deleteScrapbook"//获取删除某一个呈记
#define SERVICE_URL_getScrapbookDetailByScrapbookId          @"scrapbook/getScrapbookDetailByScrapbookId"//获取某一个呈记具体详情
#define SERVICE_URL_updateScrapbook         @"scrapbook/updateScrapbook"//更新某一个呈记具体详情
#define SERVICE_URL_updateScrapbookName         @"scrapbook/updateScrapbookName"//更新某一个呈记名称

#define SERVICE_URL_sendFirstSetPhoneNumberSecCode         @"user/sendFirstSetPhoneNumberSecCode"//发送首次设置手机号验证码，添加平台判断
#define SERVICE_URL_checkFirstSetPhoneNumberSecCode        @"user/checkFirstSetPhoneNumberSecCode"//验证首次设置手机号验证码，并判断手机号是否需要账号融合，IsBinding属性

#define SERVICE_URL_setFirstUserPassword         @"user/setFirstUserPassword"//当账号不需要融合时，设置用户密码
#define SERVICE_URL_bindingAccount         @"user/bindingAccount"//当账号需要融合时，

#define SERVICE_URL_addScrapbookComment         @"scrapbook/addScrapbookComment"

#define SERVICE_URL_changeScrapbookLike         @"scrapbook/changeScrapbookLike"

#define SERVICE_URL_changeCommentLike         @"scrapbook/changeCommentLike"

#define SERVICE_URL_changeCommentStatus         @"scrapbook/changeCommentStatus"
//接口参数枚举定义
#define FEED_TYPE_LINK                   @"link"
#define FEED_TYPE_TEXT                   @"text"
#define FEED_TYPE_IMAGE                  @"image"

//HTTP参数定义
#define HTTP_TIMEOUT                     20  //http timeOut

//HTTP Header
#define HTTP_HEADER_VER              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define HTTP_HEADER_OS               [NSString stringWithFormat:@"iOS%@",[[UIDevice currentDevice] systemVersion]]
#define HTTP_HEADER_DEV              [AppInfo sharedMangaer].devName
#define HTTP_HEADER_XTOKEN           [AppInfo sharedMangaer].xiciToken
#define HTTP_HEADER_ACCEPT           @"application/x.1city.v1+json"

//HTTP OK RANGE
#define HTTP_RESPONES_OK             200
#define HTTP_RESPONES_ERROR          300


#endif
