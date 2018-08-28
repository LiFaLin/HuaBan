//
//  YThreeCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/27.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "YThreeCell.h"

@implementation YThreeCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kheigh(211));
        [self.contentView addSubview:_bgImage];
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(167), 0, kWidth(133), kheigh(178));
        _addButton.backgroundColor=UIColorFromHex(0xcfe6de);
        [self.contentView addSubview:_addButton];
        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), 0, kWidth(133), kheigh(65));
        [self.contentView addSubview:_editButton];
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, 2, kWidth(133), kheigh(65))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
        [_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
       
        _add1Button=[UIButton buttonWithType:UIButtonTypeCustom];
        _add1Button.frame=CGRectMake(kWidth(20), kheigh(80), kWidth(133), kWidth(100));
        _add1Button.backgroundColor=UIColorFromHex(0xcfe6de);
        [self.contentView addSubview:_add1Button];
        [FCAppInfo shareManager].bili32=133.00/100.00;
        
        _center1Img=[[UIImageView alloc]init];
        _center1Img.image=[UIImage imageNamed:@"中间"];
        _center1Img.frame=CGRectMake(_add1Button.bounds.size.width/2.0-15, _add1Button.bounds.size.height/2.0-15, 30, 30);
        [_add1Button addSubview:_center1Img];
    }
    return self;
}
@end
