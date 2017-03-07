//
//  YDBindOBDModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBindOBDModel.h"

@implementation YDBindOBDModel

+ (YDBindOBDModel *)modelWithTitle:(NSString *)title placeholder:(NSString *)placeholder imageString:(NSString *)imageString;{
    YDBindOBDModel *model = [YDBindOBDModel new];
    model.title = title;
    model.placeholder = placeholder;
    model.imageString = imageString;
    return model;
}

@end
