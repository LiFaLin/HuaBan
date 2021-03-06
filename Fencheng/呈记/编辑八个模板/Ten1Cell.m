//
//  Ten1Cell.m
//  Fencheng
//
//  Created by lifalin on 2018/7/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "Ten1Cell.h"

@implementation Ten1Cell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    
    self = [super initWithFrame:frame];
    if (self)
    {
        //            self.backgroundColor=[UIColor whiteColor];
        
        _bgImage=[[UIImageView alloc]init];
        _bgImage.frame=CGRectMake(0, 0, self.bounds.size.width, kWidth(295));
        [self.contentView addSubview:_bgImage];
        
        
        
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame=CGRectMake(kWidth(50), 0, kWidth(220), kWidth(295));
        _addButton.backgroundColor=UIColorFromHex([FCAppInfo shareManager].boxColor);
        [self.contentView addSubview:_addButton];
        [FCAppInfo shareManager].bili10=220.00/295.00;
        
        _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame=CGRectMake(2, 0, kWidth(20), kWidth(20));
        _leftButton.layer.cornerRadius=13;
        _leftButton.clipsToBounds=YES;
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftButton];
        
        _centerImg=[[UIImageView alloc]init];
        _centerImg.image=[UIImage imageNamed:@"中间"];
        _centerImg.frame=CGRectMake(_addButton.bounds.size.width/2.0-15, _addButton.bounds.size.height/2.0-15, 30, 30);
        [_addButton addSubview:_centerImg];
        
        _editButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame=CGRectMake(kWidth(20), kWidth(310), kWidth(280),kWidth(32));
        [self.contentView addSubview:_editButton];
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, kWidth(1), kWidth(280),kWidth(32))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
        [_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
        
//        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
//        NSDictionary *textdic=[stand objectForKey:[NSString stringWithFormat:@"10%@text",[FCAppInfo shareManager].temID]];
//        if (textdic.count>2) {
//            
//        }else{
//            NSString *TextIndex;
//            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_5_2"];
//            if (arr.count>0) {
//                int y =(arc4random() % arr.count);
//                TextIndex=arr[y];
//            }else{
//                TextIndex=@"毕业季，离别季，但我们不说再见。";
//                
//            }
//            
//            NSString *font1=@"15";
//            NSString *color1=[NSString stringWithFormat:@"%@",@0xb0d9cd];
//            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
//            [stand setObject:dic forKey:[NSString stringWithFormat:@"10%@text",[FCAppInfo shareManager].temID]];
//            [stand synchronize];
//        }
        
        
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
