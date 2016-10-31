//
//  YDUserFriend.h
//  YuDao
//
//  Created by 汪杰 on 16/10/31.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDUserFriend : NSObject

@property (nonatomic, copy) NSString *friendID;
@property (nonatomic, copy) NSString *friendName;
@property (nonatomic, copy) NSString *lastMessageTime;
@property (nonatomic, copy) NSString *lastMessageType;
@property (nonatomic, copy) NSString *lastMessageContent;

- (instancetype)initWithID:(NSString *)ID name:(NSString *)name;

@end
