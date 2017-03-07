//
//  YDConversationCell.m
//  YuDao
//
//  Created by 汪杰 on 17/2/13.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDConversationCell.h"

#define REDPOINT_WIDTH 15.0f

@interface YDConversationCell()

@property (nonatomic, strong) UIImageView *headerImageV;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UILabel *remindLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation YDConversationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self y_layoutSubviews];
        
    }
    return self;
}

- (void)setModel:(YDConversation *)model{
    _model = model;
    
    if ([model.fname isEqualToString:@"系统通知"]) {
        _headerImageV.image = [UIImage imageNamed:model.fimageUrl];
    }else{
        [_headerImageV sd_setImageWithURL:YDURL(model.fimageUrl) placeholderImage:[UIImage imageNamed:model.fimageUrl]];
    }
    _titleLabel.text = model.fname;
    _subTitleLabel.text = model.content;
    
    NSLog(@"fname = %@,date = %@",model.fname,model.date);
    _timeLabel.text = [model.date conversaionTimeInfo];
    
    if (model.unreadCount > 0) {
        _remindLabel.hidden = NO;
        _remindLabel.text = [NSString stringWithFormat:@"%ld",model.unreadCount];
    }else if (model.unreadCount == 0){
        _remindLabel.hidden = YES;
        _remindLabel.text = @"";
    }
}

/**
 *  标记为已读
 */
- (void) markAsRead{
    _remindLabel.text = @"";
    _remindLabel.hidden = YES;
}

- (void)y_layoutSubviews{
    [self.contentView sd_addSubviews:@[self.headerImageV,self.titleLabel,self.subTitleLabel,self.timeLabel,self.remindLabel,self.lineView]];
    
    
    _headerImageV.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,10)
    .heightIs(50)
    .widthIs(50);
    _headerImageV.sd_cornerRadiusFromWidthRatio = @0.5;
    
    _titleLabel.sd_layout
    .topEqualToView(_headerImageV)
    .leftSpaceToView(_headerImageV,10)
    .heightIs(21)
    .rightSpaceToView(self.contentView,90);
    
    _subTitleLabel.sd_layout
    .bottomEqualToView(_headerImageV)
    .leftEqualToView(_titleLabel)
    .heightIs(20)
    .rightEqualToView(_titleLabel);
    
    _timeLabel.sd_layout
    .centerYEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView,10)
    .heightIs(20)
    .widthIs(80);
    
    
    _remindLabel.sd_layout
    .centerYEqualToView(_subTitleLabel)
    .rightSpaceToView(self.contentView,10)
    .heightIs(REDPOINT_WIDTH)
    .widthIs(REDPOINT_WIDTH);
    
    _remindLabel.sd_cornerRadiusFromWidthRatio = @0.5;
    
    _lineView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .bottomEqualToView(self.contentView)
    .heightIs(1);
}

- (UIImageView *)headerImageV{
    if (!_headerImageV) {
        _headerImageV = [[UIImageView alloc] init];
        
    }
    return _headerImageV;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#2B3552"] fontSize:16];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#9B9B9B"] fontSize:14];
    }
    return _subTitleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [YDUIKit labelTextColor:[UIColor colorWithString:@"#999999"] fontSize:12];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:12];
        _remindLabel.backgroundColor = [UIColor redColor];
        _remindLabel.text = @"";
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.hidden = YES;
    }
    return _remindLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [YDUIKit viewWithBackgroundColor:[UIColor colorWithString:@"#B6C5DC"]];
    }
    return _lineView;
}

@end
