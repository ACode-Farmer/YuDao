//
//  YDContactsViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDContactsViewController.h"
#import "YDSearchController.h"
#import "YDContactsViewController+Delegate.h"

#import "YDAddFriendViewController.h"


#define kFriendsURL @"http://www.ve-link.com/yulian/api/friendlist"

@interface YDContactsViewController ()<UIGestureRecognizerDelegate>


@property (nonatomic, strong) YDFriendHelper *friendHelper;

@property (nonatomic, strong) YDSearchController *searchController;

@property (nonatomic, strong) UIView       *tableHeaderView;

@property (nonatomic ,strong) YDContactsTableView *headerTableView;

@property (nonatomic, strong) NSArray *headerViewDataSource;

@end

@implementation YDContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通讯录"];
    [self registerCellClass];
    [self y_initUI];
    
    //初始化好友数据，优先读取数据库数据
    YDWeakSelf(self);
    [[YDFriendHelper sharedFriendHelper] updateFriendData:^(NSArray *data, NSArray *headers, NSInteger count) {
        weakself.data = [data mutableCopy];
        weakself.headers = [headers mutableCopy];
        [weakself.footerLabel setText:[NSString stringWithFormat:@"%ld位联系人",count]];
    }];
    [self downloadFriendsData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headerTableView reloadData];
    
}
//下载好友数据
- (void)downloadFriendsData{
    YDWeakSelf(self);
    [YDNetworking getUrl:kFriendsURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSArray *data = [YDFriendModel mj_objectArrayWithKeyValuesArray:[originalDic objectForKey:@"data"]];
        if (data.count == 0) {//数据空
            return ;
        }
        for (YDFriendModel *model in data) {
            //将好友存入数据库
            if ([[YDFriendHelper sharedFriendHelper] addFriendByUid:model]) {
                NSLog(@"初次进入将好友加入数据库成功");
            }else{
                NSLog(@"初次进入将好友加入数据库失败");
            }
        }
        if (data.count != weakself.data.count) {
            [[YDFriendHelper sharedFriendHelper] updateFriendData:^(NSArray *data, NSArray *headers, NSInteger count) {
                weakself.data = [data mutableCopy];
                weakself.headers = [headers mutableCopy];
                [weakself.footerLabel setText:[NSString stringWithFormat:@"%ld位联系人",count]];
                [weakself.tableView reloadData];
            }];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    [self.navigationController pushViewController:[YDAddFriendViewController new] animated:YES];
}
//点击右边添加好友
- (void)contactsRightBarItemAction:(UIBarButtonItem *)item{
    [self.navigationController pushViewController:[YDAddFriendViewController new] animated:YES];
}

#pragma mark - Private Methods -
- (void)y_initUI{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_contacts_addfriend"] style:UIBarButtonItemStylePlain target:self action:@selector(contactsRightBarItemAction:)];
    
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 0)];
    self.tableView.separatorColor = YDSeperatorColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor colorBlackForNavBar]];
    self.tableView.rowHeight = 53.f;
    
    [self.tableView setTableHeaderView:self.tableHeaderView];
    [self.tableView setTableFooterView:self.footerLabel];
    
    self.definesPresentationContext = YES;
    
}

#pragma mark - Getter -
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 93)];
        [_tableHeaderView addSubview:self.searchController.searchBar];
        [_tableHeaderView addSubview:self.headerTableView];
    }
    return _tableHeaderView;
}
- (YDSearchController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[YDSearchController alloc] initWithSearchResultsController:self.friendSearchVC];
        [_searchController setSearchResultsUpdater:self.friendSearchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}
- (YDContactsTableView *)headerTableView{
    if (!_headerTableView) {
        _headerTableView = [[YDContactsTableView alloc] initWithFrame:CGRectMake(0, 44, screen_width, 53)];
        _headerTableView.touchDelegate = self;
    }
    return _headerTableView;
}

- (UILabel *)footerLabel{
    if (_footerLabel == nil) {
        _footerLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screen_width, 50.0f)];
        [_footerLabel setTextAlignment:NSTextAlignmentCenter];
        [_footerLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [_footerLabel setTextColor:[UIColor grayColor]];
    }
    return _footerLabel;
}


@end
