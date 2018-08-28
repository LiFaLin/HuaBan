//
//  FontView.m
//  Fencheng
//
//  Created by lifalin on 2018/6/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "FontView.h"
#import "FontNameCollectionViewCell.h"
@interface FontView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray * dataNumberArr;
     NSMutableArray * FontNameArr;
}
@property(nonatomic,strong)UICollectionView * DataCollectionView;
@end
@implementation FontView
@synthesize delegate;
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        dataNumberArr=[NSMutableArray arrayWithCapacity:0];
        FontNameArr=[NSMutableArray arrayWithCapacity:0];
        NSArray *arr=@[@"fontName2",@"fontName3",@"fontName4",@"fontName5",@"fontName6",@"fontName7",@"fontName8"];
        NSArray *Namearr=@[@"YRDZST-Regular",@"SentyTEA-4800",@"SentyMARUKO Âµ",@"HappyZcool-2016",@"DengXian",@"KaiTi",@"STZhongsong"];
        dataNumberArr=[NSMutableArray arrayWithArray:arr];
        FontNameArr=[NSMutableArray arrayWithArray:Namearr];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(100, 70);
        
        _DataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH,260) collectionViewLayout:layout];
        _DataCollectionView.backgroundColor = [UIColor whiteColor];
        _DataCollectionView.dataSource = self;
        _DataCollectionView.delegate = self;
        _DataCollectionView.showsVerticalScrollIndicator=YES;
        
        [_DataCollectionView registerClass:[FontNameCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        
        [self addSubview:_DataCollectionView];
    }return self;
}
#pragma UICollectionDelegate
//collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataNumberArr.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string=[NSString stringWithFormat:@"%@",dataNumberArr[indexPath.row]];
    
    FontNameCollectionViewCell *cell8 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell8.editButton addTarget:self action:@selector(editButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell8.editButton setBackgroundImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
    cell8.editButton.tag=indexPath.row;
    return cell8;
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
}
-(void)editButton:(UIButton*)sender{
    NSString *indexpath1=[NSString stringWithFormat:@"%@",FontNameArr[sender.tag]];
    [self.delegate chooseItemAction:indexpath1];
}
@end
//找到外部字体的方法
//NSArray *familyNames = [UIFont familyNames];
//for( NSString *familyName in familyNames ){
//    NSLog(@"Family:%@",familyName);
//
//    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//
//    for( NSString *fontName in fontNames ){
//        NSLog(@"tFont:%@",fontName);
//    }
//    }
