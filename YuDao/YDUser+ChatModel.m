//
//  YDUser+ChatModel.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDUser+ChatModel.h"

@implementation YDUser (ChatModel)

- (NSString *)chat_userID
{
    return self.userID;
}

- (NSString *)chat_username
{
    return self.showName;
}

- (NSString *)chat_avatarURL
{
    return self.avatarURL;
}

- (NSString *)chat_avatarPath
{
    return self.avatarPath;
}

- (NSInteger)chat_userType
{
    return YDChatUserTypeUser;
}

@end
