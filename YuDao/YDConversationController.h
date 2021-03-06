//
//  YDConversationController.h
//  YuDao
//
//  Created by 汪杰 on 17/2/13.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"
#import "YDConversation.h"
#import "YDChatViewController.h"

@interface YDConversationController : YDTableViewController

@property (nonatomic, strong) NSMutableArray<YDConversation *> *data;

//刷新消息列表
- (void)updateConversationData;

@end
