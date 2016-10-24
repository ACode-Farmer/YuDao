//
//  YDChatBaseViewController+Proxy.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController+Proxy.h"
#import "YDChatBaseViewController+MessageDisplayView.h"
#import "YDChatMessageDisplayView.h"

@implementation YDChatBaseViewController (Proxy)

- (void)sendMessage:(YDMessage *)message
{
    
    message.ownerTyper = YDMessageOwnerTypeSelf;
    message.userID = [YDUserHelper sharedHelper].userID;
    message.fromUser = (id<YDChatUserProtocol>)[YDUserHelper sharedHelper].user;
    message.date = [NSDate date];
    
    if ([self.partner chat_userType] == YDChatUserTypeUser) {
        message.partnerType = YDPartnerTypeUser;
        message.friendID = [self.partner chat_userID];
    }
    else if ([self.partner chat_userType] == YDChatUserTypeGroup) {
        message.partnerType = YDPartnerTypeGroup;
        message.groupID = [self.partner chat_userID];
    }
    
    if (message.messageType != YDMessageTypeVoice) {
        [self addToShowMessage:message];    // 添加到列表
    }
    else {
        NSLog(@"sendMessage");
        [self.messageDisplayView updateMessage:message];
    }
    
//    [[TLMessageManager sharedInstance] sendMessage:message progress:^(TLMessage * message, CGFloat pregress) {
//        
//    } success:^(TLMessage * message) {
//        NSLog(@"send success");
//    } failure:^(TLMessage * message) {
//        NSLog(@"send failure");
//    }];
}

- (void)receivedMessage:(YDMessage *)message
{
   
}
@end
