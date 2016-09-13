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
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.frame = CGRectMake(0, 0, 30, 30);
    [arrowBtn setImage:[UIImage imageNamed:@"bottomArrow"] forState:0];
    [arrowBtn setImage:[UIImage imageNamed:@"friendIcon"] forState:UIControlStateSelected];
    
    
    self.accessoryView = arrowBtn;
}

- (void)arrowBtnActioin:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
