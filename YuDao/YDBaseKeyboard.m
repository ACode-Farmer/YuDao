//
//  TLBaseKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/8/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "YDBaseKeyboard.h"

@implementation YDBaseKeyboard

#pragma mark - # Public Methods
- (void)showWithAnimation:(BOOL)animation
{
    [self showInView:[UIApplication sharedApplication].keyWindow withAnimation:animation];
}

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation
{
    if (_isShow) {
        return;
    }
    _isShow = YES;
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillShow:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillShow:self animated:animation];
    }
    [view addSubview:self];
    CGFloat keyboardHeight = HEIGHT_CHAT_KEYBOARD;
    
    self.sd_layout
    .leftSpaceToView(view,0)
    .rightSpaceToView(view,0)
    .heightIs(keyboardHeight)
    .bottomSpaceToView(view,-keyboardHeight);
    [view layoutIfNeeded];
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sd_layout.bottomSpaceToView(view,0);
            [view layoutIfNeeded];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:keyboardHeight];
            }
        } completion:^(BOOL finished) {
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
                NSLog(@"x=%f,y=%f,w=%f,h=%f",self.origin.x,self.origin.y,self.size.width,self.size.height);
            }
        }];
    }
    else {
        self.sd_layout.bottomSpaceToView(view,0);
        [view layoutIfNeeded];
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:animated:)]) {
            [self.keyboardDelegate chatKeyboardDidShow:self animated:animation];
        }
    }
}

- (void)dismissWithAnimation:(BOOL)animation
{
    if (!_isShow) {
        if (!animation) {
            [self removeFromSuperview];
        }
        return;
    }
    _isShow = NO;
    if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardWillDismiss:animated:)]) {
        [self.keyboardDelegate chatKeyboardWillDismiss:self animated:animation];
    }
    if (animation) {
        CGFloat keyboardHeight = [self keyboardHeight];
        [UIView animateWithDuration:0.3 animations:^{
            self.sd_layout.bottomSpaceToView(self.superview,-keyboardHeight);
            [self.superview layoutIfNeeded];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [self.keyboardDelegate chatKeyboard:self didChangeHeight:self.superview.height - self.y];
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
                [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
            }
        }];
    }
    else {
        [self removeFromSuperview];
        if (self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:animated:)]) {
            [self.keyboardDelegate chatKeyboardDidDismiss:self animated:animation];
        }
    }
}

- (void)reset
{
    
}

#pragma mark - # ZZKeyboardProtocol
- (CGFloat)keyboardHeight
{
    return HEIGHT_CHAT_KEYBOARD;
}


@end
