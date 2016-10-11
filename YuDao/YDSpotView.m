//
//  YDSpotView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDSpotView.h"

@implementation YDSpotView
{
    UIView *_leftView;
    UIButton *_rightBtn;
}
- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        _leftView = [UIView new];
        _leftView.backgroundColor = [UIColor blueColor];
        _rightBtn = [UIButton new];
        [_rightBtn setTitle:title forState:0];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:0];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self sd_addSubviews:@[_leftView,_rightBtn]];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _leftView.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self,11*widthHeight_ratio)
    .widthIs(11*widthHeight_ratio)
    .heightEqualToWidth();
    _leftView.sd_cornerRadiusFromWidthRatio = @0.5;
    
    _rightBtn.sd_layout
    .centerYEqualToView(_leftView)
    .leftSpaceToView(_leftView,2)
    .rightSpaceToView(self,0)
    .heightRatioToView(self,1);
}

- (void)rightBtnAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(spotViewWithTitle:)]) {
        [self.delegate spotViewWithTitle:sender.titleLabel.text];
    }
}

@end
