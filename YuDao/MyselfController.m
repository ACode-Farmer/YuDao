//
//  MyselfController.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyselfController.h"
#import "ChangeImageController.h"
#import "LikedPeopleController.h"
#import "GarageViewController.h"

#import "MyselfModel.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "UIButton+ImageTitleSpacing.h"
@interface MyselfController ()

@property (nonatomic, strong) NSArray *datasource;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation MyselfController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
   
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.rowHeight = 60.f;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)datasource{
    if (!_datasource) {
        MyselfModel *model1 = [MyselfModel modelWithIamgeName:@"targetIcon" name:@"我的资料"];
        MyselfModel *model2 = [MyselfModel modelWithIamgeName:@"targetIcon" name:@"我的消息"];
        MyselfModel *model3 = [MyselfModel modelWithIamgeName:@"targetIcon" name:@"我的车库"];
        MyselfModel *model4 = [MyselfModel modelWithIamgeName:@"targetIcon" name:@"通讯录"];
        MyselfModel *model5 = [MyselfModel modelWithIamgeName:@"targetIcon" name:@"喜欢的人"];
        MyselfModel *model6 = [MyselfModel modelWithIamgeName:@"targetIcon" name:@"我的二维码"];
        _datasource = @[model1,model2,model3,model4,model5,model6];
    }
    return _datasource;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
        [_headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pbg.jpg"]]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_headerView addGestureRecognizer:tap];
        
        UIButton *userImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [userImageBtn setImage:[UIImage imageNamed:@"icon1.jpg"] forState:0];
        [userImageBtn setImage:[UIImage imageNamed:@"icon1.jpg"] forState:1];
        userImageBtn.frame = CGRectMake(screen_width/2 - 30, 20, 60, 60);
        userImageBtn.layer.cornerRadius = 30;
        userImageBtn.layer.masksToBounds = YES;
        [userImageBtn addTarget:self action:@selector(userImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *genderImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Like"]];
        genderImage.layer.cornerRadius = 15;
        genderImage.layer.masksToBounds = YES;
        
        UIButton *vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [vipBtn setTitle:@"认证等级 V5" forState:0];
        [vipBtn setTitleColor:[UIColor whiteColor] forState:0];
        vipBtn.backgroundColor = [UIColor orangeColor];
        [vipBtn setImage:[UIImage imageNamed:@"Like"] forState:0];
        vipBtn.enabled = NO;
        
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeBtn setTitle:@"666喜欢" forState:0];
        [likeBtn setTitleColor:[UIColor whiteColor] forState:0];
        likeBtn.backgroundColor = [UIColor orangeColor];
        [likeBtn setImage:[UIImage imageNamed:@"Like"] forState:0];
        likeBtn.enabled = NO;
        
        NSArray *headerSubViews = @[userImageBtn,genderImage,likeBtn,vipBtn];
        [headerSubViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_headerView addSubview:obj];
        }];
        genderImage.sd_layout
        .leftSpaceToView(userImageBtn,2)
        .bottomEqualToView(userImageBtn)
        .widthIs(30)
        .heightEqualToWidth();
        
        vipBtn.sd_layout
        .rightSpaceToView(userImageBtn,0)
        .topSpaceToView(userImageBtn,30)
        .widthIs(150)
        .heightIs(30);
        
        likeBtn.sd_layout
        .leftSpaceToView(userImageBtn,0)
        .topEqualToView(vipBtn)
        .widthIs(150)
        .heightIs(30);
        
        [vipBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
        [likeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
    }
    return _headerView;
}

- (void)tapAction:(id)sender{
    [self userImageBtnAction:nil];
}
- (void)userImageBtnAction:(UIButton *)sender{
    NSString *title = nil;
    if (sender) {
        title = @"更换头像";
    }else{
        title = @"更换封面背景";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *one = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ChangeImageController *changeVC = [ChangeImageController new];
        changeVC.optionalTitle = title;
        [self.navigationController pushViewController:changeVC animated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:one];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datasource? self.datasource.count : 0;
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
    MyselfModel *model = self.datasource[indexPath.row];
    cell.textLabel.text = model.name;
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"MyInformation" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"MyMessage" sender:nil];
            break;
        case 2:
            [self.navigationController pushViewController:[GarageViewController new] animated:YES];
            break;
        case 3:
            [self performSegueWithIdentifier:@"Contacts" sender:nil];
            break;
        case 4:
            [self.navigationController pushViewController:[LikedPeopleController new] animated:YES];
            break;
        case 5:
            
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
