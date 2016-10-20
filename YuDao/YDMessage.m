//
//  YDMessage.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMessage.h"

@implementation YDMessage

+ (YDMessage *)createMessageByType:(YDMessageType)type{
    NSString *className;
    if (type == YDMessageTypeText) {
        className = @"YDTextMessage";
    }
    else if (type == YDMessageTypeImage) {
        className = @"YDImageMessage";
    }
    else if (type == YDMessageTypeExpression) {
        className = @"YDExpressionMessage";
    }
    else if (type == YDMessageTypeVoice) {
        className = @"YDVoiceMessage";
    }
    if (className) {
        return [[NSClassFromString(className) alloc] init];
    }
    return nil;
}

- (instancetype)init{
    if (self = [super init]) {
        self.messageID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
    }
    return self;
}

- (void)resetMessageFrame
{
    kMessageFrame = nil;
}

#pragma mark -  Getter
- (NSMutableDictionary *)content
{
    if (_content == nil) {
        _content = [[NSMutableDictionary alloc] init];
    }
    return _content;
}

@end
