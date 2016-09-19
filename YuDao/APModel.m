//
//  APModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "APModel.h"

@implementation APModel

+(instancetype)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle cellType:(CellType)type{
    APModel *model = [self new];
    model.title = title;
    model.subTitle = subTitle;
    model.type = type;
    return model;
}

@end
