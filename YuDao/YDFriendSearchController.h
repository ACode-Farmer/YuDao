//
//  YDFriendSearchController.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"

#define     HEIGHT_FRIEND_CELL      54.0f

@interface YDFriendSearchController : YDTableViewController<UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *friendsData;

@end
