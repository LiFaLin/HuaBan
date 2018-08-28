//
//  Comment2CollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/20.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "Comment2CollectionViewCell.h"

@implementation Comment2CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
         self.backgroundColor=[UIColor whiteColor];
        
        _horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(LWidth(80), 0, self.bounds.size.width-kWidth(70), 1)];
        _horizontalLine.backgroundColor = UIColorFromHex(0xeeeeee);
        [self.contentView addSubview:_horizontalLine];
        
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.frame=CGRectMake(LWidth(80), 10, 100, 20);
        _nameLabel.font=[UIFont systemFontOfSize:15];
        
        _nameLabel.textColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_nameLabel];
        
        _commentLabel=[[lflLabel alloc]init];
        _commentLabel.frame=CGRectMake(LWidth(80), 30,self.bounds.size.width-kWidth(165), 55);
        _commentLabel.font=[UIFont systemFontOfSize:15];
       
        _commentLabel.numberOfLines=0;
        [self.contentView addSubview:_commentLabel];
        
        _dayLabel=[[UILabel alloc]init];
        _dayLabel.frame=CGRectMake(self.bounds.size.width-150, 10,130, 20);
        _dayLabel.font=[UIFont systemFontOfSize:13];
        
        _dayLabel.textColor=[UIColor lightGrayColor];
        _dayLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_dayLabel];
        
        _likeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame=CGRectMake(self.bounds.size.width-LWidth(90), LWidth(58),LWidth(20), LWidth(17));
        [self.contentView addSubview:_likeButton];
        
        _likeLabel=[[UILabel alloc]init];
        _likeLabel.frame=CGRectMake(self.bounds.size.width-LWidth(65), LWidth(58),LWidth(30), LWidth(17));
        _likeLabel.font=[UIFont systemFontOfSize:15];
        _likeLabel.textAlignment=NSTextAlignmentLeft;
        _likeLabel.textColor=UIColorFromHex(0x808080);
        [self.contentView addSubview:_likeLabel];
        
        _deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"删除lfl"] forState:UIControlStateNormal];
        _deleteButton.frame=CGRectMake(self.bounds.size.width-LWidth(30), LWidth(55), LWidth(20), LWidth(20));
        [self.contentView addSubview:_deleteButton];
        
        
    }
    return self;
}
@end
