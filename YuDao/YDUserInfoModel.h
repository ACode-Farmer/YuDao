//
//  YDUserInfoModel.h
//  YuDao
//
//  Created by 汪杰 on 16/11/23.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDUserInfoModel : NSObject


@property (nonatomic, strong) NSNumber *ub_id;//用户id

@property (nonatomic, copy  ) NSString *ud_background;//用户背景
@property (nonatomic, strong) NSString *ud_face;//头像
@property (nonatomic, copy  ) NSString *ub_nickname;//名字
@property (nonatomic, strong) NSNumber *ud_sex;//性别(1->男, 2->女)

@property (nonatomic, strong) NSNumber *ud_age;//年龄
@property (nonatomic, strong) NSString *ud_constellation;//星座
@property (nonatomic, strong) NSNumber *ub_auth_grade;//认证等级
@property (nonatomic, strong) NSNumber *ud_likeunm;//喜欢的人数
@property (nonatomic, strong) NSNumber *ud_credit;//积分
@property (nonatomic, strong) NSString *vehicle;

@property (nonatomic, copy  ) NSString *ud_ftag;
@property (nonatomic, copy  ) NSString *ud_tag;
@property (nonatomic, strong) NSString *ud_tag_name;//兴趣(字符串, ","好隔开)

@property (nonatomic, strong) NSString *ud_often_province_name;//省份

@property (nonatomic, strong) NSString *ud_often_city_name;//城市

@property (nonatomic, strong) NSString *ud_often_area_name;//区
@property (nonatomic, strong) NSNumber *ud_emotion;//情感状态

@property (nonatomic, strong) NSNumber *ud_enjoy;//是否已经喜欢(0 -> 未喜欢, 1 －> 已喜欢)

@property (nonatomic, strong) NSNumber *uFriend;//是否为好友(1 -> 否, 2 －> 是)

@end
