//
//  DiscoverModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

+ (instancetype)modelWithImageName:(NSString *)imageName name:(NSString *)name{
    DiscoverModel *model = [[DiscoverModel alloc] init];
    model.imageName = imageName;
    model.name = name;
    return model;
}

@end
