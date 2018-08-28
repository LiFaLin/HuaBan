//
//  UIImage+lfl.h
//  Fencheng
//
//  Created by lifalin on 2018/7/3.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (lfl)
- (UIImage *)normalizedImage;
+ (CGSize)getImageSizeWithURL:(id)URL;
@end
