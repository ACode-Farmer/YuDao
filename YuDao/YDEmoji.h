//
//  YDEmoji.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDEmoji : NSObject

@property (nonatomic, assign) YDEmojiType type;

@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSString *emojiID;

@property (nonatomic, strong) NSString *emojiName;

@property (nonatomic, strong) NSString *emojiPath;

@property (nonatomic, strong) NSString *emojiURL;

@property (nonatomic, assign) CGFloat size;

@end
