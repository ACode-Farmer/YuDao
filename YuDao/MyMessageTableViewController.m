//
//  MyMessageTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyMessageTableViewController.h"
#import "MyMseeageModel.h"
#import "UIImage+ChangeIt.h"
@interface MyMessageTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation MyMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 45.0f;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        MyMseeageModel *model = [MyMseeageModel modelWith:@"message" name:@"系统通知" lastMessage:@"想要邂逅你的她/他，速来尝试发现里的逛一逛..." time:@"下午4:00"];
        [_dataSource addObject:model];
        for (NSInteger i = 0; i<10; i++) {
            MyMseeageModel *model = [MyMseeageModel modelWith:@"icon1.jpg" name:@"小明" lastMessage:@"好多美女，速来xxxx酒吧，在那个xxxx路上" time:@"下午4:00"];
            [_dataSource addObject:model];
        }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource ? self.dataSource.count : 0 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyMessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.imageView.layer.cornerRadius = 5.0f;
        cell.imageView.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyMseeageModel *model = self.dataSource[indexPath.row];
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.imageName] inRect:CGRectMake(40, 40, 40, 40)];
    cell.imageView.image = image;
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.lastMessage;
    if (indexPath.row == 0) {
        
    }else{
        cell.accessoryView = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentRight;
            label.text = model.time;
            label;
        });
    }
    
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
