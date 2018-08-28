//
//  MyTableViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/8.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
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
        _rightImage.image=[UIImage imageNamed:@"huisejq"];
        
    }
    return _rightImage;
}
-(UIImageView *)rightImage1{
    
    if (_rightImage1 == nil) {
        _rightImage1 = [[UIImageView alloc] init];
        _rightImage1.image=[UIImage imageNamed:@"banben"];
        _rightImage1.hidden=YES;
        
    }
    return _rightImage1;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    if (self) {
        
      
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.rightImage];
        [self.contentView addSubview:self.rightImage1];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    __weak typeof(self)weakSelf = self;
    weakSelf.rightImage.frame=CGRectMake(self.bounds.size.width-20, 12, 8, 15);
    weakSelf.rightImage1.frame=CGRectMake(self.bounds.size.width-45, 12, 15, 15);
    weakSelf.nameLabel.frame=CGRectMake(20, 0, 100, 40);
    
}

@end
