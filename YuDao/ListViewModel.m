//
//  ListViewModel.m
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "ListViewModel.h"

@implementation ListViewModel

+ (instancetype)modelWithPlacing:(NSString *)placing imageName:(NSString *)imageName name:(NSString *)name grade:(NSString *)grade sign:(NSString *)sign type:(NSString *)type isAttention:(BOOL)isAttention{
    ListViewModel *model = [self new];
    model.placing = placing;
    model.imageName = imageName;
    model.name = name;
    model.grade = grade;
    model.sign = sign;
    model.type = type;
    model.isAttention = isAttention;
    return model;
}

@end
