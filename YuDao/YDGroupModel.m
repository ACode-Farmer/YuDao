//
//  YDGroupModel.m
//  YuDao
//
//  Created by 汪杰 on 16/10/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGroupModel.h"

@implementation YDGroupModel

+ (instancetype)groupModelWithGroupName:(NSString *)groupName groupImageName:(NSString *)groupImageName groupType:(YDGroupDetailType )groupType{
    YDGroupModel *model = [self new];
    model.groupName = groupName;
    model.groupImageName = groupImageName;
    model.groupType = groupType;
    
    return model;
}

@end
