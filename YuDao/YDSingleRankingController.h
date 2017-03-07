//
//  YDSingleRankingController.h
//  YuDao
//
//  Created by 汪杰 on 2017/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDViewController.h"

#import "YDSingleRankingCell.h"
#import "YDSingleRankingCollectionCell.h"

@interface YDSingleRankingController : YDViewController

@property (nonatomic, copy ) void (^downloadDataCompletionBlock)(NSArray *data);//下载数据完成回调

@property (nonatomic, assign) YDRankingListDataType dataType;//数据类型(注:请在model之前赋值)

@property (nonatomic, strong) NSArray *allData; //全部数据

@property (nonatomic, strong) NSArray<YDListModel *> *headerData;//前三名数据

@property (nonatomic, strong) NSArray<YDListModel *> *data;//后七名数据

@property (nonatomic, strong) NSDictionary         *parameters;//初始化请求参数

@property (nonatomic, strong) YDListModel         *myselfModel;//(当前用户的排名数据,可能会空)
@property (nonatomic, assign) BOOL               isTopTen;//当前用户是否在前十名

- (instancetype)initWithDataType:(YDRankingListDataType )dataType;

//下载排行榜数据(index -> 根据dataType下载不同数据, paramters -> 参数,用于筛选数据)
- (void)downloadRankingListData:(NSInteger )index parameters:(NSDictionary *)parameters;

@end
