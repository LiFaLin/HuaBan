//
//  CommentCollectionViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/18.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "CommentCollectionViewCell.h"

@implementation CommentCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        _lookLab=[[UILabel alloc]init];
        _lookLab.frame=CGRectMake(55, 22, 40, 16);
        _lookLab.font=[UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_lookLab];
        _lookImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 22, 28, 16)];
        _lookImg.image=[UIImage imageNamed:@"liulan"];
        [self.contentView addSubview:_lookImg];
        
        
        _likeLab=[[UILabel alloc]init];
        _likeLab.frame=CGRectMake(self.frame.size.width-LWidth(100),22, LWidth(30), 16);
        _likeLab.font=[UIFont systemFontOfSize:15];
        _likeLab.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_likeLab];
        _likeImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-LWidth(125), 22, LWidth(20), 17)];
//        _likeImg.image=[UIImage imageNamed:@"zan"];
        [self.contentView addSubview:_likeImg];
        
        _nameButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _nameButton.frame=CGRectMake(self.frame.size.width-LWidth(130), 22, 40, 17);
      
        [self.contentView addSubview:_nameButton];
        
        _commentLab=[[UILabel alloc]init];
        _commentLab.frame=CGRectMake(self.frame.size.width-LWidth(40), 22, LWidth(30), 16);
        _commentLab.textAlignment=NSTextAlignmentLeft;
        _commentLab.font=[UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_commentLab];
        _commentImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-LWidth(65), 22, LWidth(20), 17)];
        _commentImg.image=[UIImage imageNamed:@"comment"];
        [self.contentView addSubview:_commentImg];
        
        
        _name1Button=[UIButton buttonWithType:UIButtonTypeCustom];
        _name1Button.frame=CGRectMake(self.frame.size.width-LWidth(70), 22, 40, 17);
     
        [self.contentView addSubview:_name1Button];
        
        
    }
    return self;
}
@end
