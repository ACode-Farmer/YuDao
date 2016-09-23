//
//  KeyBoard.m
//  YuDao
//
//  Created by 汪杰 on 16/9/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "KeyBoard.h"

static UIView *view;

@implementation KeyBoard

- (void)registerNotification:(UIView *)VC_view{
    //KeyBoard *keyB = [self new];
    view = VC_view;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    //[view addGestureRecognizer:tap];
}

- (void)keyboardDidShow:(NSNotification *)noti{
    CGRect keyboardRect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    double duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = view.frame;
    frame.origin.y -= keyboardRect.size.height;
    [UIView animateWithDuration:duration animations:^{
        view.frame = frame;
    }];
    NSLog(@"height = %f",keyboardRect.size.height);
    NSLog(@"view.y = %f",view.frame.origin.y);
}

- (void)keyboardDidHidden:(NSNotification *)noti{
    CGRect frame = view.frame;
    frame.origin.y = 0;
    view.frame = frame;
    NSLog(@"view.y = %f",view.frame.origin.y);
}

- (void)hiddenKeyboard{
    for (id subview in view.subviews) {
        if ([subview isKindOfClass:[UITextField class]] || [subview isKindOfClass:[UITextView class]]) {
            UITextField *text = (UITextField *)NSURLIsDirectoryKey;
            [text resignFirstResponder];
        }
    }
}

- (void)dealloc{

}

@end
