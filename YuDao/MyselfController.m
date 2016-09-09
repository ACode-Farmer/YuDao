//
//  MyselfController.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyselfController.h"

@interface MyselfController ()

@property (nonatomic, strong) NSArray *datasource;

@property (nonatomic, strong) NSArray *firstSectionData;
@property (nonatomic, strong) NSArray *secondSectionData;
@property (nonatomic, strong) NSArray *thridSectionData;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation MyselfController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    self.firstSectionData = @[@"我的资料",@"我的车库"];
    self.secondSectionData = @[@"我的消息",@"通讯录",@"我的群组",@"喜欢的人"];
    self.thridSectionData = @[@"我的二维码",@"设置"];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.rowHeight = 40.0f;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
        [_headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pbg.jpg"]]];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon1.jpg"]];
        userImage.frame = CGRectMake(20, 80, 60, 60);
        userImage.layer.cornerRadius = 30;
        userImage.layer.masksToBounds = YES;
        
        UIImageView *genderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"woman"]];
        genderImage.frame = CGRectMake(100, 110, 30, 30);
        genderImage.layer.cornerRadius = 15;
        genderImage.layer.masksToBounds = YES;
        
        UILabel *vipLabel = [[UILabel alloc] init];
        vipLabel.frame = CGRectMake(screen_width-100, 110, 100, 30);
        vipLabel.text = @"认证等级 V5";
        vipLabel.backgroundColor = [UIColor orangeColor];
        vipLabel.textColor = [UIColor whiteColor];
        
        UILabel *likeLabel = [[UILabel alloc] init];
        likeLabel.frame = CGRectMake(screen_width-100, 70, 100, 30);
        likeLabel.text = @"6666喜欢";
        likeLabel.backgroundColor = [UIColor blueColor];
        likeLabel.textColor = [UIColor whiteColor];
        
        NSArray *headerSubViews = @[userImage,genderImage,likeLabel,vipLabel];
        [headerSubViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_headerView addSubview:obj];
        }];
    }
    return _headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _firstSectionData.count;
            break;
        case 1:
            return _secondSectionData.count;
            break;
        case 2:
            return _thridSectionData.count;
            break;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"NO.2Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = _firstSectionData[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = _secondSectionData[indexPath.row];
            break;
        case 2:
            cell.textLabel.text = _thridSectionData[indexPath.row];
            break;
        default:
            break;
    }
    cell.imageView.image = [UIImage imageNamed:@"targetIcon"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                 [self performSegueWithIdentifier:@"MyInformation" sender:nil];
            }
            break;
        }
        case 1:
        {
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                [self performSegueWithIdentifier:@"Contacts" sender:nil];
            }
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
