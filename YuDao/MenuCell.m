//
//  MenuCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGBCOLOR(8, 169, 195);
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
    _arrowBtn.frame = CGRectMake(0, 0, 30, 30);
    [_arrowBtn setImage:[UIImage imageNamed:@"bottomArrow"] forState:0];
    [_arrowBtn setImage:[UIImage imageNamed:@"friendIcon"] forState:UIControlStateSelected];
    
    
    self.accessoryView = _arrowBtn;
}

- (void)arrowBtnActioin:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
