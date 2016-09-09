//
//  HomePageTableView.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableNode;

@protocol homeTableViewDelegate <NSObject>

- (void)clickCell :(TableNode *)node rect :(CGRect)rect;

@end

@interface HomePageTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,weak) id<homeTableViewDelegate> homeTableViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource;

@end
