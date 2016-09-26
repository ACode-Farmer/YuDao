//
//  ListViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ListViewController.h"
#import "ListCollectionViewCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

NSString *const CellIdentifier = @"ListCollectionViewCell";

@interface ListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UICollectionView *collView;

@end

@implementation ListViewController

- (void)viewDidLoad{
    UILabel *titleLabel = [self.titleView viewWithTag:1001];
    titleLabel.text = self.mainTitle;
    self.collView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor orangeColor];
}

#pragma lazy load
- (UICollectionView *)collView{
    if (!_collView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collView.scrollEnabled = NO;
        _collView.backgroundColor = [UIColor whiteColor];
        _collView.dataSource = self;
        _collView.delegate = self;
        
        [_collView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
        [self.view addSubview:_collView];
        
        _collView.sd_layout
        .topSpaceToView(self.headerView,0)
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .heightIs(screen_height);
    }
    return _collView;
}

- (UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [UIImageView new];
        _headerView.userInteractionEnabled = YES;
        [self.view addSubview:_headerView];
        
        _headerView.sd_layout
        .topSpaceToView(self.titleView,0)
        .leftEqualToView(self.titleView)
        .rightEqualToView(self.titleView)
        .heightIs(0.2*screen_height);
        
        UIImageView *headImage = [UIImageView new];
        headImage.image = [UIImage imageNamed:@"head0.jpg"];
        UILabel *rankingLabel = [UILabel new];
        rankingLabel.text = @"时速排行榜 TOP ONE";
        rankingLabel.textColor = [UIColor redColor];
        UILabel *nameLabel = [UILabel new];
        nameLabel.text = @"来啊！来啊！";
        nameLabel.textColor = [UIColor blackColor];
        UIButton *oneBtn = [UIButton new];
        UIButton *twoBtn = [UIButton new];
        UIButton *threeBtn = [UIButton new];
        [_headerView sd_addSubviews:@[headImage,rankingLabel,nameLabel,oneBtn,twoBtn,threeBtn]];
        
        headImage.sd_layout
        .centerYEqualToView(_headerView)
        .leftSpaceToView(_headerView,20)
        .heightRatioToView(_headerView,0.8)
        .widthEqualToHeight();
        headImage.sd_cornerRadius = @10;
        
        rankingLabel.sd_layout
        .topEqualToView(headImage)
        .leftSpaceToView(headImage,10)
        .heightRatioToView(headImage,0.333)
        .widthRatioToView(_headerView,0.5);
        
        nameLabel.sd_layout
        .centerYEqualToView(headImage)
        .leftEqualToView(rankingLabel)
        .heightRatioToView(headImage,0.333)
        .widthRatioToView(_headerView,0.5);
        
        oneBtn.sd_layout
        .bottomEqualToView(headImage)
        .leftEqualToView(nameLabel)
        .heightRatioToView(headImage,0.333)
        .widthRatioToView(_headerView,0.2);
        oneBtn.sd_cornerRadius = @5;
        oneBtn.backgroundColor = [UIColor whiteColor];
        [oneBtn setTitle:@"白羊座" forState:0];
        [oneBtn setTitleColor:[UIColor redColor] forState:0];
        
        twoBtn.sd_layout
        .bottomEqualToView(headImage)
        .leftSpaceToView(oneBtn,3)
        .heightRatioToView(headImage,0.333)
        .widthRatioToView(_headerView,0.2);
        twoBtn.sd_cornerRadius = @5;
        twoBtn.backgroundColor = [UIColor whiteColor];
        [twoBtn setTitle:@"自驾游" forState:0];
        [twoBtn setTitleColor:[UIColor redColor] forState:0];
        
        threeBtn.sd_layout
        .bottomEqualToView(headImage)
        .leftSpaceToView(twoBtn,3)
        .heightRatioToView(headImage,0.333)
        .widthRatioToView(_headerView,0.2);
        threeBtn.sd_cornerRadius = @5;
        threeBtn.backgroundColor = [UIColor whiteColor];
        [threeBtn setTitle:@"极限运动" forState:0];
        [threeBtn setTitleColor:[UIColor redColor] forState:0];
    }
    return _headerView;
}

#pragma collectionView DataSource -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.layer setCornerRadius:5.0f];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma collectionView delegate -
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((screen_width-15)/3,(screen_width-15)/3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld %ld",indexPath.section,indexPath.row);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}

@end
