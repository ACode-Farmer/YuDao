//
//  MyInformationModel.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyInformationModel.h"

@implementation MyInformationModel

+ (id)modelWithDictionary:(NSDictionary *)dic{
    MyInformationModel *model = [[MyInformationModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
