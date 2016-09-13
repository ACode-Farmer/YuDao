//
//  RankingListTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "RankingListTableViewController.h"
#import <SDAutoLayout/UITableView+SDAutoTableViewCellHeight.h>
#import "RankingListCell.h"
#import "RankingListModel.h"

#define RankingCellIdentifier @"RankingCell"

@interface RankingListTableViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static UIButton *lastClickedBtn;
@implementation RankingListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [UIView new];
    //[self.tableView registerClass:[RankingListCell class] forCellReuseIdentifier:RankingCellIdentifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - lazy load
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
        NSArray *titleArray = @[@"里程",@"时速",@"油耗",@"滞留",@"积分",@"喜欢"];
        CGFloat space = 5.0f;
        CGFloat btnWidth = 45.0f;
        for (NSInteger i = 0; i < titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100 + i;
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake(space + i*(space+btnWidth), 2, btnWidth, 36);
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(ClickHeaderViewButton:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                button.selected = YES;
                lastClickedBtn = button;
            }
            [_headerView addSubview:button];
        }
    }
    return _headerView;
}

#pragma headerView - Button Action
- (void)ClickHeaderViewButton:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    lastClickedBtn.selected = !lastClickedBtn.selected;
    sender.selected = !sender.selected;
    lastClickedBtn = sender;
    
    
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            RankingListModel *model = [RankingListModel modelWithRanking:[NSString stringWithFormat:@"%ld",i] imageName:@"icon1.jpg" name:@"xxx" data:@"100km/h" isLike:YES];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource ? self.dataSource.count: 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:RankingCellIdentifier];
    if (cell == nil) {
        cell = [[RankingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RankingCellIdentifier];
    }
    RankingListModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankingListModel *model = self.dataSource[indexPath.row];
    CGFloat rowHeight = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RankingListCell class] contentViewWidth:screen_width];
    return rowHeight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
