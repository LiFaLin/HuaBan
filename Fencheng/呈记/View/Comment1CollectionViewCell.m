//
//  Comment1CollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/18.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "Comment1CollectionViewCell.h"

@implementation Comment1CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
         self.backgroundColor=[UIColor whiteColor];
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(LWidth(10), LWidth(12), LWidth(33), LWidth(33))];
        _bgImage.clipsToBounds=YES;
        _bgImage.layer.cornerRadius=LWidth(16);
        [self.contentView addSubview:_bgImage];
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.frame=CGRectMake(LWidth(54), LWidth(13), 100, LWidth(20));
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.textColor=UIColorFromHex(0x808080);
        [self.contentView addSubview:_nameLabel];
        
        _commentLabel=[[lflLabel alloc]init];
        _commentLabel.frame=CGRectMake(LWidth(54), LWidth(43),self.bounds.size.width-LWidth(74), LWidth(40));
        _commentLabel.font=[UIFont systemFontOfSize:15];
        [_commentLabel setVerticalAlignment:VerticalAlignmentTop];
        _commentLabel.numberOfLines=0;
        [self.contentView addSubview:_commentLabel];
        
        _dayLabel=[[UILabel alloc]init];
        _dayLabel.frame=CGRectMake(self.bounds.size.width-LWidth(150), 20,LWidth(130), LWidth(10));
        _dayLabel.font=[UIFont systemFontOfSize:12];
        _dayLabel.textColor=UIColorFromHex(0x959595);
        _dayLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_dayLabel];
        
        _collectionButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _collectionButton.frame=CGRectMake(self.bounds.size.width-LWidth(100), LWidth(86.5), LWidth(20), LWidth(20));
        [self.contentView addSubview:_collectionButton];
        
        _likeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame=CGRectMake(self.bounds.size.width-LWidth(160), LWidth(88),LWidth(20), LWidth(17));
        [self.contentView addSubview:_likeButton];
        
        _likeLabel=[[UILabel alloc]init];
        _likeLabel.frame=CGRectMake(self.bounds.size.width-LWidth(130), LWidth(88),LWidth(30), LWidth(17));
        _likeLabel.font=[UIFont systemFontOfSize:15];
        _likeLabel.textAlignment=NSTextAlignmentLeft;
        _likeLabel.textColor=UIColorFromHex(0x808080);
        [self.contentView addSubview:_likeLabel];
        
        _commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"回复lfl"] forState:UIControlStateNormal];
        _commentButton.frame=CGRectMake(self.bounds.size.width-LWidth(65), LWidth(88), LWidth(20), LWidth(17));
        [self.contentView addSubview:_commentButton];
        
        
        _deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"删除lfl"] forState:UIControlStateNormal];
        _deleteButton.frame=CGRectMake(self.bounds.size.width-LWidth(30), LWidth(86.5), LWidth(20), LWidth(20));
        [self.contentView addSubview:_deleteButton];
        
        
        
    }
    return self;
}
@end
