//
//  YDMenuViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDAllListViewController.h"
#import "YDAllListCell.h"
#import "YDAllListItem.h"

static NSString *YDAllListCellIdentifier = @"YDAllListCell";

@interface YDAllListViewController ()

@end

@implementation YDAllListViewController

- (void) loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self.tableView setSeparatorColor:[UIColor colorGrayLine]];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 20)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[YDAllListCell class] forCellReuseIdentifier:YDAllListCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.data? self.data.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDAllListCell *cell = [tableView dequeueReusableCellWithIdentifier:YDAllListCellIdentifier ];
    
    YDAllListItem *item = self.data[indexPath.row];
    cell.allListItem = item;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58.f;
}

#pragma mark Getter
- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithCapacity:10];
        for (NSInteger i = 0; i < 5; i++) {
            YDAllListItem *item = [YDAllListItem modelWithPlacing:[NSString stringWithFormat:@"NO.%ld",i+1] imageName:[NSString stringWithFormat:@"head%ld.jpg",i] name:@"Wilson" isLiked:NO data:@"110KM"];
            [_data addObject:item];
        }
        for (NSInteger i = 0; i < 5; i++) {
            YDAllListItem *item = [YDAllListItem modelWithPlacing:[NSString stringWithFormat:@"NO.%ld",i+1] imageName:[NSString stringWithFormat:@"head%ld.jpg",i] name:@"Wilson" isLiked:YES data:@"110KM"];
            [_data addObject:item];
        }
    }
    return _data;
}

@end
