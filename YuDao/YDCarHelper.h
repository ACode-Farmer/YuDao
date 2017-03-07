//
//  YDCarHelper.h
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDCarDetailModel.h"
#import "YDDBCarStore.h"

@interface YDCarHelper : NSObject

@property (nonatomic, strong) NSMutableArray *carArray;

@property (nonatomic, strong) YDCarDetailModel *defaultCar;


+ (YDCarHelper *) sharedHelper;

/**
 *  获取id对应车辆
 *
 *  @param carid ug_id
 *
 *  @return 车辆详细数据
 */
- (YDCarDetailModel *)getOneCarWithCarid:(NSNumber *)carid;
/**
 *  插入一辆车
 *
 *  @param car 车
 */
- (void)insertOneCar:(YDCarDetailModel *)car;


/**
 *  插入多辆车
 *
 *  @param cars 辆车数组
 */
- (void)insertCars:(NSArray<YDCarDetailModel *> *)cars;

//删除所有车辆
- (void)deleteAllCars;

//删除一辆车
- (void)deleteOneCar:(NSNumber *)ug_id;

/**
 *  获取默认车辆id
 *
 *  @return 车辆id
 */
- (YDCarDetailModel *)defaultOrBindObdCar;

/**
 *  修改车辆的绑定OBD状态
 */
- (void)updateCarOBDStatus:(NSNumber *)uid ug_id:(NSNumber *)ug_id;

@end
