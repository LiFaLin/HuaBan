//
//  DThreeCell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/24.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "DThreeCell.h"

@implementation DThreeCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kheigh(211));
        [self.contentView addSubview:_bgImage];
        
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame=CGRectMake(2, 0, kWidth(20), kWidth(20));
        _leftButton.layer.cornerRadius=10;
        _leftButton.clipsToBounds=YES;
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_leftButton];
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(167), 0, kWidth(133), kheigh(180));
        _addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_addButton];
        [FCAppInfo shareManager].bili31=133.00/180.00;;
        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), 0, kWidth(133), kheigh(65));
        [self.contentView addSubview:_editButton];
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, kWidth(1), kWidth(133), kheigh(65))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
        [_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
        
        CAShapeLayer *border = [CAShapeLayer layer];
        //虚线的颜色
        border.strokeColor = UIColorFromHex(0xabced6).CGColor;
        //填充的颜色
        border.fillColor = [UIColor clearColor].CGColor;
        //设置路径
        border.path = [UIBezierPath bezierPathWithRect:self.bottomLabel.bounds].CGPath;
        border.frame = self.bottomLabel.bounds;
        //虚线的宽度
        border.lineWidth = 1.f;
        //设置线条的样式
        //    border.lineCap = @"square";
        //虚线的间隔
        border.lineDashPattern = @[@4, @2];
        [self.bottomLabel.layer addSublayer:border];
        
        
        _add1Button=[UIButton buttonWithType:UIButtonTypeCustom];
        _add1Button.frame=CGRectMake(kWidth(20), kheigh(80), kWidth(133), kWidth(100));
        _add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_add1Button];
        [FCAppInfo shareManager].bili32=133.00/100.00;
        
        _center1Img=[[UIImageView alloc]init];
        _center1Img.image=[UIImage imageNamed:@"中间"];
        _center1Img.frame=CGRectMake(_add1Button.bounds.size.width/2.0-15, _add1Button.bounds.size.height/2.0-15, 30, 30);
        [_add1Button addSubview:_center1Img];
        
    }
    return self;
}
@end
