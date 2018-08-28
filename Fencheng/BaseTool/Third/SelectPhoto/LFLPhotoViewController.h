//
//  LFLPhotoViewController.h
//  Fencheng
//
//  Created by lifalin on 2018/7/9.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "BaseVC.h"

@interface LFLPhotoViewController : BaseVC
@property (copy, nonatomic) void(^takePhotoBlock)(UIImage *photoImage);

@end
