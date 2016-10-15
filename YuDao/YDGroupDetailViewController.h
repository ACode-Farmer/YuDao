//
//  YDGroupDetailViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"

@interface YDGroupDetailViewController : YDTableViewController

@property (nonatomic, assign) YDGroupDetailType groupType;
@property (nonatomic, assign) NSString *variableTitle;
@property (nonatomic, strong) NSString *rightBarButtonTitle;

- (instancetype)initWithType:(YDGroupDetailType )groupType title:(NSString *)title;

@end
