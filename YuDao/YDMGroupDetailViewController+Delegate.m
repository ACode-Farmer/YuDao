//
//  YDMGroupDetailViewController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/10/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMGroupDetailViewController+Delegate.h"
#import "InterestView.h"
#import "MembersListController.h"
#import "InterestController.h"
@implementation YDMGroupDetailViewController (Delegate)

#pragma mark - Events
/**
 *  成员视图
 *
 *  @param view    cell.contentView
 *  @param members 成员数组
 */
- (void )memberAddView:(UIView *)view from:(NSMutableArray *)members{
    NSMutableArray *subViews = [NSMutableArray arrayWithCapacity:5];
    UIView *lastView = nil;
    for (NSInteger i = 0; i < members.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:members[i]]];
        [view addSubview:imageView];
        [subViews addObject:imageView];
        if (i == 0) {
            imageView.sd_layout
            .leftSpaceToView(view,0)
            .topSpaceToView(view,2)
            .bottomSpaceToView(view,2);
        }else{
            lastView = subViews[i-1];
            imageView.sd_layout
            .leftSpaceToView(lastView,0)
            .topSpaceToView(view,2)
            .bottomSpaceToView(view,2);
        }
        
        imageView.sd_cornerRadius = @10;
        imageView.layer.borderWidth = 5;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        
    }
    [view setSd_equalWidthSubviews:subViews];
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

#pragma mark - AWActionSheetDelegate
- (int)numberOfItemsInActionSheet{
    return 4;
}

- (AWActionSheetCell*)cellForActionAtIndex:(NSInteger)index{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    cell.iconView.image = [UIImage imageNamed:@"head0.jpg"];
    [[cell iconView] setBackgroundColor:
     [UIColor colorWithRed:rand()%255/255.0f
                     green:rand()%255/255.0f
                      blue:rand()%255/255.0f
                     alpha:1]];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",(int)index]];
    cell.index = (int)index;
    return cell;
}

- (void)DidTapOnItemAtIndex:(NSInteger)index title:(NSString*)name{

}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"GDCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"成员";
            cell.textLabel.textColor = [UIColor colorWithString:@"#784ea4"];
            cell.detailTextLabel.text = @"100人";
            cell.accessoryType = 1;
            break;}
        case 1:
        {
            [self memberAddView:cell.contentView from:self.members];
            break;}
        case 2:
        {
            cell.textLabel.text = @"所在位置";
            cell.textLabel.textColor = [UIColor colorWithString:@"#784ea4"];
            if (self.groupType == YDGroupDetailTypeMine || self.groupType == YDGroupDetailTypeNew) {
                cell.accessoryType = 1;
            }
            break;}
        case 3:
        {
            cell.textLabel.text = @"上海东方明珠塔";
            break;}
        case 4:
        {
            cell.textLabel.text = @"群组标签";
            cell.textLabel.textColor = [UIColor colorWithString:@"#784ea4"];
            if (self.groupType == YDGroupDetailTypeMine || self.groupType == YDGroupDetailTypeNew) {
                cell.accessoryType = 1;
            }
            break;}
        case 5:
        {
            if (!self.inView) {
                [self interestAddView:cell.contentView from:[NSMutableArray arrayWithObjects:@"旅行",@"美食",@"交友",@"同城聚会" ,nil]];
            }
            break;}
        case 6:
        {
            cell.textLabel.text = @"群组属性";
            cell.textLabel.textColor = [UIColor colorWithString:@"#784ea4"];
            break;}
        case 7:
        {
            cell.textLabel.text = @"群消息免打扰";
            UISwitch *swit = [UISwitch new];
            swit.tag = indexPath.row;
            [swit addTarget:self action:@selector(SwitchValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = swit;
            break;}
        case 8:
        {
            cell.textLabel.text = @"我的群名片";
            cell.detailTextLabel.text = @"Simon";
            cell.accessoryType = 1;
            break;}
        default:
            break;
    }
    
    return cell;
}
- (void)SwitchValueChange:(UISwitch *)swit{
    if (swit.on) {
        NSLog(@"开启免打扰");
    }else{
        NSLog(@"关闭免打扰");
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return screen_width/5+1;
    }else{
        return 43.f*widthHeight_ratio;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.groupType == YDGroupDetailTypeMine || self.groupType == YDGroupDetailTypeNew) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            [self.navigationController secondLevel_push_fromViewController:self toVC:[MembersListController new]];
        }else if (indexPath.row == 4){
            [self.navigationController secondLevel_push_fromViewController:self toVC:[InterestController new]];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"不是你创建的群组，你无权操作!"
                                                       delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
