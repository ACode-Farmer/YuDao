//
//  YDExpressionMessage.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDExpressionMessage.h"

@implementation YDExpressionMessage

@synthesize emoji = _emoji;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:YDMessageTypeExpression];
    }
    return self;
}

- (void)setEmoji:(YDEmoji *)emoji
{
    _emoji = emoji;
    [self.content setObject:emoji.groupID forKey:@"groupID"];
    [self.content setObject:emoji.emojiID forKey:@"emojiID"];
    CGSize imageSize = [UIImage imageNamed:self.path].size;
    [self.content setObject:[NSNumber numberWithDouble:imageSize.width] forKey:@"w"];
    [self.content setObject:[NSNumber numberWithDouble:imageSize.height] forKey:@"h"];
}
- (YDEmoji *)emoji
{
    if (_emoji == nil) {
        _emoji = [[YDEmoji alloc] init];
        _emoji.groupID = self.content[@"groupID"];
        _emoji.emojiID = self.content[@"emojiID"];
    }
    return _emoji;
}

- (NSString *)path
{
    return self.emoji.emojiPath;
}

- (NSString *)url
{
    return [YDHost expressionDownloadURLWithEid:self.emoji.emojiID];
}

- (CGSize)emojiSize
{
    CGFloat width = [self.content[@"w"] doubleValue];
    CGFloat height = [self.content[@"h"] doubleValue];
    return CGSizeMake(width, height);
}

#pragma mark -
- (YDMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[YDMessageFrame alloc] init];
        kMessageFrame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0);
        
        kMessageFrame.height += 5;
        
        CGSize emojiSize = self.emojiSize;
        if (CGSizeEqualToSize(emojiSize, CGSizeZero)) {
            kMessageFrame.contentSize = CGSizeMake(80, 80);
        }
        else if (emojiSize.width > emojiSize.height) {
            CGFloat height = MAX_MESSAGE_EXPRESSION_WIDTH * emojiSize.height / emojiSize.width;
            height = height < MIN_MESSAGE_EXPRESSION_WIDTH ? MIN_MESSAGE_EXPRESSION_WIDTH : height;
            kMessageFrame.contentSize = CGSizeMake(MAX_MESSAGE_EXPRESSION_WIDTH, height);
        }
        else {
            CGFloat width = MAX_MESSAGE_EXPRESSION_WIDTH * emojiSize.width / emojiSize.height;
            width = width < MIN_MESSAGE_EXPRESSION_WIDTH ? MIN_MESSAGE_EXPRESSION_WIDTH : width;
            kMessageFrame.contentSize = CGSizeMake(width, MAX_MESSAGE_EXPRESSION_WIDTH);
        }
        
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
}

- (NSString *)conversationContent
{
    return @"[表情]";
}


@end
