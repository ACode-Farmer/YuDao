//
//  YDSearchResultsTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDSearchResultsTableViewController.h"
#import "YDUserFilesController.h"
@interface YDSearchResultsTableViewController ()



@end

@implementation YDSearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorGrayBG];
    self.data = [NSMutableArray array];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self.tableView registerClass:[YDSearchCell class] forCellReuseIdentifier:@"YDSearchCell"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tableView.y = height_navBar + height_statusBar;
    self.tableView.height = screen_height-self.tableView.y;
}

- (void)setData:(NSArray *)data{
    _data = data;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"用户";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count: 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDSearchCell"];
    YDSearchModel *searchModel = self.data[indexPath.row];
    cell.searchModel = searchModel;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDSearchModel *searchModel = self.data[indexPath.row];
    YDUserFilesController *userVC = [YDUserFilesController new];
    userVC.currentUserId = searchModel.ub_id;
    NSLog(@"pred = %@ pring = %@",self.presentedViewController,self.presentingViewController);
    [self.presentingViewController.navigationController pushViewController:userVC animated:YES];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"updateSearchResultsForSearchController");
}

@end
