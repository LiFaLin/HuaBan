//
//  OtherTableViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/6.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "OtherTableViewCell.h"

@implementation OtherTableViewCell
-(UILabel *)detailLabel{
    
    if (_detailLabel == nil) {
        _detailLabel=[[UILabel alloc]init];
//        _detailLabel.frame=
        _detailLabel.font=[UIFont systemFontOfSize:15];
        _detailLabel.textAlignment=NSTextAlignmentRight;
        _detailLabel.textColor=[UIColor lightGrayColor];
        
    }
    
    return _detailLabel;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel=[[UILabel alloc]init];
//        _nameLabel.frame=CGRectMake(20, 0, 100, 40);
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.textColor=[UIColor blackColor];
//        [self.contentView addSubview:_nameLabel];
        
        
        
    }
    return _nameLabel;
}
-(UIImageView *)rightImage{
    
    if (_rightImage == nil) {
        _rightImage = [[UIImageView alloc] init];
        _rightImage.image=[UIImage imageNamed:@"qianjin"];
        
    }
    return _rightImage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    if (self) {
        
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.rightImage];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    __weak typeof(self)weakSelf = self;
    weakSelf.rightImage.frame=CGRectMake(self.bounds.size.width-20, 12, 8, 15);
    weakSelf.nameLabel.frame=CGRectMake(20, 0, 100, 40);
    weakSelf.detailLabel.frame=CGRectMake(120, 0, self.bounds.size.width-150, 40);
}



@end
