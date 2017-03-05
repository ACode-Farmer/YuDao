//
//  YDRingListModel.h
//  YuDao
//
//  Created by 汪杰 on 16/11/29.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDRingListModel : NSObject
/*"ub_id": 1,
 "ub_nickname": "我是谁",
 "ub_auth_grade": 1,
 "ud_face": "http://www.ve-link.com/yulian/files/8/9/ee/4a31aa8078efe20c13d8ee712e6da7cf7922ee98.jpg",
 "ud_location": null,
 "ud_age": 26,
 "ud_sex": 1,
 "ud_tag": "11,8,5",
 "ud_tag_name": "歌舞话剧,跑步,网购",
 "ud_userauth": 2,
 "ud_age_display": 0,
 "ud_credit": 1200*/

@property (nonatomic, strong) NSNumber *ub_id;
@property (nonatomic, strong) NSString *ub_nickname;
@property (nonatomic, strong) NSNumber *ub_auth_grade;
@property (nonatomic, strong) NSString *ud_face;
@property (nonatomic, strong) NSString *ud_location;
@property (nonatomic, strong) NSNumber *ud_age;
@property (nonatomic, strong) NSNumber *ud_sex;
@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *ud_tag_name;
@property (nonatomic, strong) NSNumber *ud_userauth;
@property (nonatomic, strong) NSNumber *ud_age_display;
@property (nonatomic, strong) NSNumber *ud_credit;


@end
