//
//  headerTableVIew.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDSearchController.h"
#import "YDSearchResultsTableViewController.h"
@class HeaderModel;
@protocol HeaderTableViewDelegate <NSObject>

- (void)clickHeaderTableViewCell:(HeaderModel *)model;

@end

@interface HeaderTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<HeaderTableViewDelegate> clickCellDelegate;

@property (nonatomic ,strong) YDSearchController *searchVC;
@property (nonatomic, strong) YDSearchResultsTableViewController *searchResultsVC;
- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource;

@end
