//
//  TaskContentView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "TaskContentView.h"
#import "CornerButton.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "TaskModel.h"

@implementation TaskContentView
{
    UILabel  *_titleLabel;
    UILabel  *_timeLabel;
    UILabel  *_rewardLabel;
    UILabel  *_targetLebel;
    CornerButton *_goBtn;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _titleLabel = [UILabel new];
    _titleLabel.text = @"任务一：时速排行榜";
    [_timeLabel setFont:[UIFont systemFontOfSize:20]];
    _timeLabel = [UILabel new];
    _timeLabel.text = @"任务时效:";
    _rewardLabel = [UILabel new];
    _rewardLabel.text = @"任务奖励:";
    _targetLebel = [UILabel new];
    _targetLebel.text = @"任务目标:";
    _goBtn = [CornerButton circularButtonWithTitle:@"GO" backgroundColor:[UIColor orangeColor]];
    NSArray *subviews = @[_titleLabel,_timeLabel,_rewardLabel,_targetLebel];
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = (UILabel *)obj;
        [label setTextColor:[UIColor colorWithString:@"#8159aa"]];
        [self addSubview:label];
    }];
    [self addSubview:_goBtn];
    
    _titleLabel.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,10)
    .widthRatioToView(self,0.7)
    .heightIs(21);
    
    _timeLabel.sd_layout
    .topSpaceToView(_titleLabel,5)
    .leftEqualToView(_titleLabel)
    .rightEqualToView(_titleLabel)
    .heightIs(21);
    
    _rewardLabel.sd_layout
    .topSpaceToView(_timeLabel,5)
    .leftEqualToView(_titleLabel)
    .rightEqualToView(_titleLabel)
    .heightIs(21);
    
    _targetLebel.sd_layout
    .topSpaceToView(_rewardLabel,5)
    .leftEqualToView(_titleLabel)
    .rightEqualToView(_titleLabel)
    .autoHeightRatio(0);
    _targetLebel.isAttributedContent = YES;
    
    _goBtn.sd_layout
    .rightSpaceToView(self,16)
    .bottomEqualToView(_targetLebel)
    .heightIs(76*widthHeight_ratio)
    .widthEqualToHeight();
    [_goBtn addTarget:self action:@selector(goBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _goBtn.layer.borderWidth = 1.f;
    _goBtn.layer.borderColor = [UIColor colorWithString:@"#8159aa"].CGColor;
    
    [self setupAutoHeightWithBottomView:_targetLebel bottomMargin:25*widthHeight_ratio];
}

- (void)goBtnAction:(UIButton *)sender{
    if (self.taskContentViewDelegate && [self.taskContentViewDelegate respondsToSelector:@selector(taskContentViewGoCompliteTask:)]) {
        [self.taskContentViewDelegate taskContentViewGoCompliteTask:_titleLabel.text];
    }
}

- (void)setModel:(TaskModel *)model{
    _model = model;
    _timeLabel.text = [_timeLabel.text stringByAppendingString:model.time];
    _rewardLabel.text = [_rewardLabel.text stringByAppendingString:model.reward];
    NSString *string = [_targetLebel.text stringByAppendingString:model.target];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    UIColor *color = [UIColor colorWithString:@"#8159aa"];
    NSAttributedString *attstring = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _targetLebel.attributedText = attstring;
    if (model.isComplete) {
        [_goBtn setTitle:@"GO" forState:0];
    }else{
        [_goBtn setTitle:@"完成" forState:0];
    }
}

#pragma mark - Getters


@end
