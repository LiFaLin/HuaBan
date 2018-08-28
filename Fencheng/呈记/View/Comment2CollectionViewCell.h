//
//  Comment2CollectionViewCell.h
//  Fencheng
//
//  Created by lifalin on 2018/7/20.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Comment2CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) lflLabel *commentLabel;

@property (nonatomic, strong)UIView *horizontalLine;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@end
