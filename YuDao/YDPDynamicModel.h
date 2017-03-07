//
//  YDPDynamicModel.h
//  YuDao
//
//  Created by 汪杰 on 16/11/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPDynamicModel : NSObject

/**
*  评论数量
*/
@property (nonatomic, strong) NSNumber *commentCount;
/**
 *  位置经纬度
 */
@property (nonatomic, strong) NSString *location;
/**
 *  位置地点
 */
@property (nonatomic, strong) NSString *address;
/**
 *  动态id
 */
@property (nonatomic, strong) NSNumber *dynamicId;
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;
/**
 *  标签
 */
@property (nonatomic, strong) NSString *label;
/**
 *  发布动态的用户id
 */
@property (nonatomic, strong) NSNumber *dynamicUserId;
/**
 *  发布动态的时间
 */
@property (nonatomic, copy  ) NSString *time;
/**
 *  动态被查看次数
 */
@property (nonatomic, strong) NSString *lookCount;
/**
 *  点赞数
 */
@property (nonatomic, strong) NSNumber *tapLikeCount;
/**
 *  动态内容
 */
@property (nonatomic, copy  ) NSString *content;
/**
 *  是否喜欢(1->否  2->是)
 */
@property (nonatomic, strong) NSNumber *state;

/**
 *  时间所转换的可变属性字符串
 */
@property (nonatomic, copy  ) NSMutableAttributedString *attString;

@property (nonatomic, assign) YDDynamicType dynamicType;


+ (id)modelWithTime:(NSString *)time location:(NSString *)location imageArray:(NSMutableArray *)array content:(NSString *)content;

@end
