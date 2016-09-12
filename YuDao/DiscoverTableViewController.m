//
//  DiscoverTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "DynamicTableViewController.h"
#import "DiscoverModel.h"

@interface DiscoverTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation DiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 45.f;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        DiscoverModel *model1 = [DiscoverModel modelWithImageName:@"" name:@"排行榜"];
        DiscoverModel *model2 = [DiscoverModel modelWithImageName:@"" name:@"哔哔"];
        DiscoverModel *model3 = [DiscoverModel modelWithImageName:@"" name:@"刷脸"];
        DiscoverModel *model4 = [DiscoverModel modelWithImageName:@"" name:@"逛一逛"];
        DiscoverModel *model5 = [DiscoverModel modelWithImageName:@"" name:@"测一测"];
        DiscoverModel *model6 = [DiscoverModel modelWithImageName:@"" name:@"驾驶成就"];
        DiscoverModel *model7 = [DiscoverModel modelWithImageName:@"" name:@"玩一把"];
        NSArray *section1 = @[model1];
        NSArray *section2 = @[model2,model3,model4];
        NSArray *section3 = @[model5,model6];
        NSArray *section4 = @[model7];
        _dataSource = @[section1,section2,section3,section4];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource? self.dataSource.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource? [self.dataSource[section] count] : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"discoverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    DiscoverModel *model = [self.dataSource objectAtIndex:indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

#pragma mark Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            if (indexPath.row == 2) {
                [self.navigationController pushViewController:[DynamicTableViewController new] animated:YES];
            }
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
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
