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

#pragma mark - # Getter
- (UIBarButtonItem *)rightBarButton
{
    if (_rightBarButton == nil) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    }
    return _rightBarButton;
}

@end
