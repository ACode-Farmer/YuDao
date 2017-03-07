//
//  YDDDHeaderView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDDHeaderView.h"


@implementation YDDDHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self sd_addSubviews:@[self.userImageView,self.userNameLabel,self.genderImageView,self.levelLabel,self.timeLabel]];
        [self y_latoutSubviews];
    }
    return self;
}

- (void)updateWithHeaderUrl:(NSString *)headerUrl name:(NSString *)name gender:(NSString *)gender level:(NSString *)level time:(NSString *)time looktimes:(NSNumber *)lookTimes{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:headerUrl]];
    self.userNameLabel.text = name;
    self.lookTimesLabel.text = [NSString stringWithFormat:@"%@",lookTimes?lookTimes:@0];
    
    self.timeLabel.text = time;
    NSDateFormatter *dateFor = [NSDateFormatter new];
    [dateFor setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFor dateFromString:time];
    if ([date isToday]) {
        [dateFor setDateFormat:@"HH:mm"];
    }else if ([date isLastYear]){
        [dateFor setDateFormat:@"yyyy年MM月dd日"];
    }else{
        [dateFor setDateFormat:@"MM月dd日"];
    }
    _timeLabel.text = [dateFor stringFromDate:date];
}

- (id)init{
    if (self = [super init]) {
        [self sd_addSubviews:@[self.userImageView,self.userNameLabel,self.genderImageView,self.levelLabel,self.timeLabel]];
        [self y_latoutSubviews];
    }
    return self;
}

- (void)updateHeaderViewWith:(YDDynamicDetailModel *)model tableView:(UITableView *)table{
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:model.ud_face] placeholderImage:[UIImage imageNamed:@"mine_user_placeholder"]];
    self.userNameLabel.text = model.ub_nickname;
    self.timeLabel.text = model.d_time;
    
}

- (void)y_latoutSubviews{
    self.userImageView.sd_layout
    .topSpaceToView(self,17)
    .leftSpaceToView(self,19)
    .widthIs(50)
    .heightIs(50);
    
    self.userNameLabel.sd_layout
    .topEqualToView(self.userImageView)
    .leftSpaceToView(self.userImageView,7)
    .heightIs(21);
    [self.userNameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.timeLabel.sd_layout
    .bottomEqualToView(self.userImageView)
    .leftEqualToView(self.userNameLabel)
    .heightIs(15);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    UIView *lookBackgroundView = [UIView new];
    lookBackgroundView.layer.cornerRadius = 3.f;
    lookBackgroundView.layer.borderColor = [UIColor colorWithString:@"#DCDCDC"].CGColor;
    lookBackgroundView.layer.borderWidth = 0.5f;
    [self addSubview:lookBackgroundView];
    lookBackgroundView.sd_layout
    .centerYEqualToView(self)
    .widthIs(50)
    .heightIs(25)
    .rightSpaceToView(self,22);
    
    [lookBackgroundView sd_addSubviews:@[self.lookLabel,self.lookTimesLabel]];
    
    _lookTimesLabel.sd_layout
    .topEqualToView(lookBackgroundView)
    .leftEqualToView(lookBackgroundView)
    .rightEqualToView(lookBackgroundView)
    .heightIs(17);
    
    _lookLabel.sd_layout
    .bottomEqualToView(lookBackgroundView)
    .leftEqualToView(lookBackgroundView)
    .rightEqualToView(lookBackgroundView)
    .heightIs(10);
}

#pragma mark Getter
- (UIImageView *)userImageView{
    if (_userImageView == nil) {
        _userImageView = [UIImageView new];
        _userImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    }
    return _userImageView;
}

- (UILabel *)userNameLabel{
    if (_userNameLabel == nil) {
        _userNameLabel = [UILabel new];
    }
    return _userNameLabel;
}

- (UIImageView *)genderImageView{
    if (_genderImageView == nil) {
        _genderImageView = [UIImageView new];
    }
    return _genderImageView;
}

- (UILabel *)levelLabel{
    if (_levelLabel == nil) {
        _levelLabel = [UILabel new];
        _levelLabel.textColor = [UIColor orangeColor];
    }
    return _levelLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont font_12];
        _timeLabel.textColor = [UIColor colorTextGray];
    }
    return _timeLabel;
}

- (UILabel *)lookLabel{
    if (!_lookLabel) {
        _lookLabel = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#999999"] text:@"阅读" fontSize:9 textAlignment:NSTextAlignmentCenter];
    }
    return _lookLabel;
}

- (UILabel *)lookTimesLabel{
    if (!_lookTimesLabel) {
        _lookTimesLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#999999"] fontSize:12 textAlignment:NSTextAlignmentCenter];
        _lookTimesLabel.text = @"0";
    }
    return _lookTimesLabel;
}

@end
