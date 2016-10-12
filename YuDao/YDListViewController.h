//
//  YDListViewController.h
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDListViewControllerDelegate <NSObject>

- (void)listViewControllerWith:(NSString *)title;

@end

@interface YDListViewController : UIViewController

@property (nonatomic, weak) id<YDListViewControllerDelegate> delegate;

@end
