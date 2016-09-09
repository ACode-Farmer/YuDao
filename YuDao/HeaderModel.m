//
//  HeaderModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "HeaderModel.h"

@implementation HeaderModel

+(HeaderModel *)modelWithImageName:(NSString *)imageName Name:(NSString *)name{
    HeaderModel *model = [[HeaderModel alloc] init];
    model.imageName = imageName;
    model.name = name;
    return model;
}

@end
