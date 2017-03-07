//
//  YDPOIController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPOIController.h"
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>



@interface YDPOIController ()<BMKGeneralDelegate,CLLocationManagerDelegate,BMKLocationServiceDelegate,
BMKGeoCodeSearchDelegate,CLLocationManagerDelegate,BMKPoiSearchDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray *poiArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YDPOIController
{
    BMKUserLocation    *_oldLocation;
    BMKLocationService *_locService;
    BMKGeoCodeSearch   *_geoCodeSearch;
    BMKPoiSearch       *_poiSearch;
    
    NSTimer           *_timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self y_initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [YDMBPTool showLoading];
    _locService.delegate = self;
    _geoCodeSearch.delegate = self;
    _poiSearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _locService.delegate = nil;
    _geoCodeSearch.delegate = nil;
    _poiSearch.delegate = nil;
}

#pragma mark - Private Methods
- (void)y_initUI{
    [self.navigationItem setTitle:@"位置"];
    [self.view addSubview:self.tableView];

    _poiArray = [NSMutableArray arrayWithCapacity:20];
    _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    _locService = [[BMKLocationService alloc] init];
    [_locService startUserLocationService];
    
    _poiSearch = [[BMKPoiSearch alloc]init];
 
    
}


/** 逆地理编码 */
- (void)reverseLocation:(BMKUserLocation *)userLocation {
    // 定位成功后的 经纬度 -> 逆地理编码 -> 文字地址
    if (_oldLocation) {
        // CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        CLLocationCoordinate2D pt;
        if (_oldLocation) {
            pt.longitude = _oldLocation.location.coordinate.longitude;
            pt.latitude = _oldLocation.location.coordinate.latitude;
        }
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

#pragma mark - BMKLocationServiceDelegate - 用户位置更新后调用
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    _oldLocation = userLocation;
    if (_poiArray.count == 0) {
        
        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
        option.pageIndex = 0;
        option.pageCapacity = 50;
        option.location = _oldLocation.location.coordinate;
        
        option.keyword = @"汽车服务";
        option.radius = 2000;
        option.sortType = BMK_POI_SORT_BY_DISTANCE;
        BOOL flag = [_poiSearch poiSearchNearBy:option];
        if(flag){
            NSLog(@"周边检索发送成功");
        }else{
            NSLog(@"周边检索发送失败");
        }
    }
    // 经纬度反编码
    [self reverseLocation:userLocation];
}
#pragma mark --BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    [YDMBPTool hideAlert];
    NSLog(@"errorCode = %u",errorCode);
    if (errorCode == BMK_SEARCH_NO_ERROR)
    {
        for (int i = 0; i < poiResult.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            YDPoiModel *model =  [YDPoiModel new];
            model.name = poi.name;
            model.address = poi.address;
            model.lat = poi.pt.latitude;
            model.lon = poi.pt.longitude;
            [_poiArray addObject:model];
        }
        [self.tableView reloadData];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.poiArray ? self.poiArray.count :0 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *poiCellID = @"poiCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:poiCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:poiCellID];
        cell.detailTextLabel.textColor = [UIColor colorTextGray];
    }
    YDPoiModel *model = self.poiArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text  = model.address;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDPoiModel *poiModel = self.poiArray[indexPath.row];
    if (self.poiSearchCompeleteBlock) {
        self.poiSearchCompeleteBlock(poiModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
//MARK: Getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 0, screen_width, screen_height-64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView setTableFooterView:[UIView new]];
    }
    return _tableView;
}

@end
