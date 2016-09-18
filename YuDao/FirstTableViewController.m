//
//  FirstTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "FirstTableViewController.h"
#import "SetupModel.h"

@interface FirstTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation FirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        switch (self.row) {
            case 0:
            {
                SetupModel *model1 = [SetupModel modelWithTitle:@"系统活动" subTitle:nil];
                SetupModel *model2 = [SetupModel modelWithTitle:@"好友聊天" subTitle:nil];
                SetupModel *model3 = [SetupModel modelWithTitle:@"车辆异常" subTitle:nil];
                _dataSource = @[model1,model2,model3];
                break;
            }
            case 1:
            {
                SetupModel *model1 = [SetupModel modelWithTitle:@"通过搜索找到我" subTitle:@"关闭后其它用户将无法通过搜索找到你"];
                SetupModel *model2 = [SetupModel modelWithTitle:@"屏蔽手机联系人" subTitle:@"屏蔽你的手机联系人好友"];
                SetupModel *model3 = [SetupModel modelWithTitle:@"共同联系人" subTitle:nil];
                SetupModel *model4 = [SetupModel modelWithTitle:@"哔哔时不要显示我" subTitle:@"使用哔哔时别人无法获得你的位置"];
                SetupModel *model5 = [SetupModel modelWithTitle:@"刷脸不要显示我" subTitle:nil];
                SetupModel *model6 = [SetupModel modelWithTitle:@"显示我的动态" subTitle:@"不向陌生人展示位的动态"];
                _dataSource = @[model1,model2,model3,model4,model5,model6];
                break;
            }
            case 2:
            {
                SetupModel *model1 = [SetupModel modelWithTitle:@"路况分析" subTitle:@"通过车辆行驶路线分析路况"];
                SetupModel *model2 = [SetupModel modelWithTitle:@"检测我的爱车" subTitle:@"定期检测车辆保障行驶安全"];
                _dataSource = @[model1,model2];
                break;
            }
            default:
                break;
        }
        
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource ? self.dataSource.count: 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"firstCell";
    SetupModel *model = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UISwitch *swit = [UISwitch new];
    swit.tag = indexPath.row;
    [swit addTarget:self action:@selector(SwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    //设置开关的状态
    swit.on = [[NSUserDefaults standardUserDefaults] boolForKey:model.title];
    cell.accessoryView = swit;
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.subTitle;
    return cell;
}

- (void)SwitchValueChange:(UISwitch *)sender{
    SetupModel *model = self.dataSource[sender.tag];
    //把开关状态保存到用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.isOn forKey:model.title];
    [defaults synchronize];//保存同步
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
