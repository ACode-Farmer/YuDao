//
//  ListScrollView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ListScrollView.h"
//#import "CollectionViewLayout.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

NSString *const ListCollectionViewCellIdentifier = @"ListCollectionViewCell";

@implementation ListScrollView
{
    UICollectionView *_collectionView1;
    UICollectionView *_collectionView2;
    UICollectionView *_collectionView3;
    UICollectionView *_collectionView4;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentSize = CGSizeMake(4*screen_width, screen_width);
        self.backgroundColor = [UIColor whiteColor];
        self.directionalLockEnabled = YES;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    for (NSInteger i = 0; i < 4; i++) {
        CGRect subFrame = CGRectMake(i * screen_width, 0, screen_width, screen_width);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:subFrame collectionViewLayout:layout];
        collectionView.scrollEnabled = NO;
        collectionView.tag = 100+i;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        [collectionView registerNib:[UINib nibWithNibName:@"ListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ListCollectionViewCellIdentifier];
        [self addSubview:collectionView];
    }
}

#pragma collectionView DataSource -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ListCollectionViewCellIdentifier forIndexPath:indexPath];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
