//
//  YDGarageModel.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGarageModel.h"

@implementation YDGarageModel

+ (instancetype)modelWithCarImageName:(NSString *)carImageName carName:(NSString *)carName isIdentified:(BOOL )isIdentified carModel:(NSString *)carModel checkTitle:(NSString *)checkTitle{
    YDGarageModel *model = [self new];
    model.carImageName = carImageName;
    model.carname = carName;
    model.isIdentified = isIdentified;
    model.carModel = carModel;
    model.checkTitle = checkTitle;
    
    return model;
}

@end
