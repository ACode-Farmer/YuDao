//
//  YDPopDownCell.m
//  YuDao
//
//  Created by 汪杰 on 16/12/1.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPopDownCell.h"

@interface YDPopDownCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation YDPopDownCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.label];
        
        self.label.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    }
    return self;
}

- (void)setModel:(YDCarDetailModel *)model{
    _model = model;
    self.label.text = model.ug_brand_name;
}

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
