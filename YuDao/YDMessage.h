//
//  YDMessage.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDMessageFrame.h"
#import "YDChatUserProtocol.h"
/**
 *  消息所有者类型
 */
typedef NS_ENUM(NSInteger, YDPartnerType){
    YDPartnerTypeUser,          // 用户
    YDPartnerTypeGroup,         // 群聊
};

/**
 *  消息拥有者
 */
typedef NS_ENUM(NSInteger, YDMessageOwnerType){
    YDMessageOwnerTypeUnknown,  // 未知的消息拥有者
    YDMessageOwnerTypeSystem,   // 系统消息
    YDMessageOwnerTypeSelf,     // 自己发送的消息
    YDMessageOwnerTypeFriend,   // 接收到的他人消息
};

/**
 *  消息发送状态
 */
typedef NS_ENUM(NSInteger, YDMessageSendState){
    YDMessageSendSuccess,       // 消息发送成功
    YDMessageSendFail,          // 消息发送失败
};

/**
 *  消息读取状态
 */
typedef NS_ENUM(NSInteger, YDMessageReadState) {
    YDMessageUnRead,            // 消息未读
    YDMessageReaded,            // 消息已读
};

@interface YDMessage : NSObject
{
    YDMessageFrame *kMessageFrame;
}

@property (nonatomic, strong) NSString *messageID;                  // 消息ID
@property (nonatomic, strong) NSString *userID;                     // 发送者ID
@property (nonatomic, strong) NSString *friendID;                   // 接收者ID
@property (nonatomic, strong) NSString *groupID;                    // 讨论组ID（无则为nil）

@property (nonatomic, strong) NSDate *date;                         // 发送时间

@property (nonatomic, strong) id<YDChatUserProtocol> fromUser;      // 发送者

@property (nonatomic, assign) BOOL showTime;
@property (nonatomic, assign) BOOL showName;

@property (nonatomic, assign) YDPartnerType partnerType;            // 对方类型
@property (nonatomic, assign) YDMessageType messageType;            // 消息类型
@property (nonatomic, assign) YDMessageOwnerType ownerTyper;        // 发送者类型
@property (nonatomic, assign) YDMessageReadState readState;         // 读取状态
@property (nonatomic, assign) YDMessageSendState sendState;         // 发送状态

@property (nonatomic, strong) NSMutableDictionary *content;         //消息内容

@property (nonatomic, strong, readonly) YDMessageFrame *messageFrame;         // 消息frame

/**
 *  根据相应的消息类型创建消息对象
 *
 *  @param type 消息类型
 *
 *  @return 消息对象
 */
+ (YDMessage *)createMessageByType:(YDMessageType)type;

/**
 *  重置消息区域
 */
- (void)resetMessageFrame;

@end
