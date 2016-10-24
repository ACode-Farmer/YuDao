//
//  YDImageExpressionDisplayView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDImageExpressionDisplayView.h"

#define     WIDTH_TIPS      150
#define     HEIGHT_TIPS     162
#define     WIDTH_CENTER    25
#define     SPACE_IMAGE     16

@interface YDImageExpressionDisplayView ()

@property (nonatomic, strong) UIImageView *bgLeftView;

@property (nonatomic, strong) UIImageView *bgCenterView;

@property (nonatomic, strong) UIImageView *bgRightView;

@property (nonatomic, strong) UIImageView *imageView;

@end
@implementation YDImageExpressionDisplayView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, WIDTH_TIPS, HEIGHT_TIPS)]) {
        [self addSubview:self.bgLeftView];
        [self addSubview:self.bgCenterView];
        [self addSubview:self.bgRightView];
        [self addSubview:self.imageView];
        [self y_addMasonry];
    }
    return self;
}

- (void)displayEmoji:(YDEmoji *)emoji atRect:(CGRect)rect
{
    [self setRect:rect];
    [self setEmoji:emoji];
}

#pragma mark - Private Methods -
- (void)y_addMasonry
{
//    [self.bgLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.left.and.bottom.mas_equalTo(self);
//    }];
//    [self.bgCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgLeftView.mas_right);
//        make.top.and.bottom.mas_equalTo(self.bgLeftView);
//        make.width.mas_equalTo(WIDTH_CENTER);
//    }];
//    [self.bgRightView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgCenterView.mas_right);
//        make.top.and.bottom.mas_equalTo(self.bgLeftView);
//        make.right.mas_equalTo(self);
//    }];
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self).mas_offset(10);
//        make.left.mas_equalTo(self).mas_offset(10);
//        make.right.mas_equalTo(self).mas_offset(-10);
//        make.height.mas_equalTo(self.imageView.mas_width);
//    }];
}


#pragma mark - Getter -
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIImageView *)bgLeftView
{
    if (_bgLeftView == nil) {
        _bgLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emojiKB_bigTips_left"]];
    }
    return _bgLeftView;
}

- (UIImageView *)bgCenterView
{
    if (_bgCenterView == nil) {
        _bgCenterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emojiKB_bigTips_middle"]];
    }
    return _bgCenterView;
}

- (UIImageView *)bgRightView
{
    if (_bgRightView == nil) {
        _bgRightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emojiKB_bigTips_right"]];
    }
    return _bgRightView;
}

@end
