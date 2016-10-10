//
//  YDDModel.m
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDModel.h"

@implementation YDDModel

+ (instancetype)modelWithImageName:(NSString *)imageName number:(NSString *)number time:(NSString *)time name:(NSString *)name content:(NSString *)content placeImageName:(NSString *)placeImageName place:(NSString *)place{
    YDDModel *model = [self new];
    model.imageName = imageName;
    model.number = number;
    model.time = time;
    model.name = name;
    model.content = content;
    model.placeImageName = placeImageName;
    model.place = place;
    
    return model;
}

@end
