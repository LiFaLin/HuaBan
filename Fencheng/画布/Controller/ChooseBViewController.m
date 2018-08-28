//
//  ChooseBViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/5/31.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ChooseBViewController.h"
#import "ChooseBCollectionViewCell.h"
@interface ChooseBViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * ChooseBCollectionView;
@end

@implementation ChooseBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择版式";
//    [self resetTitleView:@"选择版式" withBackStr:@"" withBarBtNum:2 withTouch:NO withIsMainView:NO];
     [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((self.view.bounds.size.width-20)/3.0, (self.view.bounds.size.width-20)/2.0);
    
    _ChooseBCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) collectionViewLayout:layout];
    _ChooseBCollectionView.backgroundColor = [UIColor whiteColor];
    _ChooseBCollectionView.dataSource = self;
    _ChooseBCollectionView.delegate = self;
    _ChooseBCollectionView.showsVerticalScrollIndicator=YES;
    [_ChooseBCollectionView registerClass:[ChooseBCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:_ChooseBCollectionView];
}
-(void)popLeftItemView{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma UICollectionDelegate
//collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChooseBCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.bgImage.image=[UIImage imageNamed:@"模块"];
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
