//
//  YSixCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/27.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "YSixCell.h"

@implementation YSixCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kWidth(144));
        [self.contentView addSubview:_bgImage];
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(20), kWidth(55), kWidth(69), kWidth(69));
        _addButton.backgroundColor=UIColorFromHex(0xcfe6de);
        [self.contentView addSubview:_addButton];

        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        _add1Button=[UIButton buttonWithType:UIButtonTypeCustom];
        _add1Button.frame=CGRectMake(kWidth(95), kWidth(42), kWidth(130), kWidth(88));
        _add1Button.backgroundColor=UIColorFromHex(0xcfe6de);
        [self.contentView addSubview:_add1Button];

        _center1Img=[[UIImageView alloc]init];
        _center1Img.image=[UIImage imageNamed:@"中间"];
        _center1Img.frame=CGRectMake(_add1Button.bounds.size.width/2.0-15, _add1Button.bounds.size.height/2.0-15, 30, 30);
        [_add1Button addSubview:_center1Img];
        
        
        _add2Button=[UIButton buttonWithType:UIButtonTypeCustom];
        _add2Button.frame=CGRectMake(kWidth(231), kWidth(55), kWidth(69), kWidth(69));
        _add2Button.backgroundColor=UIColorFromHex(0xcfe6de);
        [self.contentView addSubview:_add2Button];
        
        _center2Img=[[UIImageView alloc]init];
        _center2Img.image=[UIImage imageNamed:@"中间"];
        _center2Img.frame=CGRectMake(_add2Button.bounds.size.width/2.0-15, _add2Button.bounds.size.height/2.0-15, 30, 30);
        [_add2Button addSubview:_center2Img];
        
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), kWidth(165),kWidth(280), kWidth(33));
        [self.contentView addSubview:_editButton];
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, 0, kWidth(280), kWidth(33))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
[_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
       
    }
    return self;
}
@end
