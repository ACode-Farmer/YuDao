//
//  TLMoreKeyboardItem.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "YDMoreKeyboardItem.h"

@implementation YDMoreKeyboardItem


+ (YDMoreKeyboardItem *)createByType:(YDMoreKeyboardItemType)type title:(NSString *)title imagePath:(NSString *)imagePath
{
    YDMoreKeyboardItem *item = [[YDMoreKeyboardItem alloc] init];
    item.type = type;
    item.title = title;
    item.imagePath = imagePath;
    return item;
}

@end
