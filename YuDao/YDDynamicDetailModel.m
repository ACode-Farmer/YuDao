//
//  YDDynamicDetailModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDynamicDetailModel.h"

@implementation YDDynamicDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"taplike":@"YDTapLikeModel",
             @"commentdynamic":@"YDDynamicCommentModel"};
}

- (NSString *)sex{
    if ([self.ud_sex isEqual:@1]) {
        return @"男";
    }else{
        return @"女";
    }
}

@end


/**
 *  点击喜欢的模型
 */
@implementation YDTapLikeModel



@end


/**
 *  动态评论模型
 */
@implementation YDDynamicCommentModel



@end