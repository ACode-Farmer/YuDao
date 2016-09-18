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
        self.contentSize = CGSizeMake(4*screen_width, 300);
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
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing = 10.0f;//行间距
    layout.minimumInteritemSpacing = 10.0f;//item间距(最小值)
    layout.sectionInset = UIEdgeInsetsMake(5, 50, 0, 50);//设置section的边距
    
    for (NSInteger i = 0; i < 4; i++) {
        CGRect subFrame = CGRectMake(i * screen_width, 0, screen_width, self.frame.size.height);
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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ListCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell.layer setCornerRadius:5.0f];
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(80,80);
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld %ld",indexPath.section,indexPath.row);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
