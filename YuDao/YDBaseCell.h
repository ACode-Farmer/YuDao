//
//  YDBaseCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDBaseCell : UITableViewCell

//名次
@property (nonatomic, strong) UILabel *placingLabel;
//头像
@property (nonatomic, strong) UIImageView *headerImageView;
//呢称
@property (nonatomic, strong) UILabel *nameLabel;
//关注按钮
@property (nonatomic, strong) UIButton *attentionBtn;

//数据（在排行榜中会使用到)
@property (nonatomic, strong) UILabel *dataLabel;

@end
