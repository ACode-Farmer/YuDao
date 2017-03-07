//
//  YDDBCarStore.m
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDBCarStore.h"
#import "YDDBCarSQL.h"
#import "YDDBManager.h"
#import "NSObject+Category.h"
@implementation YDDBCarStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [YDDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 车库表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_CAR_TABLE, CAR_TABLE_NAME];
    return [self createTable:CAR_TABLE_NAME withSQL:sqlString];
}

- (BOOL)insertOrUpdateCar:(YDCarDetailModel *)car{
    YDCarDetailModel * tempClass = [car checkAndChangeObjectPropertyValue];
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_CAR,CAR_TABLE_NAME];
    
    NSArray *arrayPara = [NSArray arrayWithObjects:
                          tempClass.ug_status,
                          tempClass.ug_boundtype,
                          tempClass.ug_plate_title,
                          tempClass.ug_city,
                          tempClass.ug_brand_logo,
                          tempClass.ug_province,
                          tempClass.ug_city_name,
                          tempClass.ug_brand_name,
                          tempClass.vb_id,
                          tempClass.vm_id,
                          tempClass.ug_vehicle_auth,
                          tempClass.ug_series_name,
                          tempClass.ug_plate,
                          tempClass.ug_province_name,
                          tempClass.ug_engine,
                          tempClass.wz_date,
                          tempClass.ug_annual_inspection,
                          tempClass.ug_maintenance,
                          tempClass.ug_id,
                          tempClass.ub_id.integerValue == 0 ?[YDUserDefault defaultUser].user.ub_id : car.ub_id,
                          tempClass.vs_id,
                          tempClass.ug_model_name,
                          tempClass.ug_frame_number,
                          tempClass.ug_positive,
                          tempClass.ug_negative,
                          tempClass.bo_imei,
                          nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrayPara];
    return ok;
}
- (NSMutableArray *)getAllCars{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CARS, CAR_TABLE_NAME,[YDUserDefault defaultUser].user.ub_id.integerValue];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            YDCarDetailModel *car = [self y_createCarBy:retSet];
            [data addObject:car];
        }
        [retSet close];
    }];
    return data;
}

- (YDCarDetailModel *)getOneCarWithCarid:(NSNumber *)carid{
    __block YDCarDetailModel *car = [YDCarDetailModel new];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_CAR,CAR_TABLE_NAME,carid? [carid integerValue]:0,[YDUserDefault defaultUser].user.ub_id.integerValue];
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *reSet) {
        while ([reSet next]) {
            car = [self y_createCarBy:reSet];
        }
        [reSet close];
    }];
    return car;
}

- (YDCarDetailModel *)y_createCarBy:(FMResultSet *)reSet{
    YDCarDetailModel * car = [[YDCarDetailModel alloc] init];
    car.ug_status = [NSNumber numberWithInt:[reSet intForColumn:@"ug_status"]];
    car.ug_boundtype = [NSNumber numberWithInt:[reSet intForColumn:@"ug_boundtype"]];
    car.ug_plate_title = [reSet stringForColumn:@"ug_plate_title"];
    car.ug_city = [reSet stringForColumn:@"ug_city"];
    car.ug_brand_logo = [reSet stringForColumn:@"ug_brand_logo"];
    car.ug_province = [reSet stringForColumn:@"ug_province"];
    car.ug_city_name = [reSet stringForColumn:@"ug_city_name"];
    car.ug_brand_name = [reSet stringForColumn:@"ug_brand_name"];
    car.vb_id = [NSNumber numberWithInt:[reSet intForColumn:@"vb_id"]];
    car.vm_id = [NSNumber numberWithInt:[reSet intForColumn:@"vm_id"]];
    car.ug_vehicle_auth = [NSNumber numberWithInt:[reSet intForColumn:@"ug_vehicle_auth"]];
    car.ug_series_name = [reSet stringForColumn:@"ug_series_name"];
    car.ug_plate = [reSet stringForColumn:@"ug_plate"];
    car.ug_province_name = [reSet stringForColumn:@"ug_province_name"];
    car.ug_engine = [reSet stringForColumn:@"ug_engine"];
    car.wz_date = [reSet stringForColumn:@"wz_date"];
    car.ug_annual_inspection = [NSNumber numberWithInt:[reSet intForColumn:@"ug_annual_inspection"]];
    car.ug_maintenance = [NSNumber numberWithInt:[reSet intForColumn:@"ug_maintenance"]];
    car.ug_id = [NSNumber numberWithInt:[reSet intForColumn:@"ug_id"]];
    car.ub_id = [NSNumber numberWithInt:[reSet intForColumn:@"ub_id"]];
    car.vs_id = [NSNumber numberWithInt:[reSet intForColumn:@"vs_id"]];
    car.ug_model_name = [reSet stringForColumn:@"ug_model_name"];
    car.ug_frame_number = [reSet stringForColumn:@"ug_frame_number"];
    car.ug_positive = [reSet stringForColumn:@"ug_positive"];
    car.ug_negative = [reSet stringForColumn:@"ug_negative"];
    car.bo_imei = [reSet stringForColumn:@"ug_negative"];
    return car;
}

- (BOOL)deleteAllCars{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_ALL_CARS,CAR_TABLE_NAME];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

/**
 *  删除一辆车
 *
 *  @return YES 删除成功  NO 删除失败
 */
- (BOOL)deleteOneCar:(NSNumber *)ug_id{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_CAR,CAR_TABLE_NAME,ug_id,[YDUserDefault defaultUser].user.ub_id];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

/**
 *  修改车辆的绑定OBD状态
 */
- (BOOL)updateCarOBDStatus:(NSNumber *)uid ug_id:(NSNumber *)ug_id{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_CAR_OBD_STATUS,CAR_TABLE_NAME,uid,ug_id];
    BOOL ok = [self excuteSQL:sqlString];
    if (ok) {
        NSLog(@"修改车辆OBD状态成功");
    }else{
        NSLog(@"修改车辆OBD状态失败");
    }
    return ok;
}

@end
