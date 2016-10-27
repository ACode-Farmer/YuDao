//
//  YDTextMessage.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTextMessage.h"

#define     MSG_SPACE_TOP       14
#define     MSG_SPACE_BTM       20

static UILabel *textLabel = nil;
@implementation YDTextMessage

@synthesize text = _text;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:YDMessageTypeText];
        if (textLabel == nil) {
            textLabel = [[UILabel alloc] init];
            [textLabel setFont:[UIFont fontTextMessageText]];
            [textLabel setNumberOfLines:0];
        }
    }
    return self;
}

- (NSString *)text
{
    if (_text == nil) {
        _text = [self.content objectForKey:@"text"];
    }
    return _text;
}
- (void)setText:(NSString *)text
{
    _text = text;
    [self.content setObject:text forKey:@"text"];
}

- (NSAttributedString *)attrText
{
    if (_attrText == nil) {
        //_attrText = [self.text toMessageString];
        _attrText = (NSAttributedString *)self.text;
    }
    return _attrText;
}

- (YDMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[YDMessageFrame alloc] init];
        kMessageFrame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0) + 20;
        textLabel.text = self.text;
        kMessageFrame.contentSize = [textLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
        NSLog(@"wwwww = %f",kMessageFrame.contentSize.width);
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
}

- (NSString *)conversationContent
{
    return self.text;
}

- (NSString *)messageCopy
{
    return self.text;
}

@end
