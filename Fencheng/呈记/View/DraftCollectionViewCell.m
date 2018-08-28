//
//  DraftCollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/24.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "DraftCollectionViewCell.h"

@implementation DraftCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(LWidth(20), 50, self.bounds.size.width-LWidth(40), self.bounds.size.height-50)];
        [self.contentView addSubview:_bgImage];
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.frame=CGRectMake(LWidth(20), 0, self.bounds.size.width-100, 20);
        _nameLabel.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:_nameLabel];
        
        
        _dayLabel=[[UILabel alloc]init];
        _dayLabel.frame=CGRectMake(LWidth(20), 30, self.bounds.size.width-100, 10);
        _dayLabel.font=[UIFont systemFontOfSize:11];
        _dayLabel.textColor=UIColorFromHex(0xb1b1b1);
        [self.contentView addSubview:_dayLabel];
        
        _EditImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-37, 10, 17, 5)];
        _EditImg.image=[UIImage imageNamed:@"morelfl"];
        [self.contentView addSubview:_EditImg];
        
        _nameButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _nameButton.frame=CGRectMake(self.bounds.size.width-50, 0, 30, 30);
        [self.contentView addSubview:_nameButton];
        
        _gxButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _gxButton.frame=CGRectMake(LWidth(5),0, LWidth(20), LWidth(20));
        _gxButton.hidden=YES;
        [_gxButton setBackgroundImage:[UIImage imageNamed:@"lflwgx"] forState:UIControlStateNormal];
        [self.contentView addSubview:_gxButton];
    
        
    }
    return self;
}
@end
