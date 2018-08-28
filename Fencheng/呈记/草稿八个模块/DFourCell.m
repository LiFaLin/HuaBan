//
//  DFourCell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/24.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "DFourCell.h"

@implementation DFourCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, kheigh(46), self.bounds.size.width, kheigh(264)-kheigh(46));
        [self.contentView addSubview:_bgImage];
        
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame=CGRectMake(2, 0, kheigh(20), kheigh(20));
        _leftButton.layer.cornerRadius=13;
        _leftButton.clipsToBounds=YES;
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftButton];
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kheigh(20), 0, kheigh(280), kheigh(31));
        [self.contentView addSubview:_editButton];
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, kWidth(1), kheigh(280), kheigh(31))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
        [_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kheigh(20), kheigh(46), kheigh(280), kheigh(182));
        _addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_addButton];
        [FCAppInfo shareManager].bili4=280.00/182.00;
        
        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
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
