//
//  UIColor+Trasform.m
//  Fencheng
//
//  Created by lifalin on 2018/7/19.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "UIColor+Trasform.h"

@implementation UIColor (Trasform)
+ (UIColor *)transformat:(NSString *)colorString {
    
    //去掉十六进制的#例如（#FFFFFF）
    
    NSString *newColorString = [colorString substringFromIndex:1];
    
    NSRange r1 = {0,2};
    
    NSRange r2 = {2,2};
    
    NSRange r3 = {4,2};
    
    NSString *redStr = [newColorString substringWithRange:r1];
    
    NSString *greenStr = [newColorString substringWithRange:r2];
    
    NSString *blueStr = [newColorString substringWithRange:r3];
    
    ColorBlock([redStr substringToIndex:1]);
    
    int red = [ColorBlock([redStr substringToIndex:1]) intValue] * 16 + [ColorBlock([redStr substringFromIndex:1]) intValue];
    
    int green = [ColorBlock([greenStr substringToIndex:1]) intValue] * 16 + [ColorBlock([greenStr substringFromIndex:1]) intValue];
    
    int blue = [ColorBlock([blueStr substringToIndex:1]) intValue] * 16 + [ColorBlock([blueStr substringFromIndex:1]) intValue];
    
    float r = red / 255.0;
    
    float g = green / 255.0;
    
    float b = blue / 255.0;
    
    UIColor *c = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
    return c;
    
}

NSString * (^ColorBlock)(NSString *) = ^(NSString *str) {
    
    if([str isEqualToString:@"A"]){
        
        str = @"10";
        
    }else if ([str isEqualToString:@"B"]){
        
        str = @"11";
        
    }else if ([str isEqualToString:@"C"]){
        
        str = @"12";
        
    }
    
    else if ([str isEqualToString:@"D"]){
        
        str = @"13";
        
    }
    
    else if ([str isEqualToString:@"E"]){
        
        str = @"14";
        
    }else if ([str isEqualToString:@"F"]){
        
        str = @"15";
        
    }
    
    return str;
    
};
@end
