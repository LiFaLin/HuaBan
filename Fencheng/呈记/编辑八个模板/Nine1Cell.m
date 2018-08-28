//
//  Nine1Cell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "Nine1Cell.h"

@implementation Nine1Cell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kWidth(326));
        [self.contentView addSubview:_bgImage];
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(50), 0, kWidth(220), kWidth(295));
        
        _addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_addButton];
        
        [FCAppInfo shareManager].bili9=220.00/295.00;
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame=CGRectMake(2, 0, kWidth(20), kWidth(20));
        _leftButton.layer.cornerRadius=13;
        _leftButton.clipsToBounds=YES;
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftButton];
        
    }
    return self;
}
@end
