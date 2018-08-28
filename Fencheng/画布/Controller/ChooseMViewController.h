//
//  ChooseMViewController.h
//  Fencheng
//
//  Created by lifalin on 2018/5/29.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "BaseVC.h"

@interface ChooseMViewController : BaseVC
@property(nonatomic,strong)void(^myBlock)(NSString*,NSString*);
@end
