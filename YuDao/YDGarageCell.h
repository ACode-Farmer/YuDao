//
//  YDGarageCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDGarageModel;

@protocol YDGarageCellDelegate <NSObject>

- (void)garageCellWithTitle:(NSString *)title;

@end

@interface YDGarageCell : UITableViewCell

@property (nonatomic, weak) id<YDGarageCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *carImageView;
@property (nonatomic, strong) UILabel *carName;
@property (nonatomic, strong) UIButton *identifierBtn;
@property (nonatomic, strong) UILabel *carModel;
@property (nonatomic, strong) UIButton *checkBtn;

@property (nonatomic, strong) YDGarageModel *model;

@end
