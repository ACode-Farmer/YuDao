//
//  AppDelegate.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDRootViewController.h"
static NSString *kJPushAppKey = @"f90176495f64d3e639903474";
static NSString *kJPushChannel = @"App Store";

static BOOL     kJPushIsProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) YDRootViewController *rootVC;

@end

