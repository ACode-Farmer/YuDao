//
//  TaskContentView.h
//  YuDao
//
//  Created by 汪杰 on 16/9/27.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskModel;

@protocol TaskContentViewDelegate <NSObject>

- (void)taskContentViewGoCompliteTask:(NSString *)taskName;

@end

@interface TaskContentView : UIView

@property (nonatomic, weak) id<TaskContentViewDelegate> taskContentViewDelegate;

@property (nonatomic, strong) TaskModel *model;

@end
