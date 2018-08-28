//
//  HeaderTableViewCell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/6.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

-(UIImageView *)headerImage{
    
    if (_headerImage == nil) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.layer.cornerRadius=25;
        _headerImage.clipsToBounds=YES;
       
    }
    
    return _headerImage;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel=[[UILabel alloc]init];
       
        _nameLabel.font=[UIFont systemFontOfSize:15];
        _nameLabel.textColor=[UIColor blackColor];
       
    
    
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
        
         [self.contentView addSubview:self.headerImage];
         [self.contentView addSubview:self.nameLabel];
         [self.contentView addSubview:self.rightImage];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    __weak typeof(self)weakSelf = self;
    weakSelf.rightImage.frame=CGRectMake(self.bounds.size.width-20, 25, 8, 15);
    weakSelf.nameLabel.frame=CGRectMake(20, 0, 100, 70);
    weakSelf.headerImage.frame=CGRectMake(self.bounds.size.width-100, 10, 50, 50);
}

@end
