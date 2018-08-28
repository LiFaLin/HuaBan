//
//  TwoCell.m
//  Fencheng
//
//  Created by lifalin on 2018/5/31.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "TwoCell.h"

@implementation TwoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgImage=[[UIImageView alloc]init];
//        _bgImage.backgroundColor=[UIColor redColor];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kheigh(217));
        [self.contentView addSubview:_bgImage];
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(20), 0, kWidth(280), kWidth(186));
        
        
        _addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor );
        [self.contentView addSubview:_addButton];
        
        [FCAppInfo shareManager].bili2=280.00/186.00;
        
    
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
