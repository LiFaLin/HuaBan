//
//  YTwoCell.h
//  Fencheng
//
//  Created by lifalin on 2018/6/27.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTwoCell : UICollectionViewCell
@property (nonatomic, strong) UIButton *addButton;   //添加图片按钮
@property (nonatomic, strong)LFLVideoPlayer * player;
@property (nonatomic, strong)UIImageView *centerImg;
@property (nonatomic, strong)UIImageView *bgImage;
@end
