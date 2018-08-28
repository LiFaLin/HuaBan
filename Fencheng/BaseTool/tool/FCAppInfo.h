//
//  FCAppInfo.h
//  Fencheng
//
//  Created by lifalin on 2018/5/29.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>//需要添加AVFoundation.framework
#import "TBHttpConst.h"
@interface FCAppInfo : NSObject
@property(nonatomic, strong)NSString *deviceToken;
@property(nonatomic, strong)NSString *IsC;
@property(nonatomic, strong)NSString *FromVC;
@property(nonatomic, readonly)ServiceType  currentType;
@property (nonatomic, readonly)NSDictionary  *CurrentParams;
@property(nonatomic, strong)NSArray * huabanArr;
@property(nonatomic, strong)NSDictionary * pDic;
@property(nonatomic, strong)NSDictionary * TDic;
@property(nonatomic, strong)NSString *backgroundImage;
@property(nonatomic, assign)int boxColor;
@property(nonatomic, assign)int gifCount;
@property(nonatomic, strong)NSMutableArray * draftArr;
@property(nonatomic, strong)NSMutableArray * draftNameArr;
@property(nonatomic, strong)NSString* MaxXian;
@property(nonatomic,assign)CGFloat bili;
@property(nonatomic,assign)CGFloat bili2;
@property(nonatomic,assign)CGFloat bili31;
@property(nonatomic,assign)CGFloat bili32;
@property(nonatomic,assign)CGFloat bili4;
@property(nonatomic,assign)CGFloat bili5;
@property(nonatomic,assign)CGFloat bili61;
@property(nonatomic,assign)CGFloat bili62;
@property(nonatomic,assign)CGFloat bili7;
@property(nonatomic,assign)CGFloat bili8;
@property(nonatomic,assign)CGFloat bili9;
@property(nonatomic,assign)CGFloat bili10;

@property(nonatomic, strong)NSDictionary *dic;
@property(nonatomic, strong)NSDictionary *dic1;
@property(nonatomic, strong)NSDictionary *dic2;
@property(nonatomic, strong)NSDictionary *dic3;
@property(nonatomic, strong)NSDictionary *dic4;
@property(nonatomic, strong)NSDictionary *dic5;
@property(nonatomic, strong)NSDictionary *dic6;
@property(nonatomic, strong)NSDictionary *dic7;
@property(nonatomic, strong)NSDictionary *dic8;
@property(nonatomic, strong)NSString *temID;
@property(nonatomic, strong)NSString *ScrapbookId;


//@property(nonatomic,assign)CGFloat imageW;
//@property(nonatomic,assign)CGFloat imageH;
@property(nonatomic, strong)NSString *isFrom;
@property(nonatomic, strong)NSString *isfromPhoto;
@property(nonatomic,assign)CGFloat UpdateShu;


@property(nonatomic, strong)NSString *changeHB;
@property(nonatomic, strong)NSString *lflTemID;
@property(nonatomic, strong)NSString *lflTemName;
@property(nonatomic, strong)NSString *back;
@property(nonatomic, strong)NSString *isHeader;
+(FCAppInfo *)shareManager;
@end
