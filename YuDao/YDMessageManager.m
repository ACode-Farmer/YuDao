//
//  YDMessageManager.m
//  YuDao
//
//  Created by 汪杰 on 16/10/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMessageManager.h"
#import "YDMessageManager+ConversationRecord.h"
static YDMessageManager *messageManager;
@implementation YDMessageManager

+ (YDMessageManager *)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        messageManager = [[YDMessageManager alloc] init];
    });
    return messageManager;
}

- (void)sendMessage:(YDMessage *)message
           progress:(void (^)(YDMessage *, CGFloat))progress
            success:(void (^)(YDMessage *))success
            failure:(void (^)(YDMessage *))failure{
    BOOL ok = [self.messageStore addMessage:message];
    if (!ok) {
        NSLog(@"存储Message到DB失败");
    }
    else {      // 存储到conversation
        ok = [self addConversationByMessage:message];
        if (!ok) {
            NSLog(@"存储Conversation到DB失败");
        }
    }
}


#pragma mark - Getter -
- (YDDBMessageStore *)messageStore
{
    if (_messageStore == nil) {
        _messageStore = [[YDDBMessageStore alloc] init];
    }
    return _messageStore;
}

- (NSString *)userID
{
    return [YDUserHelper sharedHelper].userID;
}

@end