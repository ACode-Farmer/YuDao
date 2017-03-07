//
//  YDDynamicDetailModel.h
//  YuDao
//
//  Created by 汪杰 on 16/11/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  动态详情模型
 */
@interface YDDynamicDetailModel : NSObject

@property (nonatomic, strong) NSNumber *d_id;
//动态内容
@property (nonatomic, strong) NSString *d_details;
//动态标签
@property (nonatomic, strong) NSString *d_label;
@property (nonatomic, strong) NSNumber *ub_id;
@property (nonatomic, strong) NSArray *d_image;
@property (nonatomic, strong) NSString *d_address;
@property (nonatomic, strong) NSString *d_location;
@property (nonatomic, strong) NSNumber *d_look;//查看次数
@property (nonatomic, strong) NSString *d_issuetime;//发布时间
@property (nonatomic, strong) NSString *d_time;
@property (nonatomic, strong) NSString *ub_nickname;
@property (nonatomic, strong) NSNumber *ud_sex;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSNumber *ub_auth_grade;
@property (nonatomic, strong) NSString *ud_face;

@property (nonatomic, strong) NSMutableArray *taplike;
@property (nonatomic, strong) NSMutableArray *commentdynamic;

@end

/**
 *  点击喜欢的模型
 */
@interface YDTapLikeModel : NSObject

@property (nonatomic, strong) NSNumber *tl_id;
@property (nonatomic, strong) NSNumber *d_id;
@property (nonatomic, strong) NSNumber *ub_id;
@property (nonatomic, strong) NSNumber *tl_type;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *tl_time;
@property (nonatomic, strong) NSString *ud_face;

@end

/**
 *  动态评论模型
 */
@interface YDDynamicCommentModel : NSObject

@property (nonatomic, strong) NSNumber *d_id;
@property (nonatomic, strong) NSString *ub_nickname;
@property (nonatomic, strong) NSString *cd_date;
@property (nonatomic, strong) NSString *cd_details;
@property (nonatomic, strong) NSNumber *ub_id;
@property (nonatomic, strong) NSNumber *cd_id;
@property (nonatomic, strong) NSString *ud_face;
@property (nonatomic, strong) NSNumber *cd_pid;

@end

