//
//  YNineCell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "YNineCell.h"

@implementation YNineCell
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
        
        _addButton.backgroundColor=UIColorFromHex(0xcfe6de);
        [self.contentView addSubview:_addButton];
        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        
       
        
    }
    return self;
}
@end
