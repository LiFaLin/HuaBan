//
//  cengjiCollectionViewCell.h
//  Fencheng
//
//  Created by lifalin on 2018/6/20.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cengjiCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *bgImage;  //背景图
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIImageView *EditImg;

@property (nonatomic, strong) UIImageView *lookImg;
@property (nonatomic, strong) UILabel *lookLab;
@property (nonatomic, strong) UIImageView *likeImg;
@property (nonatomic, strong) UILabel *likeLab;

@property (nonatomic, strong) UIImageView *commentImg;
@property (nonatomic, strong) UILabel *commentLab;

@end
