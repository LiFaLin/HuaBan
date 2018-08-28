//
//  TwoCell.h
//  Fencheng
//
//  Created by lifalin on 2018/5/31.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *addButton;   //添加图片按钮
@property (nonatomic, strong) UIButton *leftButton;  //左上角按钮
@property (nonatomic, strong)UIImageView *centerImg;
@property (nonatomic, strong)UIImageView *bgImage;
@end
