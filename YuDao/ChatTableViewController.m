//
//  ChatTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ChatTableViewController.h"
#import "ChatCell.h"
#import "ChatModel.h"


@interface ChatTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[ChatCell class] forCellReuseIdentifier:@"ChatCell"];
    
}

#pragma mark lazy load
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            ChatModel *model = [ChatModel modelWithImage:@"icon1.jpg" content:@"默默默默默默默默默默默默默默默默默默默默默默默默默默默默" time:@"7:01" type:0];
            [_dataSource addObject:model];
        }
        for (int i = 0; i < 5; i++) {
            ChatModel *model = [ChatModel modelWithImage:@"icon2.jpg" content:@"我默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默默" time:@"8:01" type:1];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

#pragma mark - TableViewDatasource
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatModel *model = self.dataSource[indexPath.row];
    return model.rowHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource? self.dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    
    ChatModel *model = self.dataSource[indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
