//
//  SetupModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "SetupModel.h"

@implementation SetupModel

+ (instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    SetupModel *model = [self new];
    model.title = title;
    model.subTitle = subTitle;
    return model;
}

@end
