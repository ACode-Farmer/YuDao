//
//  YDMyDataModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMyDataModel.h"

@implementation YDMyDataModel

+ (YDMyDataModel *)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle subImageName:(NSString *)subImageName{
    YDMyDataModel *model = [YDMyDataModel new];
    model.title = title;
    model.subTitle = subTitle;
    model.subImageName = subImageName;
    return model;
}

@end
