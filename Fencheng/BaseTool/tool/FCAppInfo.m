//
//  FCAppInfo.m
//  Fencheng
//
//  Created by lifalin on 2018/5/29.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "FCAppInfo.h"


@implementation FCAppInfo
+(FCAppInfo*)shareManager
{
    static FCAppInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[self alloc] init];
    });
    return info;
}

@end
