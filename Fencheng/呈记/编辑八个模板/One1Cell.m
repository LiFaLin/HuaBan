//
//  One1Cell.m
//  Fencheng
//
//  Created by lifalin on 2018/6/20.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "One1Cell.h"

@implementation One1Cell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kheigh(80));
        
        [self.contentView addSubview:_bgImage];
        
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame=CGRectMake(2, 0, kWidth(20), kWidth(20));
        _leftButton.layer.cornerRadius=13;
        _leftButton.clipsToBounds=YES;
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftButton];
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), 0, self.bounds.size.width-2*kWidth(20), kheigh(49));
        [self.contentView addSubview:_editButton];
        
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, kWidth(1), self.bounds.size.width-2*kWidth(20), kheigh(49))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
        //        _bottomLabel.adjustsFontSizeToFitWidth=YES;
        //        [_bottomLabel sizeToFit];
        [_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
        
        
        
    }
    return self;
}
-(void)setLFL
{
    
    [self.border removeFromSuperlayer];
    _border = [CAShapeLayer layer];
    //虚线的颜色
    _border.strokeColor = UIColorFromHex(0xabced6).CGColor;
    //填充的颜色
    _border.fillColor = [UIColor clearColor].CGColor;
    //设置路径
    _border.path = [UIBezierPath bezierPathWithRect:self.bottomLabel.bounds].CGPath;
    _border.frame = self.bottomLabel.bounds;
    //虚线的宽度
    _border.lineWidth = 1.f;
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    _border.lineDashPattern = @[@4, @2];
    
    [self.bottomLabel.layer addSublayer:_border];
}
@end
