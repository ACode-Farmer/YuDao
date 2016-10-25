//
//  YDDBManager.m
//  YuDao
//
//  Created by 汪杰 on 16/10/25.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDBManager.h"

static YDDBManager *manager;

@implementation YDDBManager

+ (YDDBManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSString *userID = [YDUserHelper sharedHelper].userID;
        manager = [[YDDBManager alloc] initWithUserID:userID];
    });
    return manager;
}

- (id)initWithUserID:(NSString *)userID
{
    if (self = [super init]) {
        NSString *commonQueuePath = [NSFileManager pathDBCommon];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
        NSString *messageQueuePath = [NSFileManager pathDBMessage];
        self.messageQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
    }
    return self;
}

- (id)init
{
    NSLog(@"TLDBManager：请使用 initWithUserID: 方法初始化");
    return nil;
}

@end
