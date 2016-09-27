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
#import "XRWaterfallLayout.h"

NSString *const CellIdentifier = @"ListCollectionViewCell";

@interface ListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XRWaterfallLayoutDelegate>

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UICollectionView *collView;

@end

@implementation ListViewController

- (void)viewDidLoad{
    self.mainTitle = @"排行榜";
    UILabel *titleLabel = [self.titleView viewWithTag:1001];
    titleLabel.text = self.mainTitle;
    self.collView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor orangeColor];
}

#pragma lazy load
//头视图(top one)
- (UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [UIImageView new];
        _headerView.userInteractionEnabled = YES;
        [self.view addSubview:_headerView];
        
        _headerView.sd_layout
        .topSpaceToView(self.titleView,0)
        .leftEqualToView(self.titleView)
        .rightEqualToView(self.titleView)
        .heightIs(0.18*(screen_height-64-48));
        
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

//集合视图(top two ～ top ten)
- (UICollectionView *)collView{
    if (!_collView) {
        //创建瀑布流布局
        XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:3];
        //设置各属性的值
        //    waterfall.rowSpacing = 10;
        //    waterfall.columnSpacing = 10;
        //    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //或者一次性设置
        [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(0, 10, 10, 10)];
        
        //设置代理，实现代理方法
        waterfall.delegate = self;
        
        _collView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:waterfall];
        _collView.scrollEnabled = NO;
        _collView.backgroundColor = [UIColor blueColor];
        _collView.dataSource = self;
        _collView.delegate = self;
        
        [_collView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
        [self.view addSubview:_collView];
        
        _collView.sd_layout
        .topSpaceToView(self.headerView,0)
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .heightEqualToWidth();
    }
    return _collView;
}

#pragma mark XRWaterfallLayoutDelegate -
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    return itemWidth;
}

#pragma collectionView DataSource -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.layer setCornerRadius:5.0f];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

#pragma collectionView delegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld %ld",(long)indexPath.section,(long)indexPath.row);
}

////cell的最小行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    
//    return 0;
//}
////cell的最小列间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    
//    return 10;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(screen_width/5,screen_width/5);
//}
//

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(10, 30, 10, 30);
//}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"class = %@",NSStringFromClass([self class]));
}

@end
