//
//  YDTextDisplayView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTextDisplayView.h"

#define     WIDTH_TEXTVIEW          self.width * 0.94

@interface YDTextDisplayView ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation YDTextDisplayView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.textView];
        self.textView.sd_layout.centerXEqualToView(self).centerYEqualToView(self);
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)showInView:(UIView *)view withAttrText:(NSAttributedString *)attrText animation:(BOOL)animation
{
    [view addSubview:self];
    [self setFrame:view.bounds];
    [self setAttrString:attrText];
    [self setAlpha:0];
    [UIView animateWithDuration:0.1 animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }];
}

- (void)setAttrString:(NSAttributedString *)attrString
{
    _attrString = attrString;
    NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithAttributedString:attrString];
    [mutableAttrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25.0f] range:NSMakeRange(0, attrString.length)];
    [self.textView setAttributedText:mutableAttrString];
    CGSize size = [self.textView sizeThatFits:CGSizeMake(WIDTH_TEXTVIEW, MAXFLOAT)];
    size.height = size.height > screen_height ? screen_height : size.height;
    self.textView.sd_layout.widthIs(size.width).heightIs(size.height);
}

- (void)dismiss
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Getter -
- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setBackgroundColor:[UIColor clearColor]];
        [_textView setTextAlignment:NSTextAlignmentCenter];
        [_textView setEditable:NO];
    }
    return _textView;
}


@end
