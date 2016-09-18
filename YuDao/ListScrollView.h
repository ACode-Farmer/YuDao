//
//  ListScrollView.h
//  YuDao
//
//  Created by 汪杰 on 16/9/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListScrollView : UIScrollView<UICollectionViewDataSource,UICollectionViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame;

@end
