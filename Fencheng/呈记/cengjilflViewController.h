//
//  cengjilflViewController.h
//  Fencheng
//
//  Created by lifalin on 2018/6/26.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "BaseVC.h"

@interface cengjilflViewController : BaseVC
@property(nonatomic,strong)NSString * ScrapbookId;
@property(nonatomic,strong)NSString * TemplateId;
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * ScrapbookName;
@property(nonatomic,strong)NSString * picture;
@property(nonatomic,strong)NSString * text;
-(void)didload;
@end
