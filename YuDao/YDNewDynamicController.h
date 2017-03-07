//
//  YDNewDynamicController.h
//  YuDao
//
//  Created by 汪杰 on 2017/1/15.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDNewDynamicController : UITableViewController<UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, copy  ) void(^publishCompleteBlock)();


@end
