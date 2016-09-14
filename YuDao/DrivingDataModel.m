//
//  DrivingDataModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "DrivingDataModel.h"

@implementation DrivingDataModel

+(instancetype)modelWith:(NSString *)title imageName:(NSString *)imageName firstData:(NSString *)firstData secondData:(NSString *)secondData{
    DrivingDataModel *model = [self new];
    model.title = title;
    model.imageName = imageName;
    model.firstData = firstData;
    model.secondData = secondData;
    
    return model;
}

@end
