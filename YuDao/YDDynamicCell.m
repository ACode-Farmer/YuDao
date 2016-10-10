//
//  YDDynamicCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDynamicCell.h"
#import "YDDModel.h"

@implementation YDDynamicCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.sd_cornerRadius = @5;
        
        _imageView = [UIImageView new];
        _numberLabel = [UILabel new];
        _timeLabel = [UILabel new];
        _nameLabel = [UILabel new];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.alpha = 0.5;
        _contentLabel = [UILabel new];
        _placeImageView = [UIImageView new];
        _placeLabel = [UILabel new];
        
        [self sd_addSubviews:@[_imageView,_nameLabel,_contentLabel,_placeImageView,_placeLabel]];
        [_imageView sd_addSubviews:@[_numberLabel,_timeLabel]];
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _imageView.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .autoHeightRatio(0);
    
    _numberLabel.sd_layout
    .leftSpaceToView(_imageView,12*widthHeight_ratio)
    .bottomSpaceToView(_imageView,8*widthHeight_ratio)
    .widthIs(50*widthHeight_ratio)
    .heightIs(20*widthHeight_ratio);
    _numberLabel.sd_cornerRadius = @5;
    
    _timeLabel.sd_layout
    .leftSpaceToView(_numberLabel,52*widthHeight_ratio)
    .bottomEqualToView(_numberLabel)
    .heightIs(20*widthHeight_ratio)
    .rightSpaceToView(_imageView,0);
    
    _nameLabel.sd_layout
    .topSpaceToView(_imageView,8*widthHeight_ratio)
    .leftSpaceToView(_imageView,10)
    .widthRatioToView(_imageView,0.7)
    .heightIs(21);
    
    _contentLabel.sd_layout
    .topSpaceToView(_imageView,8*widthHeight_ratio)
    .leftEqualToView(_nameLabel)
    .rightSpaceToView(_imageView,0.8)
    .heightIs(21);
    
    _placeImageView.sd_layout
    .topSpaceToView(_contentLabel,8*widthHeight_ratio)
    .leftEqualToView(_nameLabel)
    .widthIs(15*widthHeight_ratio)
    .heightIs(26*widthHeight_ratio);
    
    _placeLabel.sd_layout
    .centerYEqualToView(_placeImageView)
    .leftSpaceToView(_placeImageView,5)
    .rightSpaceToView(_imageView,5)
    .heightIs(21);
}

- (void)setModel:(YDDModel *)model{
    _model = model;
    
    _imageView.image = [UIImage imageNamed:model.imageName];
    _numberLabel.text = model.number;
    _timeLabel.text = model.time;
    _nameLabel.text = model.name;
    _contentLabel.text = model.content;
    _placeImageView.image = [UIImage imageNamed:model.placeImageName];
    _placeLabel.text = model.place;
    
}


@end
