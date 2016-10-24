//
//  GroupController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "GroupController.h"
#import "PersonalController.h"
#import "CreateGroupController.h"
#import "YDGroupModel.h"
#import "UIImage+ChangeIt.h"

#import "YDMGroupDetailViewController.h"
#import "YDSearchController.h"
#import "YDSearchResultsTableViewController.h"

@interface GroupController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic ,strong) YDSearchController *searchVC;
@property (nonatomic, strong) YDSearchResultsTableViewController *searchResultsVC;

@end

@implementation GroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群组";
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
        rightItem;
    });
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
}

#pragma mark - Events
/**
 *  获得点击图片所在的行
 *
 */
- (void)groupTapCellGuestureAction:(UIGestureRecognizer *)tap{
    id selectedCell = [[tap.view superview] superview];
    NSIndexPath *selectedIndex = [self.tableView indexPathForCell:selectedCell];
    YDGroupModel *model = self.dataSource[selectedIndex.row];
    
    YDMGroupDetailViewController *gdVC = [[YDMGroupDetailViewController alloc] initWithType:model.groupType title:@"群组详情"];
    
    [self.navigationController secondLevel_push_fromViewController:self toVC:gdVC];
}

- (void)rightItemAction{
    [self.navigationController pushViewController:[CreateGroupController  new] animated:YES];
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"groupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.imageView.layer.cornerRadius = 10.0f;
        cell.imageView.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //给头像添加点击事件
        UITapGestureRecognizer *tapCell = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(groupTapCellGuestureAction:)];
        cell.imageView.userInteractionEnabled = YES;
        [cell.imageView addGestureRecognizer:tapCell];
        cell.detailTextLabel.font = [UIFont font_13];
    }
    YDGroupModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.groupImageName] inRect:CGRectMake(60, 60, 40, 40)];
    cell.imageView.image = image;
    cell.textLabel.text = model.groupName;
    if (model.groupType == YDGroupDetailTypeMine) {
        cell.detailTextLabel.text = @"我的群组";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    YDGroupModel *model = [self.dataSource objectAtIndex:indexPath.row];
//    ChatTableViewController *chatVC = [ChatTableViewController new];
//    chatVC.variableTitle = model.groupName;
//    [self.navigationController secondLevel_push_fromViewController:self toVC:chatVC];
}


#pragma mark - Events
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:20];
        YDGroupModel *model1 = [YDGroupModel groupModelWithGroupName:@"为了部落" groupImageName:@"test8.jpg" groupType:YDGroupDetailTypeMine];
        YDGroupModel *model2 = [YDGroupModel groupModelWithGroupName:@"艾欧尼亚" groupImageName:@"test8.jpg" groupType:YDGroupDetailTypeJoined];
        YDGroupModel *model3 = [YDGroupModel groupModelWithGroupName:@"为了联盟" groupImageName:@"test8.jpg" groupType:YDGroupDetailTypeJoined];
        [_dataSource addObject:model1];
        [_dataSource addObject:model2];
        [_dataSource addObject:model3];
    }
    return _dataSource;
}

- (YDSearchController *)searchVC{
    if (!_searchVC) {
        _searchVC = [[YDSearchController alloc] initWithSearchResultsController:self.searchResultsVC];
        [_searchVC setSearchResultsUpdater:self.searchResultsVC];
        [_searchVC.searchBar setPlaceholder:@"搜索"];
        //[_searchVC.searchBar setDelegate:self];
    }
    return _searchVC;
}

- (YDSearchResultsTableViewController *)searchResultsVC{
    if (!_searchResultsVC) {
        _searchResultsVC = [YDSearchResultsTableViewController new];
    }
    return _searchResultsVC;
}

@end
