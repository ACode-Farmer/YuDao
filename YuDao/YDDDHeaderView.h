//
//  YDDDHeaderView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDDDHeaderView : UIView

@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIImageView *genderImageView;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)updateHeaderView:(NSString *)userImage userName:(NSString *)name genderImage:(NSString *)genderImage level:(NSString *)level time:(NSString *)time;

@end
