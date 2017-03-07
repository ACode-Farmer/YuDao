//
//  YDMyDataViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDMyDataModel.h"

#import "YDMyInfoHeaderCell.h"
#import "YDMyInfoInputCell.h"
#import "YDMyInfoGenderCell.h"
#import "YDMyInfoEnterCell.h"

@interface YDMyDataViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YDUser     *tempUser;

//返回键的回调，上传用户信息
- (void)uploadMyInforMation;

@end
