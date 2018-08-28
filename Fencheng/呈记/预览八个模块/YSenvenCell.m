//
//  YSenvenCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/27.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "YSenvenCell.h"

@implementation YSenvenCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    
    self = [super initWithFrame:frame];
    if (self)
    {
//        self.backgroundColor=[UIColor whiteColor];
        
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kWidth(201));
        [self.contentView addSubview:_bgImage];
        
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(20), 0, kWidth(280),kWidth(140));
        _addButton.backgroundColor=UIColorFromHex(0xcfe6de);
        [self.contentView addSubview:_addButton];
        

        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), kWidth(155), kWidth(280), kWidth(15));
        [self.contentView addSubview:_editButton];
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, 0, kWidth(280), kWidth(15))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
[_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
        
        
    }
    return self;
}
@end
