//
//  YOneCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/27.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "YOneCell.h"

@implementation YOneCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {

        self.backgroundColor=[UIColor clearColor];
        
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kheigh(80));
        [self.contentView addSubview:_bgImage];
        
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), 0, self.bounds.size.width-2*kWidth(20), kheigh(49));
        [self.contentView addSubview:_editButton];
        
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width-2*kWidth(20), kheigh(49))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
[_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        //        [_bottomLabel sizeToFit];
        [_editButton addSubview:_bottomLabel];
        
        
    }
    return self;
}
@end
