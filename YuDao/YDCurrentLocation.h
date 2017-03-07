//
//  YDCurrentLocation.h
//  YuDao
//
//  Created by 汪杰 on 16/11/30.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "YDPoiModel.h"

#import <BaiduMapAPI_Search/BMKSearchComponent.h> // 引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationService.h> // 定位相关的头文件

@interface YDCurrentLocation : NSObject


@property (nonatomic, strong) BMKUserLocation    *oldLocation;   ///< 旧的位置

@property (nonatomic, strong) BMKLocationService *locService;    ///< 百度地图管理类

@property (nonatomic, copy  ) NSString        *city;            // 城市
@property (nonatomic, strong) NSString        *userStreetAddress;//用户街道地址

@property (nonatomic, assign) CLLocationCoordinate2D  coordinate; //用户坐标

@property (nonatomic, assign) CLLocationCoordinate2D  carCoordinate; //车辆坐标

//用户位置改变的回调
@property (nonatomic, copy  ) void(^locationChangeBlock)(NSString *location,CLLocationCoordinate2D coordinate);

//用户位置改变的回调
@property (nonatomic, copy  ) void(^mapLocationChangeBlock)(BMKUserLocation *location);

@property (nonatomic, copy  ) NSString  *currentLocation; //当前用户位置

@property (nonatomic, strong) YDPoiModel *currentPoiModel;//当前用户poi位置

+ (YDCurrentLocation *)shareCurrentLocation;

//开始定位
- (void)startUserLocation;
//关闭定位
- (void)stopUserLocation;

@end
