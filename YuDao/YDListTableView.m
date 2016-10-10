//
//  YDListTableView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDListTableView.h"
#import "YDListCell.h"
#import "ListViewModel.h"

#define kYDListRowHeight 54 * widthHeight_ratio

static NSString *const YDListCellIdentifier = @"YDListCell";

@implementation YDListTableView
{
    NSMutableArray *_dataSource;
}

- (instancetype)initWithDataSource:(NSMutableArray<ListViewModel *> *)dataSource{
    if (self = [super init]) {
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = kYDListRowHeight;
        _dataSource = [dataSource mutableCopy];
        [self registerClass:[YDListCell class] forCellReuseIdentifier:YDListCellIdentifier];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource? _dataSource.count:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YDListCell *cell = [tableView dequeueReusableCellWithIdentifier:YDListCellIdentifier];
    cell.model = _dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ListViewModel *model = _dataSource[indexPath.row];
    if (self.listTableViewDelegate && [self.listTableViewDelegate respondsToSelector:@selector(ListTableViewWithName:)]) {
        [self.listTableViewDelegate ListTableViewWithName:model.name];
    }
}

@end
