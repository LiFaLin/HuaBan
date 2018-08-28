//
//  Comment1CollectionViewCell.h
//  Fencheng
//
//  Created by lifalin on 2018/7/18.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Comment1CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *bgImage;  //背景图
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) lflLabel *commentLabel;

@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *deleteButton;
@end
