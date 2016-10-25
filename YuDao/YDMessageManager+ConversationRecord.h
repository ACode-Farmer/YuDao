//
//  YDMessageManager+ConversationRecord.h
//  YuDao
//
//  Created by 汪杰 on 16/10/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMessageManager.h"

@interface YDMessageManager (ConversationRecord)

- (BOOL)addConversationByMessage:(YDMessage *)message;

- (void)conversationRecord:(void (^)(NSArray *))complete;

- (BOOL)deleteConversationByPartnerID:(NSString *)partnerID;

@end
