//
//  LFLAppfo.m
//  Fencheng
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "LFLAppfo.h"

@implementation LFLAppfo
+(LFLAppfo*)shareManage{
    static LFLAppfo * info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info=[[self alloc]init];
    });
    return info;
}

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
