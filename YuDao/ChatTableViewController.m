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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
