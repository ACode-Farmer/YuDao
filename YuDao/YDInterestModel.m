//
//  YDInterestModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDInterestModel.h"

static YDInterestModel *model = nil;

@implementation YDInterestModel

+ (YDInterestModel *)shareInterests{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[YDInterestModel alloc] init];
        model.items = [NSMutableArray arrayWithCapacity:5];
        model.tags = [NSMutableArray arrayWithCapacity:5];
        NSString *ug_tag = [YDUserDefault defaultUser].user.ud_tag;
        NSString *ud_tag_name = [YDUserDefault defaultUser].user.ud_tag_name;
        [model.tags addObjectsFromArray:[ug_tag componentsSeparatedByString:@","]]; 
        [model.items addObjectsFromArray:[ud_tag_name componentsSeparatedByString:@","]];
        [model.tags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *string = obj;
            if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
                [model.tags removeObject:obj];
            }
        }];
        [model.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *string = obj;
            if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
                [model.items removeObject:obj];
            }
        }];
    });
    
    return model;
}

@end
