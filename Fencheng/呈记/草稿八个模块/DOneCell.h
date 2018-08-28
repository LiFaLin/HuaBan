//
//  DOneCell.h
//  Fencheng
//
//  Created by lifalin on 2018/7/24.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOneCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *leftButton;  //左上角按钮
@property (nonatomic, strong) lflLabel *bottomLabel;  //文字label
@property (nonatomic, strong) UIButton *editButton;  //点击文字按钮
@property (nonatomic, strong)UIImageView *bgImage;
@property (nonatomic, strong)CAShapeLayer *border;
-(void)setLFL;
@end
