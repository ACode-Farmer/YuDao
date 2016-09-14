//
//  DrivingDataCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DrivingDataCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "DrivingDataModel.h"
@implementation DrivingDataCell
{
    UILabel *_titleLabel;
    UIImageView *_iconView;
    UILabel *_firstLabel;
    UILabel *_secondLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor orangeColor];
    _iconView = [UIImageView new];
    _iconView.backgroundColor = [UIColor blackColor];
    _firstLabel = [UILabel new];
    _firstLabel.backgroundColor = [UIColor blueColor];
    _secondLabel = [UILabel new];
    _secondLabel.backgroundColor = [UIColor redColor];
    
    NSArray *subViews = @[_titleLabel,_iconView,_firstLabel,_secondLabel];
    UIView *contentView = self.contentView;
    [contentView sd_addSubviews:subViews];
    
    _titleLabel.sd_layout
    .topSpaceToView(contentView,0)
    .leftSpaceToView(contentView,0)
    .bottomSpaceToView(contentView,1);
    
    _iconView.sd_layout
    .topSpaceToView(contentView,0)
    .leftSpaceToView(_titleLabel,0)
    .bottomSpaceToView(contentView,1);
    
    _firstLabel.sd_layout
    .topSpaceToView(contentView,0)
    .leftSpaceToView(_iconView,0)
    .bottomSpaceToView(contentView,1);
    
    _secondLabel.sd_layout
    .topSpaceToView(contentView,0)
    .leftSpaceToView(_firstLabel,0)
    .bottomSpaceToView(contentView,1);
    
    [contentView setSd_equalWidthSubviews:subViews];
}

- (void)setModel:(DrivingDataModel *)model{
    _model = model;
    _titleLabel.text = model.title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
