//
//  InterestView.h
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestView : UIView

- (void)addItems:(NSArray *)items;
- (void)addItems:(NSArray *)items title:(NSString *)title;
- (void)addItemsToCell:(NSArray *)items;

- (void)addSearchItems:(NSArray *)items;

@end
