//
//  YDPTimeAxisCell.h
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWeiXinPhotoContainerView.h"
#import "YDPTimeAxisModel.h"

@interface YDPTimeAxisCell : UITableViewCell

@property (nonatomic, copy) void (^likeButtonClickBlock)(NSIndexPath *indexPath,UIButton *button);

@property (nonatomic, strong) YDPTimeAxisModel *model;

@end
