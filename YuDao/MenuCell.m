//
//  MenuCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MenuCell.h"
#import "MenuModel.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
@implementation MenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGBCOLOR(8, 169, 195);
        if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            self.preservesSuperviewLayoutMargins = NO;
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_arrowBtn setImage:[UIImage imageNamed:@"bottomArrow"] forState:0];
    [_arrowBtn setImage:[UIImage imageNamed:@"topArrow"] forState:UIControlStateSelected];
    [_arrowBtn addTarget:self action:@selector(arrowBtnActioin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *contentView = self.contentView;
    [contentView addSubview:_arrowBtn];
    _arrowBtn.sd_layout
    .centerYEqualToView(contentView)
    .rightSpaceToView(contentView,10)
    .widthIs(27)
    .heightIs(27);
    
    
}

- (void)arrowBtnActioin:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sameDidselectedCellAction:btn:)]) {
        [self.delegate sameDidselectedCellAction:self btn:sender];
    }
}

- (void)setModel:(MenuModel *)model{
    _model = model;
    self.textLabel.text = model.menuLable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
