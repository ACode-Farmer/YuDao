//
//  YDDynamicDetailController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDynamicDetailController+Delegate.h"

@implementation YDDynamicDetailController (Delegate)

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray? self.dataArray.count :0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YDDDContentCell *cell = [tableView dequeueReusableCellWithIdentifier:YDDDContentCellID];
        YDDDContentModel *model = self.dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDDNormalCellID];
        YDDDNormalModel *normalModel = self.dataArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:normalModel.imageName];
        cell.imageView.sd_cornerRadius = @5;
        cell.textLabel.text = normalModel.title;
        cell.detailTextLabel.text = normalModel.subTitle;
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"emptyCell"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YDDDContentModel *model = self.dataArray[indexPath.row];
        
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[YDDDContentCell class] contentViewWidth:[self cellContentViewWith]];
    }
    else{
        return 45.f;
    }
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
