//
//  CommentCollectionViewCell.h
//  Fencheng
//
//  Created by lifalin on 2018/7/18.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *lookImg;
@property (nonatomic, strong) UILabel *lookLab;
@property (nonatomic, strong) UIImageView *likeImg;
@property (nonatomic, strong) UILabel *likeLab;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIImageView *commentImg;
@property (nonatomic, strong) UILabel *commentLab;
@property (nonatomic, strong) UIButton *name1Button;
@end
