//
//  YDDDContentCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"

@class YDDDContentModel;
@interface YDDDContentCell : UITableViewCell<SDPhotoBrowserDelegate>

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UILabel *locateLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *locateImageView;
@property (nonatomic, strong) UIImageView *titleImageView;


@property (nonatomic, strong) YDDDContentModel *model;

@end
