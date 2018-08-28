//
//  ColorView.m
//  Fencheng
//
//  Created by lifalin on 2018/6/11.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ColorView.h"
#import "ColorCollectionViewCell.h"
@interface ColorView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray * dataNumberArr;
}
@property(nonatomic,strong)UICollectionView * DataCollectionView;
@end
@implementation ColorView
@synthesize delegate;
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        dataNumberArr=[NSMutableArray arrayWithCapacity:0];
        NSArray *arr=@[@0x224d46,@0xd54e6f,@0xe0310e,@0x173784,@0x7b267a,@0x077265,@0x000000,@0x749bad,@0xdd6d8a,@0xff9600,@0x085eac,@0xb882f6,@0x4cad50,@0x777777,@0x79c1d4,@0xe37c90,@0xffbf07,@0x03a7f2,@0xc8b9d8,@0x89c14a,@0xd1cfcf,@0xb0d9cd,@0xf1bdc7,@0xffe93b,@0x7cb2fa,@0xb8b7bc,@0xcbda39,@0xffffff];
        dataNumberArr=[NSMutableArray arrayWithArray:arr];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(35, 35);
        
        _DataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH,260) collectionViewLayout:layout];
        _DataCollectionView.backgroundColor = [UIColor whiteColor];
        _DataCollectionView.dataSource = self;
        _DataCollectionView.delegate = self;
        _DataCollectionView.showsVerticalScrollIndicator=YES;
        
        [_DataCollectionView registerClass:[ColorCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        
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
    
     int rgb= [dataNumberArr[indexPath.row] intValue];
    
    ColorCollectionViewCell *cell8 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell8.editButton addTarget:self action:@selector(editButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell8.editButton setBackgroundColor:UIColorFromHex(rgb)];
    cell8.editButton.tag=indexPath.row;
    return cell8;
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}
-(void)editButton:(UIButton*)sender{
   
    int rgb= [dataNumberArr[sender.tag] intValue];
    [self.delegate chooseColorAction:rgb];
}


@end
