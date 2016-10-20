//
//  YDImageMessage.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDImageMessage.h"

@implementation YDImageMessage
@synthesize imagePath = _imagePath;
@synthesize imageURL = _imageURL;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:YDMessageTypeImage];
    }
    return self;
}

#pragma mark -
- (NSString *)imagePath
{
    if (_imagePath == nil) {
        _imagePath = [self.content objectForKey:@"path"];
    }
    return _imagePath;
}
- (void)setImagePath:(NSString *)imagePath
{
    _imagePath = imagePath;
    [self.content setObject:imagePath forKey:@"path"];
}

- (NSString *)imageURL
{
    if (_imageURL == nil) {
        _imageURL = [self.content objectForKey:@"url"];
    }
    return _imageURL;
}
- (void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
    [self.content setObject:imageURL forKey:@"url"];
}

- (CGSize)imageSize
{
    CGFloat width = [[self.content objectForKey:@"w"] doubleValue];
    CGFloat height = [[self.content objectForKey:@"h"] doubleValue];
    return CGSizeMake(width, height);
}
- (void)setImageSize:(CGSize)imageSize
{
    [self.content setObject:[NSNumber numberWithDouble:imageSize.width] forKey:@"w"];
    [self.content setObject:[NSNumber numberWithDouble:imageSize.height] forKey:@"h"];
}

#pragma mark -
- (YDMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[YDMessageFrame alloc] init];
        kMessageFrame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0);
        
        CGSize imageSize = self.imageSize;
        if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
            kMessageFrame.contentSize = CGSizeMake(100, 100);
        }
        else if (imageSize.width > imageSize.height) {
            CGFloat height = MAX_MESSAGE_IMAGE_WIDTH * imageSize.height / imageSize.width;
            height = height < MIN_MESSAGE_IMAGE_WIDTH ? MIN_MESSAGE_IMAGE_WIDTH : height;
            kMessageFrame.contentSize = CGSizeMake(MAX_MESSAGE_IMAGE_WIDTH, height);
        }
        else {
            CGFloat width = MAX_MESSAGE_IMAGE_WIDTH * imageSize.width / imageSize.height;
            width = width < MIN_MESSAGE_IMAGE_WIDTH ? MIN_MESSAGE_IMAGE_WIDTH : width;
            kMessageFrame.contentSize = CGSizeMake(width, MAX_MESSAGE_IMAGE_WIDTH);
        }
        
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
}

- (NSString *)conversationContent
{
    return @"[图片]";
}

- (NSString *)messageCopy
{
    //return [self.content mj_JSONString];
    return @"这里用了一个第三方框架";
}
@end
