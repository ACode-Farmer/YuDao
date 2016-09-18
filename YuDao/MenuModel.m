//
//  MenuModel.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

- (instancetype)initWithIcon:(NSString *)icon lable:(NSString *)label arrow:(NSString *)arrow{
    self = [super init];
    if (self) {
        self.iconName = icon;
        self.menuLable = label;
        self.arrow = arrow;
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"name = %@",_menuLable];
}

@end
