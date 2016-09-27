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
    _timeLabel = [UILabel new];
    _timeLabel.text = @"时效:";
    _rewardLabel = [UILabel new];
    _rewardLabel.text = @"奖励:";
    _targetLebel = [UILabel new];
    _targetLebel.text = @"目标:";
    _goBtn = [CornerButton circularButtonWithTitle:@"GO" backgroundColor:[UIColor orangeColor]];
    NSArray *subviews = @[_timeLabel,_rewardLabel,_targetLebel,_goBtn];
    [self sd_addSubviews:subviews];
    
    _timeLabel.sd_layout
    .topSpaceToView(self,10)
    .leftSpaceToView(self,10)
    .rightSpaceToView(self,10)
    .heightIs(21);
    
    _rewardLabel.sd_layout
    .topSpaceToView(_timeLabel,5)
    .leftEqualToView(_timeLabel)
    .rightEqualToView(_timeLabel)
    .heightIs(21);
    
    _targetLebel.sd_layout
    .topSpaceToView(_rewardLabel,5)
    .leftEqualToView(_timeLabel)
    .rightEqualToView(_timeLabel)
    .autoHeightRatio(0);
    _targetLebel.isAttributedContent = YES;
    
    _goBtn.sd_layout
    .rightSpaceToView(self,30)
    .bottomSpaceToView(self,30)
    .heightRatioToView(self,0.3)
    .widthEqualToHeight();
    
}

- (void)setModel:(TaskModel *)model{
    _model = model;
    _timeLabel.text = [_timeLabel.text stringByAppendingString:model.time];
    _rewardLabel.text = [_rewardLabel.text stringByAppendingString:model.reward];
    NSString *string = [_targetLebel.text stringByAppendingString:model.target];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    UIColor *color = [UIColor blackColor];
    NSAttributedString *attstring = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : color, NSParagraphStyleAttributeName: paragraphStyle}];
    _targetLebel.attributedText = attstring;
    if (model.isComplete) {
        [_goBtn setTitle:@"完成" forState:0];
    }else{
        [_goBtn setTitle:@"GO" forState:0];
    }
}

@end
