//
//  YDChatBaseViewController+ChatBar.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController.h"
#import "YDMoreKeyboard.h"
#import "YDChatBaseViewController+Proxy.h"
@interface YDChatBaseViewController (ChatBar)<YDChatBarDelegate,YDKeyboardDelegate,YDMoreKeyboardDelegate>


//更多键盘
@property (nonatomic, strong, readonly) YDMoreKeyboard *moreKeyboard;

- (void)loadKeyboard;
- (void)dismissKeyboard;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardFrameWillChange:(NSNotification *)notification;

@end
