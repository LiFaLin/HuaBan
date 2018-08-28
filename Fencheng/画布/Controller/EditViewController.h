//
//  EditViewController.h
//  Fencheng
//
//  Created by lifalin on 2018/6/7.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "BaseVC.h"

@interface EditViewController : BaseVC
@property(nonatomic,strong)void(^textFontBlock)(NSString*,int,NSString*,int);
@property(nonatomic,strong)NSString * temID;
@property(nonatomic,strong)NSString * temID1;
@property(nonatomic,strong)NSString * keyStr;
@property(nonatomic,strong)NSString * text;
@property(nonatomic,assign)int textfont;
@property(nonatomic,assign)int textcolor;
@property(nonatomic,strong)NSString * textfontName;
@property(nonatomic,strong)NSString * texttextAlign;
@property(nonatomic,strong)NSString * isHeader;
@property(nonatomic,strong)NSString * modeId;
@end
