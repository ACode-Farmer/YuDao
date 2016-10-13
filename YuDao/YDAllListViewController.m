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
    if (indexPath.row <= 2) {
        return 74.f;
    }
    return 58.f;
}

#pragma mark Getter
- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithCapacity:10];
        YDAllListItem *item1 = [YDAllListItem modelWithPlacing:@"   NO.1\n遥不可及" imageName:@"head0.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item2 = [YDAllListItem modelWithPlacing:@"   NO.2\n遥不可及" imageName:@"head1.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item3 = [YDAllListItem modelWithPlacing:@"   NO.3\n遥不可及" imageName:@"head2.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item4 = [YDAllListItem modelWithPlacing:@"NO.4" imageName:@"head3.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item5 = [YDAllListItem modelWithPlacing:@"NO.5" imageName:@"head4.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item6 = [YDAllListItem modelWithPlacing:@"NO.6" imageName:@"head4.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item7 = [YDAllListItem modelWithPlacing:@"NO.7" imageName:@"head4.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item8 = [YDAllListItem modelWithPlacing:@"NO.8" imageName:@"head4.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item9 = [YDAllListItem modelWithPlacing:@"NO.9" imageName:@"head4.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        YDAllListItem *item10 = [YDAllListItem modelWithPlacing:@"NO.10" imageName:@"head4.jpg" name:@"Wilson" isLiked:NO data:@"110KM"];
        [_data addObject:item1];
        [_data addObject:item2];
        [_data addObject:item3];
        [_data addObject:item4];
        [_data addObject:item5];
        [_data addObject:item6];
        [_data addObject:item7];
        [_data addObject:item8];
        [_data addObject:item9];
        [_data addObject:item10];
    }
    return _data;
}

@end
