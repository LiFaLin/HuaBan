//
//  OneCell.m
//  Fencheng
//
//  Created by lifalin on 2018/5/31.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "OneCell.h"

@implementation OneCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        
        _bgImage=[[UIImageView alloc]init];
//        _bgImage.backgroundColor=[UIColor redColor];
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
        
//        _textView=[[UITextView alloc]init];
//        _textView.frame=CGRectMake(0, kWidth(1), self.bounds.size.width-2*kWidth(20), kheigh(49));
//        _textView.textColor=UIColorFromHex(0xcfe6de);
//        _textView.userInteractionEnabled=NO;
//        _textView.textContainerInset = UIEdgeInsetsZero;
//        _textView.textContainer.lineFragmentPadding = 0;
//        [_editButton addSubview:_textView];
        
        
        _bottomLabel = [[lflLabel alloc] initWithFrame:CGRectMake(0, kWidth(2), self.bounds.size.width-2*kWidth(20), kheigh(49))];
        _bottomLabel.textColor=UIColorFromHex(0xcfe6de);
        _bottomLabel.numberOfLines=0;
//        _bottomLabel.adjustsFontSizeToFitWidth=YES;
//        [_bottomLabel sizeToFit];
        [_bottomLabel setVerticalAlignment:VerticalAlignmentTop];
        [_editButton addSubview:_bottomLabel];
        
    
        NSUserDefaults *stand=[NSUserDefaults standardUserDefaults];
        NSDictionary *textdic=[stand objectForKey:[NSString stringWithFormat:@"1%@text",[FCAppInfo shareManager].temID]];
        if (textdic.count>2) {
            
        }else{
           
            NSString *TextIndex;
            NSArray *arr=[FCAppInfo shareManager].pDic[@"Module_1_1"];
            NSDictionary *tdic=[FCAppInfo shareManager].TDic;
            NSString *fontColor=[NSString stringWithFormat:@"%@",tdic[@"FontColor"]];
            if (arr.count>0) {
                int y =(arc4random() % arr.count);
                TextIndex=arr[y];
            }else{
               TextIndex=@"毕业了，如果不能成为彼此的永远，且让我们放下当初的青涩。我只要一份清简人生，与你静坐品茗半盏时光，只品茶香不问俗情，仅此，不负彼此的曾经。";
                
            }
            NSString *font1=@"15";
            NSString *color1=[NSString stringWithFormat:@"%@",fontColor];
            NSDictionary *dic=@{@"Text":TextIndex,@"FontSize":font1,@"FontFamily":@"KaiTi",@"Color":color1,@"TextAlign":@"Left"};
            [stand setObject:dic forKey:[NSString stringWithFormat:@"1%@text",[FCAppInfo shareManager].temID]];
            [stand synchronize];
        }
        
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
-(void)drawRect:(CGRect)rect{
    [[UIImage imageNamed:@"XXX"]drawInRect:rect];
}
@end
