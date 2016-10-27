//
//  DynamicViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/9/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

@class YDDynamicDetailController;
@protocol YDDynamicVCDelegate <NSObject>

- (void)YDDynamicViewControllerPushToVC:(YDDynamicDetailController *)toVC index:(NSInteger )index;

@end

@interface DynamicViewController : UIViewController

@property (nonatomic, weak) id<YDDynamicVCDelegate> delegate;

@end
