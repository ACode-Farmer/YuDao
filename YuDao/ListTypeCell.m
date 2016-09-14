//
//  ListTypeCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ListTypeCell.h"
#import "HomePageController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@implementation ListTypeCell
{
    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
    UIButton *_btn4;
    UIButton *_lastBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void) setupSubviews{
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn1 setTitle:@"滞留" forState:0];
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn2 setTitle:@"油耗" forState:0];
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn3 setTitle:@"里程" forState:0];
    _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn4 setTitle:@"时速" forState:0];
    
    NSArray *subviews = @[_btn1,_btn2,_btn3,_btn4];
    UIView *contentView = self.contentView;
    contentView.backgroundColor = [UIColor lightGrayColor];
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)obj;
            button.tag = idx;
            [button setTitleColor:[UIColor blackColor] forState:0];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
           
        }
        [contentView addSubview:obj];
    }];

    _btn1.sd_layout
    .centerYEqualToView(contentView)
    .widthIs(56)
    .heightIs(27)
    .leftSpaceToView(contentView,8);
    
    _btn2.sd_layout
    .centerYEqualToView(contentView)
    .widthIs(56)
    .heightIs(27)
    .leftSpaceToView(_btn1,8);
    
    _btn3.sd_layout
    .centerYEqualToView(contentView)
    .widthIs(56)
    .heightIs(27)
    .leftSpaceToView(_btn2,8);
    
    _btn4.sd_layout
    .centerYEqualToView(contentView)
    .widthIs(56)
    .heightIs(27)
    .leftSpaceToView(_btn3,8);
    
    _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_arrowBtn setImage:[UIImage imageNamed:@"bottomArrow"] forState:0];
    [_arrowBtn setImage:[UIImage imageNamed:@"topArrow"] forState:UIControlStateSelected];
    [_arrowBtn addTarget:self action:@selector(arrowBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _arrowBtn.backgroundColor = [UIColor clearColor];
    [contentView addSubview:_arrowBtn];
    _arrowBtn.sd_layout
    .centerYEqualToView(contentView)
    .rightSpaceToView(contentView,16)
    .widthIs(15)
    .heightIs(15);
}

- (void)typeButtonAction:(UIButton *)sender{
    if ([_lastBtn isEqual:sender]) {
        return;
    }else{
        _lastBtn.selected = !_lastBtn.selected;
    }
    sender.selected = !sender.selected;
    _lastBtn = sender;
}

- (void)arrowBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonsAction:button:)]) {
        [self.delegate buttonsAction:self button:sender];
    }
}

-(HomePageController *)getCurrentViewController{
    UIResponder *next = [[self superview] nextResponder];
    do {
        if ([next isKindOfClass:[HomePageController class]]) {
            return (HomePageController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

-(void)drawRect:(CGRect)rect{
    
    if (!self.delegate) {
        self.delegate = (id)[self getCurrentViewController];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
