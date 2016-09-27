//
//  TaskModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *reward;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, assign) BOOL isComplete;

+ (instancetype)modelWithTime:(NSString *)time reward:(NSString *)reward target:(NSString *)target isComplete:(BOOL)isComplete;

@end
