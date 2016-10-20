//
//  YDEmoji.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDEmoji.h"

@implementation YDEmoji

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"emojiID" : @"pId",
             @"emojiURL" : @"Url",
             @"emojiName" : @"credentialName",
             @"emojiPath" : @"imageFile",
             @"size" : @"size",
             };
}

- (NSString *)emojiPath
{
    if (_emojiPath == nil) {
        NSString *groupPath = self.groupID;
        _emojiPath = [NSString stringWithFormat:@"%@%@", groupPath, self.emojiID];
    }
    return _emojiPath;
}

@end
