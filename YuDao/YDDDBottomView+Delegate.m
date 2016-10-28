//
//  YDDDBottomView+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/10/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDBottomView+Delegate.h"

@implementation YDDDBottomView (Delegate)

#pragma mark - Delegate -
//MARK: UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self sendCurrentText];
        return NO;
    }
    else if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
        if ([textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    [self y_reloadTextViewWithAnimation:YES];
                    return NO;
                }
                else if (c == ']') {
                    return YES;
                }
            }
        }
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self y_reloadTextViewWithAnimation:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self y_reloadTextViewWithAnimation:YES];
}
#pragma mark - Private Methods
- (void)y_reloadTextViewWithAnimation:(BOOL)animation
{
    CGFloat textHeight = [self.textView sizeThatFits:CGSizeMake(self.textView.width, MAXFLOAT)].height;
    CGFloat height = textHeight > HEIGHT_CHATBAR_TEXTVIEW ? textHeight : HEIGHT_CHATBAR_TEXTVIEW;
    height = (textHeight <= HEIGHT_MAX_CHATBAR_TEXTVIEW ? textHeight : HEIGHT_MAX_CHATBAR_TEXTVIEW);
    [self.textView setScrollEnabled:textHeight > height];
    if (height != self.textView.height) {
        if (animation) {
            [UIView animateWithDuration:0.2 animations:^{
                self.textView.sd_layout.heightIs(height);
//                if (self.superview) {
//                    [self.superview layoutIfNeeded];
//                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(ddBottomView:didChangeTextViewHeight:)]) {
                    [self.delegate ddBottomView:self didChangeTextViewHeight:self.textView.height];
                }
            } completion:^(BOOL finished) {
                if (textHeight > height) {
                    [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(ddBottomView:didChangeTextViewHeight:)]) {
                    [self.delegate ddBottomView:self didChangeTextViewHeight:height];
                }
            }];
        }
        else {
            self.textView.sd_layout.heightIs(height);
            if (self.superview) {
                [self.superview layoutIfNeeded];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(ddBottomView:didChangeTextViewHeight:)]) {
                [self.delegate ddBottomView:self didChangeTextViewHeight:height];
            }
            if (textHeight > height) {
                [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
            }
        }
    }
    else if (textHeight > height) {
        if (animation) {
            CGFloat offsetY = self.textView.contentSize.height - self.textView.height;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.textView setContentOffset:CGPointMake(0, offsetY) animated:YES];
            });
        }
        else {
            [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height - self.textView.height) animated:NO];
        }
    }
}
@end
