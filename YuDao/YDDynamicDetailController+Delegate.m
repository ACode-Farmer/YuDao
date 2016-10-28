//
//  YDDynamicDetailController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDynamicDetailController+Delegate.h"
#import "ContactsTableViewController.h"
#import "GroupController.h"

@implementation YDDynamicDetailController (Delegate)

#pragma mark - AWActionSheetDelegate
- (int)numberOfItemsInActionSheet{
    return 8;
}

- (AWActionSheetCell*)cellForActionAtIndex:(NSInteger)index{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    NSDictionary *dic = self.shareArray[index];
    cell.iconView.image = [UIImage imageNamed:[dic valueForKey:@"imageName"]];
    
    [[cell titleLabel] setText:[dic valueForKey:@"title"]];
    cell.index = (int)index;
    return cell;
}

- (void)DidTapOnItemAtIndex:(NSInteger)index title:(NSString*)name{
    if ([name isEqualToString:@"好友"]) {
        [self.navigationController firstLevel_push_fromViewController:self toVC:[ContactsTableViewController new]];
    }
    if ([name isEqualToString:@"群组"]) {
        [self.navigationController secondLevel_push_fromViewController:self toVC:[GroupController new]];
    }
    
}
//MARK: - YDDDBottomViewDelegate
- (void)ddBottomView:(YDDDBottomView *)bottomView commentContent:(NSString *)content{
    YDDDNormalModel *model = [YDDDNormalModel new];
    model.imageName = @"head0.jpg";
    model.title = @"来啊来啊!";
    model.subTitle = content;
    
    [self.dataArray addObject:model];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]];
    CGRect cellRect = [cell.superview convertRect:cell.frame toView:window];
    CGPoint offset = self.tableView.contentOffset;
    offset.y += cellRect.size.height;
    [self.tableView setContentOffset:offset animated:YES];
    
}

- (void)ddBottomView:(YDDDBottomView *)bottomView didChangeTextViewHeight:(CGFloat)height{
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    //self.bottomView.height = height + 10;
}

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
        YDDDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:YDDDCommentCellID];
        YDDDNormalModel *normalModel = self.dataArray[indexPath.row];
        cell.model = normalModel;
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
        YDDDContentModel *model = self.dataArray[indexPath.row];
        
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[YDDDCommentCell class] contentViewWidth:[self cellContentViewWith]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.bottomView.textView resignFirstResponder];
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
