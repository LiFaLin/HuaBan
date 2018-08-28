//
//  ColorView.h
//  Fencheng
//
//  Created by lifalin on 2018/6/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ColorViewDelegate <NSObject>
-(void)chooseColorAction:(int)index;
@end
@interface ColorView : UIView
@property (nonatomic, unsafe_unretained) id <ColorViewDelegate> delegate;
@end
