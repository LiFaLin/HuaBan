//
//  ColorCollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@implementation ColorCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(0, 0, 35,35);
        _editButton.clipsToBounds=YES;
        _editButton.layer.cornerRadius=17;
        [self.contentView addSubview:_editButton];
        
//        _bgButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        _bgButton.frame=CGRectMake(0, 0, 37,37);
//        _bgButton.clipsToBounds=YES;
//        _bgButton.hidden=YES;
//        _bgButton.layer.cornerRadius=19;
//        [self.contentView addSubview:_bgButton];
        
        
    }
    return self;
}
@end
