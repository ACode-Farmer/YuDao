//
//  YDRecoderIndicatorView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDRecoderIndicatorView.h"

#define     STR_RECORDING       @"手指上滑，取消发送"
#define     STR_CANCEL          @"手指松开，取消发送"
#define     STR_REC_SHORT       @"说话时间太短"

@interface YDRecoderIndicatorView ()

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *titleBackgroundView;

@property (nonatomic, strong) UIImageView *recImageView;

@property (nonatomic, strong) UIImageView *centerImageView;

@property (nonatomic, strong) UIImageView *volumeImageView;

@end

@implementation YDRecoderIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backgroundView];
        [self addSubview:self.recImageView];
        [self addSubview:self.volumeImageView];
        [self addSubview:self.centerImageView];
        [self addSubview:self.titleBackgroundView];
        [self addSubview:self.titleLabel];
        
        [self y_addMasonry];
    }
    return self;
}

- (void)setStatus:(YDRecorderStatus)status
{
    if (status == YDRecorderStatusWillCancel) {
        [self.centerImageView setHidden:NO];
        [self.centerImageView setImage:[UIImage imageNamed:@"chat_record_cancel"]];
        [self.titleBackgroundView setHidden:NO];
        [self.recImageView setHidden:YES];
        [self.volumeImageView setHidden:YES];
        [self.titleLabel setText:STR_CANCEL];
    }
    else if (status == YDRecorderStatusRecording) {
        [self.centerImageView setHidden:YES];
        [self.titleBackgroundView setHidden:YES];
        [self.recImageView setHidden:NO];
        [self.volumeImageView setHidden:NO];
        [self.titleLabel setText:STR_RECORDING];
    }
    else if (status == YDRecorderStatusTooShort) {
        [self.centerImageView setHidden:NO];
        [self.centerImageView setImage:[UIImage imageNamed:@"chat_record_cancel"]];
        [self.titleBackgroundView setHidden:YES];
        [self.recImageView setHidden:YES];
        [self.volumeImageView setHidden:YES];
        [self.titleLabel setText:STR_REC_SHORT];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (status == YDRecorderStatusTooShort) {
                [self removeFromSuperview];
            }
        });
    }
}

- (void)setVolume:(CGFloat)volume
{
    _volume = volume;
    NSInteger picId = 10 * (volume < 0 ? 0 : (volume > 1.0 ? 1.0 : volume));
    picId = picId > 8 ? 8 : picId;
    [self.volumeImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"chat_record_signal_%ld", (long)picId]]];
}

#pragma mark - # Private Methods
- (void)y_addMasonry
{
    
    self.backgroundView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    self.recImageView.sd_layout
    .topSpaceToView(self,15)
    .leftSpaceToView(self,21);

    self.volumeImageView.sd_layout
    .topEqualToView(self.recImageView)
    .heightRatioToView(self.recImageView,1)
    .rightSpaceToView(self,21);

    self.centerImageView.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self,15);

    self.titleLabel.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(self,15);
//    [self.titleBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.titleLabel).mas_offset(UIEdgeInsetsMake(-2, -5, -2, -5)).priorityLow();
//    }];
//    self.titleBackgroundView.sd_layout
//    .;
}

#pragma mark - # Getter
- (UIView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        [_backgroundView setBackgroundColor:[UIColor blackColor]];
        [_backgroundView setAlpha:0.6f];
        [_backgroundView.layer setMasksToBounds:YES];
        [_backgroundView.layer setCornerRadius:5.0f];
    }
    return _backgroundView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setText:STR_RECORDING];
    }
    return _titleLabel;
}

- (UIView *)titleBackgroundView
{
    if (_titleBackgroundView == nil) {
        _titleBackgroundView = [[UIView alloc] init];
        [_titleBackgroundView setHidden:YES];
        [_titleBackgroundView setBackgroundColor:[UIColor redColor]];
        [_titleBackgroundView.layer setMasksToBounds:YES];
        [_titleBackgroundView.layer setCornerRadius:2.0f];
    }
    return _titleBackgroundView;
}

- (UIImageView *)recImageView
{
    if (_recImageView == nil) {
        _recImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_record_recording"]];
        
    }
    return _recImageView;
}

- (UIImageView *)centerImageView
{
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc] init];
        [_centerImageView setHidden:YES];
    }
    return _centerImageView;
}

- (UIImageView *)volumeImageView
{
    if (_volumeImageView == nil) {
        _volumeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_record_signal_1"]];
    }
    return _volumeImageView;
}

@end
