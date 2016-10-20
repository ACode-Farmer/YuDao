//
//  YDChatUserProtocol.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YDChatUserType) {
    YDChatUserTypeUser = 0,
    YDChatUserTypeGroup,
};

@protocol YDChatUserProtocol <NSObject>

@property (nonatomic, strong, readonly) NSString *chat_userID;

@property (nonatomic, strong, readonly) NSString *chat_username;

@property (nonatomic, strong, readonly) NSString *chat_avatarURL;

@property (nonatomic, strong, readonly) NSString *chat_avatarPath;

@property (nonatomic, assign, readonly) NSInteger chat_userType;

@optional;

- (id)groupMemberByID:(NSString *)userID;

- (NSArray *)groupMembers;

@end
