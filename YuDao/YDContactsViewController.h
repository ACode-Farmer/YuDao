//
//  YDContactsViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"
#import "YDFriendSearchController.h"
#import "YDFriendHelper.h"
#import "YDContactsModel.h"
#import "YDContactsTableView.h"

@interface YDContactsViewController : YDTableViewController

@property(nonatomic,strong) NSMutableArray *headers;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic,strong) YDFriendSearchController *friendSearchVC;

@property (nonatomic, strong) UILabel *footerLabel;

@end
