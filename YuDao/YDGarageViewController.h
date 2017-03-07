//
//  YDGarageViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTableViewController.h"

@interface YDGarageViewController : YDTableViewController

@property (nonatomic, copy  ) void(^didSelectedCarBlock)(YDCarDetailModel *car);

@end
