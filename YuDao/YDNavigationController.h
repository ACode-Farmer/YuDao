//
//  YDNavigationController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDNavigationController : UINavigationController

//隐藏导航栏底部黑线
- (void)hiddenBottomImageView:(BOOL )hidden;
- (void)completelyTransparentNavigationBar;
- (void)defaultNavigationBar;

//设备型号
+ (NSString *)platform;


@end
