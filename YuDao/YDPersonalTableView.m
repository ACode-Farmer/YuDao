//
//  YDPersonalTableView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPersonalTableView.h"
#import "YDPTimeAxisCell.h"

NSString *const kTimeAxisCellID = @"YDPTimeAxisCell";

@implementation YDPersonalTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [UIView new];
        
        [self registerClass:[YDPTimeAxisCell class] forCellReuseIdentifier:kTimeAxisCellID];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data ? self.data.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDPTimeAxisCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeAxisCellID];
    YDPTimeAxisModel *model = self.data[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDPTimeAxisModel *model = self.data[indexPath.row];
    return [self cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[YDPTimeAxisCell class]  contentViewWidth:screen_width];
}

@end
