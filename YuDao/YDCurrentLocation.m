//
//  YDCurrentLocation.m
//  YuDao
//
//  Created by 汪杰 on 16/11/30.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDCurrentLocation.h"

@interface YDCurrentLocation()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate>


@property (nonatomic, strong) BMKGeoCodeSearch   *geoCodeSearch; // 百度逆地理编码

@property (nonatomic, strong) NSTimer            *timer; //定时器，上传用户位置

@end

static YDCurrentLocation *currLocation = nil;

@implementation YDCurrentLocation
+ (YDCurrentLocation *)shareCurrentLocation{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currLocation = [[YDCurrentLocation alloc] init];
    });
    return currLocation;
}

- (id)init{
    if (self = [super init]) {
        
        _currentPoiModel = [YDPoiModel new];
        
//*************  初始化定位服务  *******************
        _locService = [[BMKLocationService alloc]init];
        // 设定定位的最小更新距离
        _locService.distanceFilter = 100.f;
        // 指定定位是否会被系统自动暂停。默认为YES
        _locService.pausesLocationUpdatesAutomatically = NO;
        //指定定位：是否允许后台定位更新。默认为NO
        _locService.allowsBackgroundLocationUpdates = YES;
        _locService.delegate = self;
        
//*************  初始地理位置编码  *******************
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
        // 开始定位
        [_locService startUserLocationService];
        
//*************  初始定时器上传位置  *******************
        _timer = [NSTimer scheduledTimerWithTimeInterval:180.f target:self selector:@selector(uploadUserLocation:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)dealloc{
    _locService.delegate = nil;
    _geoCodeSearch.delegate = nil;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - Private Methods - 上传用户位置
- (void)uploadUserLocation:(id)sender{
    NSString *access_token = [YDUserDefault defaultUser].user.access_token;
    NSString *ud_location = [NSString stringWithFormat:@"%f,%f",self.coordinate.longitude,self.coordinate.latitude];
    NSString *city = self.city;
    if (YDHadLogin && access_token && ud_location && city && city.length > 1) {
        NSString *subCity = [city substringWithRange:NSMakeRange(0, city.length-1)];
        NSDictionary *paramters = @{@"access_token":access_token?access_token:@"",
                                    @"ud_location":ud_location?ud_location:@"",
                                    @"ud_city":subCity?subCity:@""};
        NSLog(@"subCity = %@",subCity);
        NSLog(@"位置paramters = %@",paramters);
        [YDNetworking postUrl:kUploadUserLocationUrl parameters:paramters success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *response = [responseObject mj_JSONObject];
            NSLog(@"response = %@",response);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"上传用户位置失败,error = %@",error);
        }];
    }
    
}

#pragma mark - Public Methods
- (void)startUserLocation{
    [_locService startUserLocationService];
    _locService.delegate = self;
    _geoCodeSearch.delegate = self;
}
- (void)stopUserLocation{
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    _geoCodeSearch.delegate = nil;
}

/**
 *  用户位置更新后，会调用此函数
 *  @param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    _oldLocation = userLocation;
    _coordinate = userLocation.location.coordinate;
    // 经纬度反编码
    [self reverseLocation:userLocation];
    if (self.mapLocationChangeBlock) {
        self.mapLocationChangeBlock(userLocation);
    }
}

/** 逆地理编码 */
- (void)reverseLocation:(BMKUserLocation *)userLocation {
    // 定位成功后的 经纬度 -> 逆地理编码 -> 文字地址
    if (userLocation) {
        // CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        CLLocationCoordinate2D pt;
        
        pt.longitude = userLocation.location.coordinate.longitude;
        pt.latitude = userLocation.location.coordinate.latitude;
        
        _currentPoiModel.lon = pt.longitude;
        _currentPoiModel.lat = pt.latitude;
        
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        [_geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    }
}

/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (result.poiList && result.poiList.count > 0) {
        BMKPoiInfo *poiInfo = result.poiList[0];
        self.currentLocation = poiInfo.name;
        _currentPoiModel.name = self.currentLocation;
        if (self.locationChangeBlock) {
            self.locationChangeBlock(poiInfo.name,_coordinate);
        }
    }
    if (error == 0) {
        BMKAddressComponent *addDetail = result.addressDetail;
        
        self.userStreetAddress = [addDetail.streetName stringByAppendingString:addDetail.streetNumber];
        self.city = addDetail.city;
        NSLog(@"addDetail.city = %@",addDetail.city);
    }
}

@end
