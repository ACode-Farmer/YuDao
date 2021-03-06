//
//  InterestView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "InterestView.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "UIView+Extnesion.h"

#define margin 15.f

@implementation InterestView

-(void)addItems:(NSArray<NSString*> *)items{
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10, 10, 100, 21);
    label.text = [items firstObject];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    
    NSInteger row = 0;
    CGFloat btnYW = 0;
    for (NSInteger i = 0; i<items.count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:items[i] forState:0];
        btn.backgroundColor = [UIColor whiteColor];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize strsize = [items[i] sizeWithAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0] }];
        btn.width = strsize.width +     margin;
        btn.height = strsize.height+ margin;
        btn.layer.cornerRadius = btn.height/2;
        btn.layer.borderWidth = 1.f;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.clipsToBounds = YES;
        if (i == 0) {
            btn.x = margin;
            btnYW += CGRectGetMaxX(btn.frame);
        }else{
            btnYW += CGRectGetMaxX(btn.frame)+margin;
            if (btnYW > screen_width) {
                row++;
                btn.x = margin;
                btnYW = CGRectGetMaxX(btn.frame);
            }
            else{
                btn.x += btnYW - btn.width;
            }
        }
        btn.y += row * (btn.height + margin) + margin + label.height + 8;
        [self addSubview:btn];
        if (i == items.count - 1) {
            [self setupAutoHeightWithBottomView:btn bottomMargin:margin];
        }
    }
}

- (void)addItems:(NSArray *)items title:(NSString *)title{
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10, 10, 100, 21);
    label.text = title;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    
    NSInteger row = 0;
    CGFloat btnYW = 0;
    for (NSInteger i = 0; i<items.count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:items[i] forState:0];
        btn.backgroundColor = [UIColor whiteColor];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize strsize = [items[i] sizeWithAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0] }];
        btn.width = strsize.width +     margin;
        btn.height = strsize.height+ margin;
        btn.layer.cornerRadius = btn.height/4;
        btn.layer.borderWidth = 1.f;
        btn.layer.borderColor = [UIColor colorGrayLine].CGColor;
        btn.clipsToBounds = YES;
        if (i == 0) {
            btn.x = margin;
            btnYW += CGRectGetMaxX(btn.frame);
        }else{
            btnYW += CGRectGetMaxX(btn.frame)+margin;
            if (btnYW > screen_width) {
                row++;
                btn.x = margin;
                btnYW = CGRectGetMaxX(btn.frame);
            }
            else{
                btn.x += btnYW - btn.width;
            }
        }
        btn.y += row * (btn.height + margin) + margin + label.height + 8;
        [self addSubview:btn];
        if (i == items.count - 1) {
            [self setupAutoHeightWithBottomView:btn bottomMargin:margin];
        }
    }
}

- (void)addItemsToCell:(NSArray *)items{
    NSInteger row = 0;
    CGFloat btnYW = 0;
    for (NSInteger i = 0; i<items.count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:items[i] forState:0];
        btn.backgroundColor = [UIColor orangeColor];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        
        CGSize strsize = [@"同城出游" sizeWithAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0] }];
        btn.width = strsize.width;
        btn.height = strsize.height+ margin;
        btn.layer.cornerRadius = btn.height/4;
        btn.clipsToBounds = YES;
        if (i == 0) {
            btn.x = margin;
            btnYW += CGRectGetMaxX(btn.frame);
        }else{
            btnYW += CGRectGetMaxX(btn.frame)+margin;
            if (btnYW > screen_width) {
                row++;
                btn.x = margin;
                btnYW = CGRectGetMaxX(btn.frame);
            }
            else{
                btn.x += btnYW - btn.width;
            }
        }
        btn.y += row * (btn.height + 7)+7;
        [self addSubview:btn];
        if (i == items.count - 1) {
            [self setupAutoHeightWithBottomView:btn bottomMargin:margin];
        }
    }
}

- (void)addSearchItems:(NSArray *)items{
    NSInteger row = 0;
    CGFloat btnYW = 0;
    for (NSInteger i = 0; i<items.count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:items[i] forState:0];
        btn.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize strsize = [@"同城出游" sizeWithAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0] }];
        btn.width = strsize.width;
        btn.height = strsize.height+ margin;
        btn.layer.cornerRadius = btn.height/3;
        btn.clipsToBounds = YES;
        if (i == 0) {
            btn.x = 0;
            btnYW += CGRectGetMaxX(btn.frame);
        }else{
            btnYW += CGRectGetMaxX(btn.frame)+margin;
            if (btnYW > screen_width-20) {
                row++;
                btn.x = 0;
                btnYW = CGRectGetMaxX(btn.frame);
            }
            else{
                btn.x += btnYW - btn.width;
            }
        }
        btn.y += row * (btn.height + margin);
        [self addSubview:btn];
        if (i == items.count - 1) {
            [self setupAutoHeightWithBottomView:btn bottomMargin:margin];
        }
    }
}

- (void)btnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}


@end
