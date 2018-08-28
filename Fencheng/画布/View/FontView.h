//
//  FontView.h
//  Fencheng
//
//  Created by lifalin on 2018/6/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FontViewDelegate <NSObject>
-(void)chooseItemAction:(NSString*)fontName1;
@end
@interface FontView : UIView
@property (nonatomic, unsafe_unretained) id <FontViewDelegate> delegate;
@end
