//
//  YDDDBottomView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDBottomView.h"

@implementation YDDDBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self sd_addSubviews:@[self.textF,self.commentBtn]];
        [self y_layoutSubviews];
    }
    return self;
}

- (void)y_layoutSubviews{
    
    self.commentBtn.sd_layout
    .topSpaceToView(self,10)
    .rightSpaceToView(self,10)
    .heightIs(40)
    .widthIs(60);
    
    self.textF.sd_layout
    .topEqualToView(self.commentBtn)
    .leftSpaceToView(self,10)
    .rightSpaceToView(self.commentBtn,10)
    .bottomEqualToView(self.commentBtn);
}

#pragma mark - Getter
- (UITextField *)textF{
    if (_textF == nil) {
        _textF = [UITextField new];
    }
    return _textF;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton new];
        [_commentBtn setTitle:@"评论" forState:0];
        [_commentBtn setTitleColor:[UIColor colorTextGray] forState:0];
        _commentBtn.layer.borderWidth = 1.0;
        _commentBtn.layer.borderColor = [UIColor colorTextGray].CGColor;
    }
    return _commentBtn;
}

@end
