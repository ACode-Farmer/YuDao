//
//  YDContactsViewController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDContactsViewController+Delegate.h"
#import "YDContactsCell.h"
#import "YDChatViewController.h"
#import "YDPhoneContactsController.h"
#import "YDContactsModel.h"
#import "YDNewFriendController.h"


@implementation YDContactsViewController (Delegate)
#pragma mark - Public Methods -
- (void)registerCellClass
{
    [self.tableView registerClass:[YDContactsCell class] forCellReuseIdentifier:@"YDContactsCell"];
}

#pragma mark -  YDContactsTableViewDelegate
//点击头部视图
- (void)contactsTableView:(YDContactsTableView *)tableView touchedIndex:(NSInteger )index{
    
    [self.navigationController pushViewController:[YDNewFriendController new] animated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data objectAtIndex:section] count];
}
//组标题数据源
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.headers;
}
//组眉
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.headers objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YDContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDContactsCell"];
    
    YDFriendModel *model = [[self.data objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.model = model;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, tableView.width, tableView.height) animated:NO];
        return -1;
    }
    return index;
}

#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14.5f]];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    }
    [label setText:[NSString stringWithFormat:@"  %@",self.headers[section]]];
    return label;
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDFriendModel *model = [[self.data objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    YDChatViewController *chatVC = [YDChatViewController new];
    
    chatVC.chatToUserId = model.friendid;
    chatVC.name = model.friendName?model.friendName:@"";
    chatVC.headerUrl = model.friendImage?model.friendImage:@"";
    chatVC.title = model.friendName;
    [self.navigationController pushViewController:chatVC animated:YES];
}

//实现左滑删除方法

//第一个参数：表格视图对象

//第二个参数：编辑表格的方式

//第三个参数：操作cell对应的位置

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    //如果是删除
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        //点击删除按钮调用这里的代码
        //        1.发送给服务器
        YDFriendModel *model = [[self.data objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        [YDNetworking postUrl:[kOriginalURL stringByAppendingString:@"delfriend"] parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token,@"f_ub_id":model.friendid} success:^(NSURLSessionDataTask *task, id responseObject) {
            [YDMBPTool showBriefAlert:[[responseObject mj_JSONObject] valueForKey:@"status"] time:1];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        //        2.删除数据库里对应好友
        if ([[YDFriendHelper sharedFriendHelper] deleteFriendByUid:model.friendid]) {
            NSLog(@"删除数据库好友成功");
        }else{
            NSLog(@"删除数据库好友失败");
        }
        NSNumber *friendCount = @(self.footerLabel.text.integerValue-1);
        self.footerLabel.text = [NSString stringWithFormat:@"%@",friendCount];
        
        //        3.数据源删除
        //        @[indexPath]=[NSArray arrayWithObjects:indexPath,nil];
        
        NSMutableArray*subArray= [self.data objectAtIndex:indexPath.section];
        
        [subArray removeObjectAtIndex:indexPath.row];
        
        //        4.UI上删除
        
        /*
         删除表视图的某个cell
         第一个参数：将要删除的所有的cell的indexPath组成的数组
         第二个参数：动画
         */
        if (subArray.count == 0) {
            [self.headers removeObjectAtIndex:indexPath.section];
            [self.data removeObjectAtIndex:indexPath.section];
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
        }else{
            [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
}

//修改删除按钮为中文的删除

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return@"删除";
}

//是否允许编辑行，默认是YES

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}


//MARK: UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.friendSearchVC setFriendsData:self.data];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //[self.tabBarController.tabBar setHidden:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //[self.tabBarController.tabBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


@end
