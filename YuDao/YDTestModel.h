//
//  YDTestModel.h
//  YuDao
//
//  Created by 汪杰 on 16/12/3.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDTestModel : NSObject

//车辆健康分数
@property (nonatomic,strong) NSNumber *ug_health;
//是否存在胎压
@property (nonatomic,strong) NSNumber *tirepressure;
//油量(百分比)
@property (nonatomic,strong) NSNumber *oilmass;
//故障码
@property (nonatomic,strong) NSNumber *faultcode;

//左前胎温
@property (nonatomic,strong) NSNumber *lftt;
//左前胎压
@property (nonatomic,strong) NSNumber *lftp;
//右前胎温
@property (nonatomic,strong) NSNumber *rftt;
//右前胎压
@property (nonatomic,strong) NSNumber *rftp;
//左后胎温
@property (nonatomic,strong) NSNumber *lrtt;
//左后胎压
@property (nonatomic,strong) NSNumber *lrtp;
//右后胎温
@property (nonatomic,strong) NSNumber *rrtt;
//右后胎压
@property (nonatomic,strong) NSNumber *rrtp;

//冷却液温度 (0~150)
@property (nonatomic,strong) NSNumber *sample_2;
//冷却液温度是否正常 (1正常 0 注意)
@property (nonatomic,strong) NSNumber *coolanttemp;
//电压 (0~15)
@property (nonatomic,strong) NSNumber *sample_8;
//电瓶电压 (1正常 0 注意)
@property (nonatomic,strong) NSNumber *voltage;
//安全驾驶 (1正常 0 注意)
@property (nonatomic,strong) NSNumber *safedriving;
//车辆安全 (1正常 0 注意)
@property (nonatomic,strong) NSNumber *vehiclesafety;

@end

@interface YDTestDetailModel : NSObject

@property (nonatomic, strong) NSString  *titile;

@property (nonatomic, strong) NSString *subTitle;

@property (nonatomic, copy  ) NSString  *backgImageString;

@property (nonatomic, copy  ) NSString *data;

@property (nonatomic, copy  ) NSString *oilMessage;

//*****************  胎压数据 *********************
@property (nonatomic, copy  ) NSString *lftt;
@property (nonatomic, copy  ) NSString *lftp;
@property (nonatomic, copy  ) NSString *rftt;
@property (nonatomic, copy  ) NSString *rftp;
@property (nonatomic, copy  ) NSString *lrtt;
@property (nonatomic, copy  ) NSString *lrtp;
@property (nonatomic, copy  ) NSString *rrtt;
@property (nonatomic, copy  ) NSString *rrtp;


+ (YDTestDetailModel *)modelWithTitle:(NSString *)title subTitle:(NSString *)subTitle backgImageString:(NSString *)backgImageString data:(NSString *)data oilMessage:(NSString *)oilMessage;

@end
