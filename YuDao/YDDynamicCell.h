//
//  YDDynamicCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDDModel;

@interface YDDynamicCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *placeImageView;
@property (nonatomic, strong) UILabel *placeLabel;


@property (nonatomic, strong) YDDModel *model;

@end
