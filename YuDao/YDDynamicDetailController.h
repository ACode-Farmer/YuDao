//
//  YDDynamicDetailController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"
#import "YDDDHeaderView.h"
#import "YDDDBottomView.h"

#import "YDDDContentCell.h"
#import "YDDDCommentCell.h"

#import "YDDDContentModel.h"
#import "AWActionSheet.h"

#define YDDDContentCellID @"YDDDContentCellID"
#define YDDDCommentCellID @"YDDDCommentCellID"


@interface YDDynamicDetailController : YDTableViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) YDDDHeaderView *headerView;
@property (nonatomic, strong) YDDDBottomView *bottomView;

@property (nonatomic, strong) NSArray *shareArray;

@property (nonatomic, assign) CGFloat kKeybordHeight;

@end
