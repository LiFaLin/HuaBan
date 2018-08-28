//
//  AppDelegate.h
//  Fencheng
//
//  Created by lifalin on 2018/5/28.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

