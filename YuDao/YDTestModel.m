//
//  YDTestModel.m
//  YuDao
//
//  Created by 汪杰 on 16/12/3.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDTestModel.h"

@implementation YDTestModel

@end


@implementation YDTestDetailModel

+ (YDTestDetailModel *)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle backgImageString:(NSString *)backgImageString data:(NSString *)data oilMessage:(NSString *)oilMessage{
    YDTestDetailModel *model = [YDTestDetailModel new];
    model.titile = title;
    model.subTitle = subTitle;
    model.backgImageString = backgImageString;
    model.data = data;
    model.oilMessage = oilMessage;
    
    return model;
}

@end
