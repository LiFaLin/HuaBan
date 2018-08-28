//
//  ChooseBCollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/5/31.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ChooseBCollectionViewCell.h"

@implementation ChooseBCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-20)];
        [self.contentView addSubview:_bgImage];
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.frame=CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20);
        _nameLabel.font=[UIFont systemFontOfSize:10];
        [self.contentView addSubview:_nameLabel];
        
    }
    return self;
}
@end
