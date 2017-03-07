//
//  YDLikePersonController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/3.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDLikePersonController.h"
#import "YDLikePersonController+Delegate.h"

#define kMyLikedPeopleURL @"http://www.ve-link.com/yulian/api/like"

@interface YDLikePersonController ()
{
    UIButton *_firstBtn;
    UIButton *_secondBtn;
    UIButton *_thirdBtn;
    NSMutableArray *_buttons;
}


@end

@implementation YDLikePersonController

- (id)init{
    if (self = [super init]) {
        _likedType = YDLikedPeopleTypeLikeMe;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self y_initUI];
    
    [self downloadDataWithType:self.likedType];
}

#pragma mark - Private Methods
- (void)downloadDataWithType:(YDLikedPeopleType )type{
    __weak YDLikePersonController *weakSelf = self;
    [YDNetworking getUrl:kMyLikedPeopleURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token,@"type":[NSNumber numberWithInteger:self.likedType]} progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSLog(@"Like_originalDic = %@",originalDic);
        NSArray *dataArray = [originalDic objectForKey:@"data"];
        NSMutableArray *likeArray = [YDLikePersonModel mj_objectArrayWithKeyValuesArray:dataArray];
        if (weakSelf.data) {
            [weakSelf.data removeAllObjects];
        }
        weakSelf.data = [likeArray mutableCopy];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)y_initUI{
    [self.navigationItem setTitle:@"喜欢的人"];
    
    [self registerCellClass];
    [self.tableView setTableFooterView:[UIView new]];
    self.tableView.rowHeight = 53;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor whiteColor];
}


@end
