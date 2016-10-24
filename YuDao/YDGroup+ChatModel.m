//
//  YDGroup+ChatModel.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGroup+ChatModel.h"

@implementation YDGroup (ChatModel)

- (NSString *)chat_userID
{
    return self.groupID;
}

- (NSString *)chat_username
{
    return self.groupName;
}

- (NSString *)chat_avatarURL
{
    return nil;
}

- (NSString *)chat_avatarPath
{
    return self.groupAvatarPath;
}

- (NSInteger)chat_userType
{
    return YDChatUserTypeGroup;
}

- (id)groupMemberByID:(NSString *)userID
{
    return [self memberByUserID:userID];
}

- (NSArray *)groupMembers
{
    return self.users;
}


@end
