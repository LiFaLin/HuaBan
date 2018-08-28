//
//  ChooseMViewController.m
//  Fencheng
//
//  Created by lifalin on 2018/5/29.
//  Copyright © 2018年 lifalin. All rights reserved.
//

#import "ChooseMViewController.h"
#import "ChooseMCollectionViewCell.h"
@interface ChooseMViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * ChooseCollectionView;
@property(nonatomic,strong)NSArray * ImageArr;
@property(nonatomic,strong)NSArray * ModuleIdArr;
@end

@implementation ChooseMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"添加版式";
    [self confinLeftItemWithImg:[UIImage imageNamed:@"返回"]];
    
    _ImageArr=@[@"资源1",@"资源2",@"资源3",@"资源4",@"资源5",@"资源6",@"资源7",@"资源8",@"资源9",@"资源10"];
    _ModuleIdArr=@[@"Module_1_1",@"Module_1_2",@"Module_2_1",@"Module_2_2",@"Module_3_1",@"Module_3_2",@"Module_4_1",@"Module_4_2",@"Module_5_1",@"Module_5_2"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((self.view.bounds.size.width-20)/2.0, (self.view.bounds.size.width-100)/2.0);
    
    _ChooseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) collectionViewLayout:layout];
    _ChooseCollectionView.backgroundColor = [UIColor colorWithRed:241/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    _ChooseCollectionView.dataSource = self;
    _ChooseCollectionView.delegate = self;
    _ChooseCollectionView.showsVerticalScrollIndicator=YES;
    [_ChooseCollectionView registerClass:[ChooseMCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:_ChooseCollectionView];
    
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
    return _ImageArr.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *image=[NSString stringWithFormat:@"%@",_ImageArr[indexPath.row]];
    ChooseMCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.bgImage.image=[UIImage imageNamed:image];
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * string=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    NSString *ModuleId=[NSString stringWithFormat:@"%@",_ModuleIdArr[indexPath.row]];
    if (self.myBlock) {
        self.myBlock(string,ModuleId);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
