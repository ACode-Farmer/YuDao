//
//  YDRTypeView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDRTypeView.h"

@implementation YDRTypeView
{
    NSMutableArray *_buttons;
}
- (instancetype)initWithTitles:(NSArray *)titles{
    if (self = [super init]) {
        [self y_layoutSubviews:titles];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        [self y_layoutSubviews:titles];
    }
    return self;
}


- (void)y_layoutSubviews:(NSArray *)titles{
    _buttons = [NSMutableArray arrayWithCapacity:6];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton new];
        [button setTitle:obj forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont font_15]];
        button.tag = 1000+idx;
        button.frame = CGRectMake(idx * 47*widthHeight_ratio, 0, 47*widthHeight_ratio, self.bounds.size.height);
        [button addTarget:self action:@selector(typeButtonActon:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_buttons addObject:button];
        if (idx == 0) {
            button.selected = YES;
        }
    }];
}

- (void)setIndex:(NSUInteger)index{
    _index = index;
    [_buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        if (btn.tag-1000 == _index) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }];
}

#pragma mark Events
- (void)typeButtonActon:(UIButton *)sender{
    [self setIndex:sender.tag - 1000];
    if (self.delegate && [self.delegate respondsToSelector:@selector(typeViewWithButton:)]) {
        [self.delegate typeViewWithButton:sender];
    }
}


@end
