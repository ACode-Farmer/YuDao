//
//  YDUserHelper.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDUserHelper.h"

static YDUserHelper *helper;

@implementation YDUserHelper

+ (YDUserHelper *) sharedHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[YDUserHelper alloc] init];
    });
    return helper;
}

- (NSString *)userID
{
    return self.user.userID;
}

- (id) init
{
    if (self = [super init]) {
        self.user = [[YDUser alloc] init];
        self.user.userID = @"1000";
        self.user.avatarURL = @"http://p1.qq181.com/cms/120506/2012050623111097826.jpg";
        self.user.nikeName = @"李伯坤";
        self.user.username = @"li-bokun";
//        self.user.detailInfo.qqNumber = @"1159197873";
//        self.user.detailInfo.email = @"libokun@126.com";
//        self.user.detailInfo.location = @"山东 滨州";
//        self.user.detailInfo.sex = @"男";
//        self.user.detailInfo.motto = @"Hello world!";
//        self.user.detailInfo.momentsWallURL = @"http://img06.tooopen.com/images/20160913/tooopen_sy_178786212749.jpg";
    }
    return self;
}


@end
