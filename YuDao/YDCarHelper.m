//
//  YDCarHelper.m
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDCarHelper.h"

static YDCarHelper *carHelper;

@interface YDCarHelper()

@property (nonatomic, strong) YDDBCarStore *carStore;


@end

@implementation YDCarHelper

+ (YDCarHelper *)sharedHelper{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        carHelper = [[YDCarHelper alloc] init];
    });
    return carHelper;
}

- (id)init{
    if (self = [super init]) {
        _carStore = [YDDBCarStore new];
        _carArray = [_carStore getAllCars];
        _defaultCar = [self defaultOrBindObdCar];
    }
    return self;
}

//刷新单利的车辆数组和默认车辆
- (void)updateCarArrayAndDefaultCar{
    _carArray = [_carStore getAllCars];
    _defaultCar = [self defaultOrBindObdCar];
}

- (void)insertOneCar:(YDCarDetailModel *)car{
    
    if ([self.carStore insertOrUpdateCar:car]) {
        NSLog(@"插入单辆车成功");
    }else{
        NSLog(@"插入单辆车失败");
    }
    [self updateCarArrayAndDefaultCar];
}

- (void)insertCars:(NSArray<YDCarDetailModel *> *)cars{
    for (YDCarDetailModel *car in cars) {
        if ([self.carStore insertOrUpdateCar:car]) {
            NSLog(@"插入多辆车成功");
        }else{
            NSLog(@"插入多辆车失败");
        }
    }
    [self updateCarArrayAndDefaultCar];
}

- (YDCarDetailModel *)getOneCarWithCarid:(NSNumber *)carid{
    return [_carStore getOneCarWithCarid:carid];
}

- (YDCarDetailModel *)defaultOrBindObdCar{
    NSMutableArray *cars = [_carStore getAllCars];
    if (cars.count == 0) {
        return nil;
    }
    if (cars.count == 1) {
        return cars.firstObject;
    }
    
    __block YDCarDetailModel *model;
    [cars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        model = obj;
        if (model.ug_boundtype.integerValue == 1 && model.ug_status.integerValue == 1) {
            *stop = YES;
        }else if (model.ug_boundtype.integerValue == 1 && model.ug_status.integerValue == 0){
            *stop = YES;
        }else if (model.ug_boundtype.integerValue == 0 && model.ug_status.integerValue == 1){
            *stop = YES;
        }else{
            model = cars.firstObject;
        }
    }];
    return model;
}

- (void)deleteAllCars{
    [_carStore deleteAllCars];
    [_carArray removeAllObjects];
    _defaultCar = nil;
}

//删除一辆车
- (void)deleteOneCar:(NSNumber *)ug_id{
    if ([self.carStore deleteOneCar:ug_id]) {
        NSLog(@"数据库删除一辆车成功");
    }else{
        NSLog(@"数据库删除一辆车失败");
    }
    [self updateCarArrayAndDefaultCar];
}

/**
 *  修改车辆的绑定OBD状态
 */
- (void)updateCarOBDStatus:(NSNumber *)uid ug_id:(NSNumber *)ug_id{
    if ([self.carStore updateCarOBDStatus:uid ug_id:ug_id]) {
        [self updateCarArrayAndDefaultCar];
    }
}

@end
