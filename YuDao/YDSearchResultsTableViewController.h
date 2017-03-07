//
//  YDSearchResultsTableViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"
#import "YDSearchCell.h"

@interface YDSearchResultsTableViewController : YDTableViewController<UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *originalData;
@property (nonatomic, strong) NSArray *data;

@end
