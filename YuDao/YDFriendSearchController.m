//
//  YDFriendSearchController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDFriendSearchController.h"
#import "YDContactsCell.h"
#import "YDFriendModel.h"

#define     HEIGHT_NAVBAR               44.0f
#define     HEIGHT_STATUSBAR            20.0f

@interface YDFriendSearchController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation YDFriendSearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [[NSMutableArray alloc] init];;
    [self.tableView registerClass:[YDContactsCell class] forCellReuseIdentifier:@"FriendCell"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.y = HEIGHT_NAVBAR + HEIGHT_STATUSBAR;
    self.tableView.height = screen_height - self.tableView.y;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"联系人";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YDContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    
    YDFriendModel *model = [self.data objectAtIndex:indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - Delegate -
//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_FRIEND_CELL;
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    [self.data removeAllObjects];
    for (YDFriendModel *model in self.friendsData) {
        if ([model.friendName containsString:searchText]) {
            [self.data addObject:model];
        }
    }
    [self.tableView reloadData];
}

@end
