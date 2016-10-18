//
//  LikedListController.h
//  YuDao
//
//  Created by 汪杰 on 16/9/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "CommonController.h"

@protocol YDLikedListControllerDelegate <NSObject>

- (void)likedListControllerPushTo:(UIViewController *)vc;

@end

@interface LikedListController : CommonController

@property (nonatomic, weak) id<YDLikedListControllerDelegate> delegate;

@end
