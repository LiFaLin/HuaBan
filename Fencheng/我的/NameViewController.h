//
//  NameViewController.h
//  Fencheng
//
//  Created by lifalin on 2018/6/6.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "BaseVC.h"

@interface NameViewController : BaseVC
@property(nonatomic,strong)void(^nickNameBlock)(NSString*);
@property(nonatomic,strong)NSString*Namestr;
@end
