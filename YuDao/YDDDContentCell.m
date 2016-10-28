//
//  YDDDContentCell.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDContentCell.h"
#import "YDDDContentModel.h"

@implementation YDDDContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 5)];
        lineView.backgroundColor = [UIColor colorGrayBG];
        [self.contentView sd_addSubviews:@[lineView,self.firstImageView,self.contentLabel]];
        [self.firstImageView sd_addSubviews:@[self.locateImageView,self.titleImageView,self.locateLabel,self.titleLabel]];
        [self y_layoutSubviews];
        
        self.selectionStyle = 0;
    }
    return self;
}

#pragma Event
- (void)tapFirstImageView:(UIGestureRecognizer *)tap{
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = 0;
    browser.sourceImagesContainerView = self.firstImageView;
    browser.imageCount = _model.imageArray.count;
    browser.delegate = self;
    
    [browser show];
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = _model.imageArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.firstImageView;
    return imageView.image;
}


- (void)setModel:(YDDDContentModel *)model{
    _model = model;
    self.firstImageView.image = [UIImage imageNamed:[model.imageArray firstObject]];
    self.locateLabel.text = model.location;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:15];
}

- (void)y_layoutSubviews{
    UIView *view = self.contentView;
    self.firstImageView.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(view,10)
    .widthRatioToView(view,0.85)
    .heightIs(250);
    
    self.titleImageView.sd_layout
    .leftSpaceToView(self.firstImageView,5)
    .bottomSpaceToView(self.firstImageView,5)
    .heightIs(20)
    .widthEqualToHeight();
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.titleImageView,3)
    .centerYEqualToView(self.titleImageView)
    .heightIs(21);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.locateImageView.sd_layout
    .leftEqualToView(self.titleImageView)
    .bottomSpaceToView(self.titleImageView,5)
    .heightIs(20)
    .widthEqualToHeight();
    
    self.locateLabel.sd_layout
    .centerYEqualToView(self.locateImageView)
    .leftEqualToView(self.titleLabel)
    .heightIs(21);
    [self.locateLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.firstImageView,15)
    .leftEqualToView(self.firstImageView)
    .rightEqualToView(self.firstImageView)
    .autoHeightRatio(0);
}

#pragma mark - Getter
- (UIImageView *)firstImageView{
    if (_firstImageView == nil) {
        _firstImageView = [UIImageView new];
        _firstImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFirstImageView:)];
        [_firstImageView addGestureRecognizer:tap];
    }
    return _firstImageView;
}

- (UIImageView *)locateImageView{
    if (_locateImageView == nil) {
        _locateImageView = [UIImageView new];
        _locateImageView.image = [UIImage imageNamed:@"locationIcon"];
    }
    return _locateImageView;
}

- (UIImageView *)titleImageView{
    if (_titleImageView == nil) {
        _titleImageView = [UIImageView new];
        _titleImageView.image = [UIImage imageNamed:@"locationIcon"];
    }
    return _titleImageView;
}

- (UILabel *)locateLabel{
    if (_locateLabel == nil) {
        _locateLabel = [UILabel new];
        [_locateLabel setFont:[UIFont font_14]];
    }
    return _locateLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        [_titleLabel setFont:[UIFont font_14]];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
    }
    return _contentLabel;
}

@end
