//
//  MyMseeageModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyMseeageModel.h"

@implementation MyMseeageModel

+ (instancetype)modelWith:(NSString *)imageName name:(NSString *)name lastMessage:(NSString *)lastMessage time:(NSString *)time{
    MyMseeageModel *model = [[MyMseeageModel alloc] init];
    model.imageName = imageName;
    model.name = name;
    model.lastMessage = lastMessage;
    model.time = time;
    return model;
}

@end
