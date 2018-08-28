//
//  RegisterView.h
//  Fencheng
//
//  Created by lifalin on 2018/6/4.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisterViewDelegate <NSObject>
-(void)backAction;
-(void)YZMAction;
-(void)NextAction;
@end
@interface RegisterView : UIView
@property (nonatomic, unsafe_unretained) id <RegisterViewDelegate> delegate;
@end
