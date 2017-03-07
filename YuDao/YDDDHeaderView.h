//
//  YDDDHeaderView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDDynamicDetailModel.h"

@interface YDDDHeaderView : UIView

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *genderImageView;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *lookTimesLabel;
@property (nonatomic, strong) UILabel *lookLabel;

- (void)updateWithHeaderUrl:(NSString *)headerUrl name:(NSString *)name gender:(NSString *)gender level:(NSString *)level time:(NSString *)time looktimes:(NSNumber *)lookTimes;

@end
