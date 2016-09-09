//
//  MyselfModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyselfModel.h"

@implementation MyselfModel

+ (instancetype)modelWithIamgeName:(NSString *)imageName name:(NSString *)name{
    MyselfModel *model = [MyselfModel new];
    model.imageName = imageName;
    model.name = name;
    
    return model;
}

@end
