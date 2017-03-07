//
//  YDSpeedController.h
//  YuDao
//
//  Created by 汪杰 on 17/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDViewController.h"

@interface YDSpeedController : YDViewController

//标题
@property (nonatomic, copy  ) NSString *variableTitle;
//url头
@property (nonatomic, copy  ) NSString *urlPrefix;
//用户token
@property (nonatomic, copy  ) NSString *accsess_token;
//车辆id
@property (nonatomic, strong) NSNumber *ug_id;

@end
