//
//  YDExpressionMessage.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMessage.h"
#import "YDEmoji.h"

@interface YDExpressionMessage : YDMessage

@property (nonatomic, strong) YDEmoji *emoji;

@property (nonatomic, strong, readonly) NSString *path;

@property (nonatomic, strong, readonly) NSString *url;

@property (nonatomic, assign, readonly) CGSize emojiSize;

@end
