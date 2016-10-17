//
//  YDPersonalDataController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPersonalDataController+Delegate.h"

@implementation YDPersonalDataController (Delegate)

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x/screen_width;
    NSLog(@"indext = %ld",index);
    if (index == 0) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        self.selectedBtn = self.leftBtn;
    }else{
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
        self.selectedBtn = self.rightBtn;
    }
}

#pragma mark -b UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"cellxxxxx"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellxxxxx"];
    }
    if (indexPath.row >= 0 && indexPath.row <= 4) {
        NSDictionary *dic = self.firstTableData[indexPath.row];
        cell.textLabel.text = [dic allKeys][0];
        cell.detailTextLabel.text = [dic valueForKey:cell.textLabel.text];
    }
    if (indexPath.row == 5){
        cell.textLabel.text = @"认证";
        cell.textLabel.textColor = [UIColor colorWithString:@"#784ea4"];
    }
    if (indexPath.row == 6){
        [cell.contentView addSubview:self.identifierView];
    }
    if (indexPath.row == 7){
        cell.textLabel.text = @"兴趣";
        cell.textLabel.textColor = [UIColor colorWithString:@"#784ea4"];
    }
    if (indexPath.row == 8){
        if (!self.inView) {
            [self interestAddView:cell.contentView from:[NSMutableArray arrayWithObjects:@"旅行",@"美食",@"交友",@"同城聚会" ,nil]];
        }
    }
    if (indexPath.row == 9){
        cell.textLabel.text = @"群组";
        cell.textLabel.textColor = [UIColor colorWithString:@"#784ea4"];
    }
    if (indexPath.row > 9){
        cell.textLabel.text = @"饮食男女";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

- (void)interestAddView:(UIView *)view from:(NSMutableArray *)interests{
    self.inView = [InterestView new];
    [view addSubview:self.inView];
    [self.inView addItemsToCell:interests];
    self.inView.sd_layout
    .topSpaceToView(view,0)
    .leftSpaceToView(view,0)
    .rightSpaceToView(view,0);
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return 100.0f;
    }else{
        return 45.f;
    }
}

@end
