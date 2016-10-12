//
//  OrdinaryTableViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDOrdinaryTableViewControllerDelegate <NSObject>

- (void)OrdinaryTableViewControllerWith:(UITableView *)tableView;

@end

@interface YDOrdinaryTableViewController : UITableViewController

@property (nonatomic, weak) id<YDOrdinaryTableViewControllerDelegate> selectedDelegate;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) BOOL isShow;

@end
