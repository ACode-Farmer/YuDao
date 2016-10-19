//
//  YDMoreKeyboard.h
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBaseKeyboard.h"
#import "YDKeyboardDelegate.h"
#import "YDMoreKeyboardDelegate.h"


@interface YDMoreKeyboard : YDBaseKeyboard

@property (nonatomic, weak) id<YDMoreKeyboardDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *chatMoreKeyboardData;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

+ (YDMoreKeyboard *)keyboard;

@end
