//
//  SetupTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "SetupTableViewController.h"
#import "UniversalViewController.h"
#import "AdviseController.h"
#import "AboutUsController.h"
#import "ProtocolViewController.h"

@interface SetupTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;


@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (NSArray *)dataSource{
    if (!_dataSource) {
        NSArray *section1 = @[@"消息通知",@"隐私设置",@"功能设置"];
        NSArray *section2 = @[@"意见反馈",@"关于我们",@"版本更新",@"用户使用协议"];
        NSArray *section3 = @[@"退出登录"];
        _dataSource = @[section1,section2,section3];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource ? self.dataSource.count: 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource? [self.dataSource[section] count] : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"SetupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *text = self.dataSource[indexPath.section][indexPath.row];
    if ([text isEqualToString:@"退出登录"]) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = text;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            UniversalViewController *vc = [[UniversalViewController alloc] initWithControllerType:indexPath.row title:self.dataSource[indexPath.section][indexPath.row]];
            [self.navigationController pushViewController:vc animated:YES];
            break;}
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[AdviseController new] animated:YES];
                    break;
                case 1:
                    [self.navigationController pushViewController:[AboutUsController new] animated:YES];
                    break;
                case 2:
                {
                    UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"遇道" message:@"发现新的版本1.11，是否立即更新？" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:cancel];
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil];
                    break;}
                case 3:
                    [self.navigationController pushViewController:[ProtocolViewController new] animated:YES];
                    break;
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出登录?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *changeUser = [UIAlertAction actionWithTitle:@"切换帐号" style:0 handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *sinOut = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:changeUser];
            [alert addAction:sinOut];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            
            break;
        }
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
