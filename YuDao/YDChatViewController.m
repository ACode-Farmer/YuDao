//
//  YDChatViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatViewController.h"

static YDChatViewController *chatVC;

@interface YDChatViewController ()

@property (nonatomic, strong) UIBarButtonItem *rightBarButton;

@end

@implementation YDChatViewController

+ (YDChatViewController *)sharedChatVC
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        chatVC = [[YDChatViewController alloc] init];
    });
    return chatVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationItem setRightBarButtonItem:self.rightBarButton];
    
    self.user = (id<YDChatUserProtocol>)[YDUserHelper sharedHelper].user;
//    self.moreKBhelper = [[TLMoreKBHelper alloc] init];
//    [self setChatMoreKeyboardData:self.moreKBhelper.chatMoreKeyboardData];
//    self.emojiKBHelper = [TLEmojiKBHelper sharedKBHelper];
//    TLWeakSelf(self);
//    [self.emojiKBHelper emojiGroupDataByUserID:[TLUserHelper sharedHelper].userID complete:^(NSMutableArray *emojiGroups) {
//        [weakself setChatEmojiKeyboardData:emojiGroups];
//    }];
}

#pragma mark - # Event Response
- (void)rightBarButtonDown:(UINavigationBar *)sender
{
//    if ([self.partner chat_userType] == TLChatUserTypeUser) {
//        TLChatDetailViewController *chatDetailVC = [[TLChatDetailViewController alloc] init];
//        [chatDetailVC setUser:(TLUser *)self.partner];
//        [self setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:chatDetailVC animated:YES];
//    }
//    else if ([self.partner chat_userType] == TLChatUserTypeGroup) {
//        TLChatGroupDetailViewController *chatGroupDetailVC = [[TLChatGroupDetailViewController alloc] init];
//        [chatGroupDetailVC setGroup:(TLGroup *)self.partner];
//        [self setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:chatGroupDetailVC animated:YES];
//    }
}
#pragma mark - # Getter
- (UIBarButtonItem *)rightBarButton
{
    if (_rightBarButton == nil) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    }
    return _rightBarButton;
}

@end
