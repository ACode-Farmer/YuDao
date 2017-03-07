//
//  YDUser.h
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDUser : NSObject

//*****************     16个string   ***********************
@property (nonatomic, copy  ) NSString    *access_token;
@property (nonatomic, copy  ) NSString    *ub_name;
@property (nonatomic, copy  ) NSString    *ub_nickname;//昵称
@property (nonatomic, copy  ) NSString    *ub_cellphone;//手机号
@property (nonatomic, copy  ) NSString    *ub_password;
@property (nonatomic, copy  ) NSString    *ud_face;//头像网址
@property (nonatomic, copy  ) NSString    *ud_constellation;
@property (nonatomic, copy  ) NSString    *ud_realname;//真实姓名

@property (nonatomic, copy  ) NSString    *ud_often_province_name;//省
@property (nonatomic, copy  ) NSString    *ud_often_city_name;//市
@property (nonatomic, copy  ) NSString    *ud_often_area_name;//区

@property (nonatomic, copy  ) NSString    *ud_tag;
@property (nonatomic, copy  ) NSString    *ud_tag_name;//兴趣,逗号隔开
@property (nonatomic, copy  ) NSString    *ud_background;//用户背景
/**
 *  用户坐标
 */
@property (nonatomic, copy  ) NSString    *ud_location;
/**
 *  用户身份证正面
 */
@property (nonatomic, copy  ) NSString    *ud_positive;
/**
 *  用户身份证反面
 */
@property (nonatomic, copy  ) NSString    *ud_negative;


//*****************     11个int   ***********************
@property (nonatomic, strong) NSNumber    *ub_id;
@property (nonatomic, strong) NSNumber    *ud_age;
@property (nonatomic, strong) NSNumber    *ud_sex;//性别(1男，2女)
@property (nonatomic, strong) NSNumber    *ud_emotion;//
/**
 *  用户认证状态 "integer,用户认证状态 0未认证 1已认证 2认证中"
 */
@property (nonatomic, strong) NSNumber    *ud_userauth;//
/**
 *  用户认证等级
 */
@property (nonatomic, strong) NSNumber    *ub_auth_grade;
@property (nonatomic, strong) NSNumber    *ud_often_city;
@property (nonatomic, strong) NSNumber    *ud_often_province;
@property (nonatomic, strong) NSNumber    *ud_often_area;
@property (nonatomic, strong) NSNumber    *ud_age_display;//

/**
 *  用户积分
 */
@property (nonatomic, strong) NSNumber    *ud_credit;

//获取用于中间转换数据的用户对象
- (YDUser *)getTempUserData;

@end
