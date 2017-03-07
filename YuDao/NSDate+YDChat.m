//
//  NSDate+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "NSDate+YDChat.h"

@implementation NSDate (YDChat)

- (NSString *)chatTimeInfo
{
    if ([self isToday]) {       // 今天
        return self.formatHM;
    }
    else if ([self isYesterday]) {      // 昨天
        return [NSString stringWithFormat:@"昨天 %@", self.formatHM];
    }
    else if ([self isThisWeek]){        // 本周
        return [NSString stringWithFormat:@"%@ %@", self.dayFromWeekday, self.formatHM];
    }
    else {
        return [NSString stringWithFormat:@"%@ %@", self.formatYMD, self.formatHM];
    }
}

- (NSString *)conversaionTimeInfo
{
    if ([self isToday]) {
        NSLog(@"今天");// 今天
        return self.formatHM;
    }
    else if ([self isYesterday]) {
        NSLog(@"昨天");// 昨天
        return @"昨天";
    }
    else if ([self isThisWeek]){
        NSLog(@"本周");// 本周
        return self.dayFromWeekday;
    }
    else {
        NSLog(@"其他的日期");
        return [self formatYMDWith:@"/"];
    }
}

- (NSString *)chatFileTimeInfo
{
    if ([self isThisWeek]) {
        return @"本周";
    }
    else if ([self isThisMonth]) {
        return @"这个月";
    }
    else {
        return [NSString stringWithFormat:@"%ld年%ld月", (long)self.year, (long)self.month];
    }
}

@end
