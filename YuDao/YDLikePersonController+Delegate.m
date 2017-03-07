//
//  YDLikePersonController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/11/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDLikePersonController+Delegate.h"
#import "YDLikedListCell.h"
#import "YDUserFilesController.h"

@implementation YDLikePersonController (Delegate)

- (void)registerCellClass{
    [self.tableView registerClass:[YDLikedListCell class] forCellReuseIdentifier:@"YDLikedListCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDLikedListCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"YDLikedListCell"];
    YDLikePersonModel *model = self.data[indexPath.row];
    cell.dataType = self.likedType;
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDLikePersonModel *model = self.data[indexPath.row];
    
    NSNumber *ubid;
    if (self.likedType == 1) {
        ubid = model.ub_id;
    }else{
        ubid = model.e_ub_id;
    }
    //跳转到个人详情页面
    YDUserFilesController *userVC = [YDUserFilesController new];
    userVC.currentUserId = ubid;
    [self.parentViewController.navigationController pushViewController:userVC animated:YES];
}

@end
