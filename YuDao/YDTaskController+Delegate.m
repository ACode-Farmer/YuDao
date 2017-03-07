//
//  YDRankingListController+Delegate.m
//  YuDao
//
//  Created by 汪杰 on 16/12/13.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTaskController+Delegate.h"

@implementation YDTaskController (Delegate)

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data?self.data.count:0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YDTaskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YDTaskCell" forIndexPath:indexPath];
    YDTaskModel *model = self.data[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegate
CGPoint touchedTaskPoint;
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[BaiduMobStat defaultStat] logEvent:@"UserClick" eventLabel:@"任务"];
    YDTaskModel *model = self.data[indexPath.row];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    backView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    UIBlurEffect *effect1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect1];
    effectView.alpha = 0.8f;
    //effectView.backgroundColor = YDColor(0, 0, 0, 0.9);
    effectView.frame = backView.frame;
    [backView addSubview:effectView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChooseCarAction:)];
    [backView addGestureRecognizer:tap];
    
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor colorWithString:@"#F2B3552"];
    containerView.layer.cornerRadius = 8;
    containerView.layer.shadowColor=[[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
    containerView.layer.shadowOffset=CGSizeMake(5,5);
    containerView.layer.shadowOpacity=0.5;
    
    [backView addSubview:containerView];
    containerView.tag = 1000;
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [collectionView convertRect:cell.frame toView:self.parentViewController.view];
    frame.origin.y += 64;
    touchedTaskPoint = CGPointMake(frame.origin.x,frame.origin.y);
    containerView.frame = frame;
    containerView.alpha = 0;
    {
        UILabel *titleLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:model.t_title fontSize:22 textAlignment:NSTextAlignmentLeft];
        titleLabel.frame = CGRectMake(15, 15, screen_width-60, 30);
        [containerView addSubview:titleLabel];
        
        UILabel *timeLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:@"时效:不限" fontSize:12 textAlignment:NSTextAlignmentLeft];
        timeLabel.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+10, 60, 17);
        [containerView addSubview:timeLabel];
        
        UILabel *rewardLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:[NSString stringWithFormat:@"奖励:%@积分",model.t_reward] fontSize:12 textAlignment:NSTextAlignmentLeft];
        rewardLabel.frame = CGRectMake(85, CGRectGetMaxY(titleLabel.frame)+10, 100, 17);
        [containerView addSubview:rewardLabel];
        
        UILabel *contentLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:[NSString stringWithFormat:@"%@",model.t_content] fontSize:14 textAlignment:NSTextAlignmentLeft];
        contentLabel.numberOfLines = 0;
        [containerView addSubview:contentLabel];
        contentLabel.sd_layout
        .topSpaceToView(timeLabel,10)
        .leftEqualToView(timeLabel)
        .rightEqualToView(titleLabel)
        .autoHeightRatio(0);
    }
    [UIView animateWithDuration:0.3 animations:^{
        containerView.alpha = 1;
        CGRect newFrame = CGRectMake(18, (screen_height-200)/2, screen_width-36, 200);
        containerView.frame = newFrame;
        containerView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            containerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}
- (void)tapChooseCarAction:(UIGestureRecognizer *)tap{
    UIView *view = [tap.view viewWithTag:1000];
    [UIView animateWithDuration:0.2 animations:^{
        tap.view.alpha = 0;
        view.alpha = 0;
        view.frame = CGRectMake(touchedTaskPoint.x+10, touchedTaskPoint.y+10, 10, 10);
    } completion:^(BOOL finished) {
        [tap.view removeFromSuperview];
    }];
    
}

@end
