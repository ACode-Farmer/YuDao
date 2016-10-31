//
//  YDFriendsViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/31.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDFriendsViewController.h"
#import "YDXMPPManager.h"
#import "YDChatViewController.h"
@interface YDFriendsViewController ()<XMPPRosterDelegate>

@end

@implementation YDFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[YDXMPPManager defaultManager] loginwithName:@"wangjie" andPassword:@"yulian"];
    [[YDXMPPManager defaultManager].roster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Events
- (void)addFriend:(UIBarButtonItem *)sender{
    XMPPJID *jid = [XMPPJID jidWithUser:@"张三" domain:@"yulian" resource:@"iphone5s"];
    [[YDXMPPManager defaultManager].roster subscribePresenceToUser:jid];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rosterJids? self.rosterJids.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kFriendsCellID = @"kFriendsCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFriendsCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kFriendsCellID];
    }
    XMPPJID *jid = self.rosterJids[indexPath.row];
    cell.textLabel.text = jid.user;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XMPPJID *jid = self.rosterJids[indexPath.row];
    YDChatViewController *chatVC = [YDChatViewController new];
    chatVC.chatToJid = jid;
    [self.navigationController firstLevel_push_fromViewController:self toVC:chatVC];
}

#pragma mark 开始检索好友列表的方法
-(void)xmppRosterDidBeginPopulating:(XMPPRoster *)sender{
    NSLog(@"开始检索好友列表");
}
#pragma mark 正在检索好友列表的方法
- (void)xmppRoster:(XMPPRoster *)sender didReceiveRosterItem:(NSXMLElement *)item{
    //获得item的属性里的jid字符串，再通过它获得jid对象
    NSString *jidStr = [[item attributeForName:@"jid"] stringValue];
    XMPPJID *jid = [XMPPJID jidWithString:jidStr];
    //是否已经添加
    if ([self.rosterJids containsObject:jid]) {
        return;
    }
    //将好友添加到数组中去
    [self.rosterJids addObject:jid];
    //添加完数据要更新UI（表视图更新）
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.rosterJids.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark 好友列表检索完毕的方法
-(void)xmppRosterDidEndPopulating:(XMPPRoster *)sender{
    
    NSLog(@"xxxxx好友列表检索完毕");
}
#pragma mark 删除好友执行的方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //找到要删除的人
        XMPPJID *jid = self.rosterJids[indexPath.row];
        //从数组中删除
        [self.rosterJids removeObjectAtIndex:indexPath.row];
        //从Ui单元格删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic         ];
        //从服务器删除
        [[YDXMPPManager defaultManager].roster removeUser:jid];
    }
}

#pragma mark - Getter
- (NSMutableArray *)rosterJids{
    if (_rosterJids == nil) {
        _rosterJids = [NSMutableArray array];
    }
    return _rosterJids;
}

@end
