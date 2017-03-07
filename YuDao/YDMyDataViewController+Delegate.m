//
//  YDMyDataViewController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMyDataViewController+Delegate.h"
#import "YDPersonalHeaderController.h"

#import "YDInterestsController.h"

#import "YDEmotionController.h"
#import "YDPlaceController.h"
#import "YDAgeController.h"

@implementation YDMyDataViewController (Delegate)

- (void)registerCell{
    
    [self.tableView registerClass:[YDMyInfoHeaderCell class] forCellReuseIdentifier:@"YDMyInfoHeaderCell"];
    [self.tableView registerClass:[YDMyInfoInputCell class] forCellReuseIdentifier:@"YDMyInfoInputCell"];
    [self.tableView registerClass:[YDMyInfoGenderCell class] forCellReuseIdentifier:@"YDMyInfoGenderCell"];
    [self.tableView registerClass:[YDMyInfoEnterCell class] forCellReuseIdentifier:@"YDMyInfoEnterCell"];
}

#pragma mark - YDMyInfoBaseCellDelegate
- (void)myInfoBaseCell:(YDMyInfoBaseCell *)cell changeText:(NSString *)text{
    NSString *title = cell.model.title;
    if ([title isEqualToString:@"昵称"]) {
        self.tempUser.ub_nickname = text;
    }else if ([title isEqualToString:@"真实姓名"]){
        self.tempUser.ud_realname = text;
    }else if ([title isEqualToString:@"性别"]){
        self.tempUser.ud_sex = [text isEqualToString:@"男"] ? @1 :@2;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDMyInfoBaseCell *cell = nil;
    NSString *reuseIdentifier = nil;
    if (indexPath.row == 0) {
        reuseIdentifier = @"YDMyInfoHeaderCell";
    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        reuseIdentifier = @"YDMyInfoInputCell";
    }
    if (indexPath.row == 4) {
        reuseIdentifier = @"YDMyInfoGenderCell";
    }
    if (indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7) {
        reuseIdentifier = @"YDMyInfoEnterCell";
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.model = self.data[indexPath.row];
    cell.delegate = self;
    if (indexPath.row == self.data.count-1) {
        cell.lineView.hidden = YES;
    }
    
    return cell? cell :[UITableViewCell new];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:{//修改头像
            [self.navigationController pushViewController:[YDPersonalHeaderController new] animated:YES];
            break;}
        case 3:{//修改年龄
            YDAgeController *vc = [YDAgeController new];
            [self.navigationController pushViewController:vc animated:YES];
            break;}
        case 5:{//修改情感状态
            [self.navigationController pushViewController:[YDEmotionController new] animated:YES];
            break;}
        case 6:{//修改常出没地
            [self.navigationController pushViewController:[YDPlaceController new] animated:YES];
            break;}
        case 7:{//修改兴趣
            [self.navigationController pushViewController:[YDInterestsController new] animated:YES];
            break;}
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (YDMyInfoBaseCell *cell in self.tableView.visibleCells) {
        [cell.textField resignFirstResponder];
    }
}


@end
