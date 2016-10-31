//
//  YDUserFriend.m
//  YuDao
//
//  Created by 汪杰 on 16/10/31.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDUserFriend.h"

@implementation YDUserFriend
- (instancetype)initWithID:(NSString *)ID name:(NSString *)name{
    if (self = [super init]) {
        self.friendID = ID;
        self.friendName = name;
    }
    return self;
}
@end
