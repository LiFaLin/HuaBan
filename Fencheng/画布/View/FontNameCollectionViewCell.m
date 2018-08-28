//
//  FontNameCollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/8.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "FontNameCollectionViewCell.h"

@implementation FontNameCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(0, 0, 100, 70);
        [self.contentView addSubview:_editButton];
        
        
    }
    return self;
}
@end
