//
//  YEightCell.h
//  Fencheng
//
//  Created by lifalin on 2018/6/27.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YEightCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *addButton;   //添加图片按钮
@property (nonatomic, strong) UIButton *add1Button;   //添加图片按钮
@property (nonatomic, strong) UIButton *add2Button;   //添加图片按钮
@property (nonatomic, strong) UIButton *add3Button;   //添加图片按钮

@property (nonatomic, strong)UIImageView *centerImg;
@property (nonatomic, strong)UIImageView *center1Img;
@property (nonatomic, strong)UIImageView *center2Img;
@property (nonatomic, strong)UIImageView *center3Img;
@property (nonatomic, strong)UIImageView *bgImage;
@end
