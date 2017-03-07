//
//  YDPhoneContactsController.h
//  YuDao
//
//  Created by 汪杰 on 16/11/22.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"
#import "YDFriendSearchController.h"
#import "YDSearchController.h"

@interface YDPhoneContactsController : YDTableViewController

@property(nonatomic,strong) NSMutableArray *indexArray;
@property(nonatomic,strong) NSMutableArray *letterResultArr;

@property(nonatomic,strong) YDFriendSearchController *friendSearchVC;
@property (nonatomic, strong) YDSearchController *searchController;

@end
