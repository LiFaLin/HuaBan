//
//  BaseVC.h
//  Fencheng
//
//  Created by lifalin on 2018/5/29.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBAppMacro.h"
@interface BaseVC : UIViewController
typedef NS_ENUM(NSInteger, TCReturnType) {
    TCPopType,        //default is popviewcontroller
    TCDismissType,    //dismisssviewcontroller
    TCCustomType,     //user custom viewcontroller
};

typedef void(^ReturnBlock)(void);
@property (nonatomic) enum TCReturnType returnType;
@property (nonatomic, copy)   ReturnBlock returnblock;
@property (nonatomic, strong) NSString  *currentCityCode;
@property (nonatomic, strong) NSString  *currentCityName;
@property (nonatomic, strong) UIImageView *lineImg;

- (void)resetNav;
- (void)showMessage:(NSString *)message;
-(void)showMessage1:(NSString *)message;
-(void)confinLeftItemWithImg:(UIImage*)barItemImg withBackStr:(NSString*)backStr;
-(void)confinRightItemWithImg:(UIImage*)barItemImg;
-(void)confinRightItemWithImg:(UIImage*)barItemImg withImage:(UIImage*)image;
-(void)confinLeftItemWithImg:(UIImage*)barItemImg;
-(void)confinRightItemWithName:(NSString*)name;
-(void)confinRight1ItemWithName:(NSString*)name;
-(void)popLeftItemView;
-(void)popRightItemView;
-(void)popRight1ItemView;
-(void)setValueName:(id)value withKey:(NSString*)keyName;
-(id)objectValueWith:(NSString*)key;
-(NSString*) removeLastOneChar:(NSString*)origin;
-(NSString*)createSign:(NSDictionary*)dic;
-(void)getNewToken;
-(void)gotoLogin;
-(void)getSecond;
@end
