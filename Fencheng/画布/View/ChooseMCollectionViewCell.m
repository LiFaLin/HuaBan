//
//  ChooseMCollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/5/28.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ChooseMCollectionViewCell.h"

@implementation ChooseMCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgImage = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:_bgImage];
    }
    return self;
}
@end
