//
//  YDPOIController.h
//  YuDao
//
//  Created by 汪杰 on 16/11/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDViewController.h"
#import "YDPoiModel.h"

@interface YDPOIController : YDViewController

@property (nonatomic, copy  ) void(^poiSearchCompeleteBlock)(YDPoiModel *poiModel);

@end
