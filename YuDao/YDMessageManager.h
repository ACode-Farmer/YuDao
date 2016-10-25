//
//  YDMessageManager.h
//  YuDao
//
//  Created by 汪杰 on 16/10/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDMessage.h"
#import "YDDBMessageStore.h"

@interface YDMessageManager : NSObject

@property (nonatomic, strong, readonly) NSString *userID;

@property (nonatomic, strong) YDDBMessageStore *messageStore;

+ (YDMessageManager *)sharedInstance;

#pragma mark - 发送
- (void)sendMessage:(YDMessage *)message
           progress:(void (^)(YDMessage *, CGFloat))progress
            success:(void (^)(YDMessage *))success
            failure:(void (^)(YDMessage *))failure;
@end
