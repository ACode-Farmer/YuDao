//
//  YDSingleRankingCell.h
//  YuDao
//
//  Created by 汪杰 on 2017/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDListModel.h"

@interface YDSingleRankingCell : UITableViewCell

@property (nonatomic, strong) UILabel     *rankLabel;   //排名

@property (nonatomic, strong) UIImageView *headerImageV;//头像

@property (nonatomic, strong) UILabel     *nameLabel;   //名字

@property (nonatomic, strong) UILabel     *levelLabel;  //等级

@property (nonatomic, strong) UILabel     *dataLabel;   //数据

@property (nonatomic, strong) UIButton    *likeBtn;     //喜欢按钮

@property (nonatomic, strong) UIImageView *bottomLine;  //底部分割线

@property (nonatomic, assign) YDRankingListDataType type;//数据类型(注:请在model之前赋值)

@property (nonatomic, strong) YDListModel *model;

@end
