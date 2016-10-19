//
//  YDMoreKeyboard+CollectionView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMoreKeyboard.h"

@interface YDMoreKeyboard (CollectionView)<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign, readonly) NSInteger pageItemCount;

- (void)registerCellClass;

@end
