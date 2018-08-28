//
//  DraftCollectionViewCell.h
//  Fencheng
//
//  Created by lifalin on 2018/7/24.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraftCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *bgImage;  //背景图
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIImageView *EditImg;

@property (nonatomic, strong) UIButton *gxButton;
@end
