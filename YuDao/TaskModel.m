//
//  TaskModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel

+(instancetype)modelWithTime:(NSString *)time reward:(NSString *)reward target:(NSString *)target isComplete:(BOOL)isComplete{
    TaskModel *model = [self new];
    model.time = time;
    model.reward = reward;
    model.target = target;
    model.isComplete = isComplete;
    return model;
}

@end
