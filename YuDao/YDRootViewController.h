//
//  YDRootViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTabBarController.h"

@interface YDRootViewController : YDTabBarController
{
    NSMutableArray *_messageContents;
    int _messageCount;
    int _notificationCount;
}
+ (YDRootViewController *)sharedRootViewController;

/**
 *  取得相应位置的ViewController
 *
 *  @param index 位置
 *
 *  @return 控制器
 */
- (id)childViewControllerAtIndex:(NSUInteger)index;


@end
