//
//  DrivingModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/26.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DrivingModel.h"

@implementation DrivingModel

+(instancetype)modelWithTitle:(NSString *)title data:(NSString *)data subTitle:(NSString *)subTitle{
    DrivingModel *model = [self new];
    model.title = title;
    model.data = data;
    model.subTitle = subTitle;
    return model;
}

@end
