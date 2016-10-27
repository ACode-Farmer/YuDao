//
//  YDDynamicDetailController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"
#import "YDDDHeaderView.h"
#import "YDDDContentCell.h"
#import "YDDDContentModel.h"

#define YDDNormalCellID @"YDDNormalCellID"

#define YDDDContentCellID @"YDDDContentCellID"

static CGFloat textFieldH = 40;

@interface YDDynamicDetailController : YDTableViewController

@property (nonatomic, strong) NSArray *dataArray;


@end
