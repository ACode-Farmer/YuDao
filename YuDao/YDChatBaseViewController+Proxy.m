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
#import "YDXMPPManager.h"

@implementation YDChatBaseViewController (Proxy)

- (void)sendMessage:(YDMessage *)message
{
    switch (message.messageType) {
        case YDMessageTypeText:
        {
            YDTextMessage *textMessage = (YDTextMessage *)message;
            [self sendTextMassageTo:self.chatToJid message:textMessage.text];
            break;}
        case YDMessageTypeImage:
        {
            YDImageMessage *imageMessage = (YDImageMessage *)message;
            
            [self sendImageMessageTo:self.chatToJid message:[UIImage imageNamed:imageMessage.imagePath]];
            break;}
        case YDMessageTypeVoice:
        {
            
            break;}
        case YDMessageTypePosition:
        {
            
            break;}
        default:
            break;
    }
   
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

- (void)sendTextMassageTo:(XMPPJID *)toJid message:(NSString *)textMessage{
    //创建一个消息对象，并且指明接收者
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.chatToJid];
    //设置消息内容
    [message addBody:textMessage];
    //发送消息
    [[YDXMPPManager defaultManager].stream sendElement:message];
    //发送成功或者失败，有两种对应的代理方法}
}

- (void)sendImageMessageTo:(XMPPJID *)toJid message:(UIImage *)image{
    NSData *data = UIImagePNGRepresentation(image);
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.chatToJid];
    NSString *base64Str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    XMPPElement *attachment = [XMPPElement elementWithName:@"attachment" stringValue:base64Str];
    [message addChild:attachment];
    [[YDXMPPManager defaultManager].stream sendElement:message];
}

#pragma mark - XMPPStreamDelegate
//消息发送成功
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message{
    NSLog(@"消息发送成功");
}
//消息发送失败
- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error{
    NSLog(@"消息发送失败");
}
//接受消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSLog(@"接受消息");
    [self reloadMessage];
    
}
#pragma mark 刷新消息的方法
-(void)reloadMessage{
    //得到上下文
    NSManagedObjectContext *context = [YDXMPPManager defaultManager].messageArchivingContext;
    //搜索对象
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //创建一个实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:context];
    [request setEntity:entity];
    //查询条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[YDXMPPManager defaultManager].stream.myJID.bare,self.chatToJid.bare];
    request.predicate = pre;
    //排序方式
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[sort];
    //执行查询
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
//    if (self.messages.count != 0) {
//        [self.messages removeAllObjects];
//    }
//    [self.messages addObjectsFromArray:array];
//    [self.tableView reloadData];
    
    for (XMPPMessageArchiving_Message_CoreDataObject *message in array) {
        if (![message.message.to.user isEqual:self.chatToJid.user]  && ![message.body isEqualToString:@""]) {
            YDTextMessage *textMessage = (YDTextMessage *)[YDMessage createMessageByType:YDMessageTypeText];
            textMessage.text = message.body;
            textMessage.date = message.timestamp;
            textMessage.ownerTyper = YDMessageOwnerTypeFriend;
            [self receivedMessage:textMessage];
            NSLog(@"toName = %@",message.message.to.user);
        }
    }
    
}


- (void)receivedMessage:(YDMessage *)message
{
    message.userID = [YDUserHelper sharedHelper].userID;
    if ([self.partner chat_userType] == YDChatUserTypeUser) {
        message.partnerType = YDPartnerTypeUser;
        message.friendID = [self.partner chat_userID];
    }
    else if ([self.partner chat_userType] == YDChatUserTypeGroup) {
        message.partnerType = YDPartnerTypeGroup;
        message.groupID = [self.partner chat_userID];
    }
    message.ownerTyper = YDMessageOwnerTypeFriend;
    message.date = [NSDate date];
    [self addToShowMessage:message];    // 添加到列表
}
@end
