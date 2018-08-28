//
//  cengjiCollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/20.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "cengjiCollectionViewCell.h"

@implementation cengjiCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height-50)];
        [self.contentView addSubview:_bgImage];
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.frame=CGRectMake(0, 0, self.bounds.size.width-100, 20);
        _nameLabel.font=[UIFont systemFontOfSize:17];
        [self.contentView addSubview:_nameLabel];
        
        
        _dayLabel=[[UILabel alloc]init];
        _dayLabel.frame=CGRectMake(0, 30, self.bounds.size.width-100, 10);
        _dayLabel.font=[UIFont systemFontOfSize:11];
        _dayLabel.textColor=UIColorFromHex(0xb1b1b1);
        [self.contentView addSubview:_dayLabel];
        
        _EditImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-17, 10, 17, 5)];
        _EditImg.image=[UIImage imageNamed:@"morelfl"];
        [self.contentView addSubview:_EditImg];
        
        _nameButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        _nameButton.backgroundColor=[UIColor redColor];
        _nameButton.frame=CGRectMake(self.bounds.size.width-30, 0, 30, 30);
        [self.contentView addSubview:_nameButton];
        
        _likeLab=[[UILabel alloc]init];
        _likeLab.frame=CGRectMake(self.bounds.size.width-65,30, 30, 10);
        _likeLab.textAlignment=NSTextAlignmentLeft;
        _likeLab.font=[UIFont systemFontOfSize:10];
       
        [self.contentView addSubview:_likeLab];
        _likeImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-85, 30, 15, 10)];
        _likeImg.image=[UIImage imageNamed:@"zan"];
        [self.contentView addSubview:_likeImg];
        
        
        _lookLab=[[UILabel alloc]init];
        _lookLab.frame=CGRectMake(self.bounds.size.width-110, 30, 30, 10);
        _lookLab.textAlignment=NSTextAlignmentLeft;
        _lookLab.font=[UIFont systemFontOfSize:10];
    
        [self.contentView addSubview:_lookLab];
        _lookImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-130, 30, 17, 10)];
        _lookImg.image=[UIImage imageNamed:@"liulan"];
        [self.contentView addSubview:_lookImg];
        
        _commentLab=[[UILabel alloc]init];
        _commentLab.frame=CGRectMake(self.bounds.size.width-20, 30, 30, 10);
        _commentLab.textAlignment=NSTextAlignmentLeft;
        _commentLab.font=[UIFont systemFontOfSize:10];
        
        [self.contentView addSubview:_commentLab];
        _commentImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, 29, 14, 12)];
        _commentImg.image=[UIImage imageNamed:@"comment"];
        [self.contentView addSubview:_commentImg];

    }
    return self;
}
@end
