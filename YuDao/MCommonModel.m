//
//  MCommonModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MCommonModel.h"

@implementation MCommonModel

+(instancetype)normalModelWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    MCommonModel *model = [self new];
    model.title = title;
    model.subTitle = subTitle;
    return model;
}

+(instancetype)singleModelWithTitle:(NSString *)title{
    MCommonModel *model = [self new];
    model.title = title;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *subTitle = [defaults stringForKey:model.title];
    if (subTitle) {
        model.subTitle = subTitle;
    }else{
        model.subTitle = @"\\";
    }
    
    return model;
}

@end
