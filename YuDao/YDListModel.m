//
//  YDRingListModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/29.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDRingListModel.h"

@implementation YDRingListModel

- (NSString *)sex{
    if ([self.ud_sex isEqual:@1]) {
        return @"男";
    }else{
        return @"女";
    }
}

@end
