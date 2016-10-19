//
//  TLMoreKeyboardDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDMoreKeyboardItem.h"

@protocol YDMoreKeyboardDelegate <NSObject>

@optional

- (void) moreKeyboard:(id)keyboard didSelectedFunctionItem:(YDMoreKeyboardItem *)funcItem;

@end
