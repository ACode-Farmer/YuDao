//
//  TLMoreKeyboardItem.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDMoreKeyboardItem : NSObject

@property (nonatomic, assign) YDMoreKeyboardItemType type;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *imagePath;

+ (YDMoreKeyboardItem *)createByType:(YDMoreKeyboardItemType)type title:(NSString *)title imagePath:(NSString *)imagePath;

@end
