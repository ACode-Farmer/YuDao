//
//  YDSingleRankingController.m
//  YuDao
//
//  Created by 汪杰 on 2017/1/3.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDSingleRankingController.h"
#import "YDUserFilesController.h"

@interface YDSingleRankingController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate >

@property (nonatomic, strong) UICollectionView   *collectionView;//前三名视图

@property (nonatomic, strong) UITableView        *tableView;//第三名以后视图

@property (nonatomic, strong) UIView           *bottomView;//底部浮动栏

@property (nonatomic, strong) NSArray           *rankTypeArray;//排行榜类型数组

@property (nonatomic, strong) NSArray           *rankImageUrlArray;//排行榜前三名旗帜数组

@property (nonatomic, copy  ) NSString          *rankTypeString;//当前排行榜类型字符串

@end

@implementation YDSingleRankingController

- (instancetype)initWithDataType:(YDRankingListDataType )dataType{
    if (self = [super init]) {
        _dataType = dataType;
        //生成初始化参数
        NSLog(@"self.dataType-1 = %ld",_dataType-1);
        _rankTypeString = [self.rankTypeArray objectAtIndex:self.dataType-1];
        NSString *access_token = [YDUserDefault defaultUser].user.access_token;
        self.parameters = @{@"access_token":access_token? access_token : @"0",
                            @"rankingtype":_rankTypeString};
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    
    
    //[self downloadRankingListData:self.dataType parameters:(NSMutableDictionary *)self.parameters];
    
}

#pragma mark - Private Methods
- (void)downloadRankingListData:(NSInteger )index parameters:(NSDictionary *)parameters{
    
    NSMutableDictionary *tempParameter = [parameters mutableCopy];
    [tempParameter setObject:_rankTypeString forKey:@"rankingtype"];
    
    YDWeakSelf(self);
    NSLog(@"parameters = %@",tempParameter);
    [YDNetworking getUrl:kAllRankinglistURL parameters:tempParameter progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        //NSLog(@"listData = %@",originalDic);
        NSArray *dataArray = [originalDic objectForKey:@"data"];
        _allData = [YDListModel mj_objectArrayWithKeyValuesArray:dataArray];
        if (_allData.count > 2 && _allData.count != 0) {
            weakself.headerData = [_allData subarrayWithRange:NSMakeRange(0, 3)];
        }else{
            weakself.headerData = nil;
        }
        if (_allData.count > 3) {
            if (_allData.count > 10) {
                weakself.data = [_allData subarrayWithRange:NSMakeRange(3, _allData.count-4)];
            }else{
                weakself.data = [_allData subarrayWithRange:NSMakeRange(3, _allData.count-3)];
            }
        }else{
            weakself.data = nil;
        }
        
        for (YDListModel *model in _allData) {
            if (model.ranking) {//获取当前用户数据
                weakself.myselfModel = model;
                if (model.ranking.integerValue <= 10) {//当前用户是否在前十
                    weakself.isTopTen = YES;
                }else{
                    weakself.isTopTen = NO;
                }
            }
            
        }
        if (weakself.downloadDataCompletionBlock) {
            weakself.downloadDataCompletionBlock(_allData);
        }
        [weakself.collectionView reloadData];
        [weakself.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"下载排行榜数据失败 error = %@",error);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.headerData? self.headerData.count : 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YDSingleRankingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YDSingleRankingCollectionCell" forIndexPath:indexPath];
    cell.type = self.dataType;
    cell.item = self.headerData[indexPath.row];
    cell.rankImageV.image = [UIImage imageNamed:self.rankImageUrlArray[indexPath.row]];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YDListModel *model = self.headerData[indexPath.row];
    UIViewController *parentViewController = [UIViewController getCurrentVC];
    YDUserFilesController *userVC = [YDUserFilesController new];
    userVC.currentUserId = model.ub_id;
    [parentViewController.navigationController pushViewController:userVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data ? self.data.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDSingleRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDSingleRankingCell"];
    cell.type = self.dataType;
    cell.model = self.data[indexPath.row];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 4];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YDListModel *model = self.data[indexPath.row];
    UIViewController *parentViewController = [UIViewController getCurrentVC];
    YDUserFilesController *userVC = [YDUserFilesController new];
    userVC.currentUserId = model.ub_id;
    [parentViewController.navigationController pushViewController:userVC animated:YES];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(110, 160);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 12;
        
        CGFloat width = (110*3 + 12 *2);
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake((screen_width-width)/2, 0,width ,170) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.scrollEnabled = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[YDSingleRankingCollectionCell class] forCellWithReuseIdentifier:@"YDSingleRankingCollectionCell"];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"EmptyCell"];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 108)];
        _tableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] init];
            view.frame = CGRectMake(0, 0, self.view.frame.size.width,180);
            [view addSubview:self.collectionView];
            view;
        });
        [_tableView registerClass:[YDSingleRankingCell class] forCellReuseIdentifier:@"YDSingleRankingCell"];
        _tableView.rowHeight = 56.f;
        _tableView.separatorColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 45)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


- (NSArray *)rankTypeArray{
    if (!_rankTypeArray) {
        _rankTypeArray = @[@"speed",
                        @"mileage",
                        @"oilwear",
                        @"stranded",
                        @"credit",
                        @"enjoy"];
    }
    return _rankTypeArray;
}

- (NSArray *)rankImageUrlArray{
    if (!_rankImageUrlArray) {
        _rankImageUrlArray = @[@"rankinglist_1st",
                               @"rankinglist_2sd",
                               @"rankinglist_3th"];
    }
    return _rankImageUrlArray;
}

@end
