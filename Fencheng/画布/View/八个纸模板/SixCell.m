//
//  SixCell.m
//  Fencheng
//
//  Created by lifalin on 2018/5/31.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "SixCell.h"

@implementation SixCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
//        self.backgroundColor=[UIColor whiteColor];
        
        _bgImage=[[UIImageView alloc]init];
//        _bgImage.backgroundColor=[UIColor redColor];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kWidth(144));
        [self.contentView addSubview:_bgImage];
        
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame=CGRectMake(2, 0, kWidth(20), kWidth(20));
        _leftButton.layer.cornerRadius=13;
        _leftButton.clipsToBounds=YES;
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftButton];
        
        
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(20), kWidth(55), kWidth(69), kWidth(69));
        _addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_addButton];
        [FCAppInfo shareManager].bili61=1;
        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        _add1Button=[UIButton buttonWithType:UIButtonTypeCustom];
        _add1Button.frame=CGRectMake(kWidth(95), kWidth(42), kWidth(130), kWidth(88));
        _add1Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_add1Button];
        [FCAppInfo shareManager].bili62=130.00/88.00;
        _center1Img=[[UIImageView alloc]init];
        _center1Img.image=[UIImage imageNamed:@"中间"];
        _center1Img.frame=CGRectMake(_add1Button.bounds.size.width/2.0-15, _add1Button.bounds.size.height/2.0-15, 30, 30);
        [_add1Button addSubview:_center1Img];
        
        
        _add2Button=[UIButton buttonWithType:UIButtonTypeCustom];
        _add2Button.frame=CGRectMake(kWidth(231), kWidth(55), kWidth(69), kWidth(69));
        _add2Button.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_add2Button];
        
        _center2Img=[[UIImageView alloc]init];
        _center2Img.image=[UIImage imageNamed:@"中间"];
        _center2Img.frame=CGRectMake(_add2Button.bounds.size.width/2.0-15, _add2Button.bounds.size.height/2.0-15, 30, 30);
        [_add2Button addSubview:_center2Img];
        
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), kWidth(165),kWidth(280), kWidth(33));
        [self.contentView addSubview:_editButton];
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, kWidth(1), kWidth(280), kWidth(33))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
[_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
        
//        CAShapeLayer *border = [CAShapeLayer layer];
//        //虚线的颜色
//        border.strokeColor = UIColorFromHex(0xabced6).CGColor;
//        //填充的颜色
//        border.fillColor = [UIColor clearColor].CGColor;
//        //设置路径
//        border.path = [UIBezierPath bezierPathWithRect:self.bottomLabel.bounds].CGPath;
//        border.frame = self.bottomLabel.bounds;
//        //虚线的宽度
//        border.lineWidth = 1.f;
//        //设置线条的样式
//        //    border.lineCap = @"square";
//        //虚线的间隔
//        border.lineDashPattern = @[@4, @2];
//        [self.bottomLabel.layer addSublayer:border];
        
        
        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
        NSDictionary *textdic=[stand objectForKey:[NSString stringWithFormat:@"6%@text",[FCAppInfo shareManager].temID]];
        if (textdic.count>2) {
            
        }else{
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_3_2"];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
                TextIndex=@"毕业不是终点，而是起点；这里没有末路，你从不曾孤独。";
                
            }

            NSString *font1=@"15";
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            [stand setObject:dic forKey:[NSString stringWithFormat:@"6%@text",[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
    }
    return self;
}
-(void)setLFL{
    
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
