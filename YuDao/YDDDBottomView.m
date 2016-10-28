//
//  YDDDBottomView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDBottomView.h"
#import "YDDDBottomView+Delegate.h"

@implementation YDDDBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self sd_addSubviews:@[self.textView,self.commentBtn]];
        [self y_layoutSubviews];
    }
    return self;
}

- (void)y_layoutSubviews{
    
    self.commentBtn.sd_layout
    .bottomSpaceToView(self,10)
    .rightSpaceToView(self,10)
    .heightIs(40)
    .widthIs(60);
    
    self.textView.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,10)
    .rightSpaceToView(self.commentBtn,10)
    .bottomEqualToView(self.commentBtn);
}

//MARK: Event
- (void)clickedCommentButton:(UIButton *)sender{
    [self sendCurrentText];
}

- (void)sendCurrentText{
    if ([self.textView.text isEqualToString:@""]) {
        return;
    }
    if (self.delegate) {
        [self.delegate ddBottomView:self commentContent:self.textView.text];
        self.textView.text = @"";
//        self.textView.sd_layout.heightIs(self.commentBtn.height);
//        [self.textView updateLayout];
    }
}

#pragma mark - Getter
- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_textView.layer setBorderColor:[UIColor colorWithWhite:0.0 alpha:0.3].CGColor];
        [_textView.layer setCornerRadius:4.0f];
        [_textView setDelegate:self];
        [_textView setScrollsToTop:NO];
        
    }
    return _textView;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton new];
        [_commentBtn setTitle:@"评论" forState:0];
        [_commentBtn setTitleColor:[UIColor colorTextGray] forState:0];
        _commentBtn.layer.borderWidth = 1.0;
        _commentBtn.layer.borderColor = [UIColor colorTextGray].CGColor;
        [_commentBtn addTarget:self action:@selector(clickedCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

@end
