//
//  YDFriendHelper.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDFriendHelper.h"
#import "YDDBFriendStore.h"
#import "NSObject+Category.h"

#define kFriendsURL @"http://www.ve-link.com/yulian/api/friendlist"

static YDFriendHelper *friendHelper = nil;

@interface YDFriendHelper()

@property (nonatomic, strong) YDDBFriendStore *friendStore;

@end

@implementation YDFriendHelper

+ (YDFriendHelper *)sharedFriendHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        friendHelper = [[YDFriendHelper alloc] init];
    });
    return friendHelper;
}

- (id)init{
    if (self = [super init]) {
        [self updateFriendData:nil];
    }
    return self;
}

//刷新好友数据
- (void)updateFriendData:(void (^)(NSArray *data, NSArray *headers, NSInteger count))completeBlock{
    self.friendsData = [self.friendStore friendsDataByUid:[YDUserDefault defaultUser].user.ub_id];
    if (self.friendsData.count == 0) {
        return;
    }
    self.data = [self getFriendListDataBy:self.friendsData];
    self.sectionHeaders = [self getFriendListSectionBy:[self.data mutableCopy]];
    
    if (completeBlock) {
        completeBlock(self.data,self.sectionHeaders,self.friendsData.count);
    }
    
}

- (void)downloadFriendsData{
    __weak YDFriendHelper *weakSelf = self;
    [YDNetworking getUrl:kFriendsURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSLog(@"friendData = %@",originalDic);
        weakSelf.friendsData = [YDFriendModel mj_objectArrayWithKeyValuesArray:[originalDic objectForKey:@"data"]];
        
        for (YDFriendModel *model in weakSelf.friendsData) {
            NSLog(@"friend_model = %@",model);
            //将好友存入数据库
            if ([weakSelf.friendStore addFriend:model]) {
                NSLog(@"初次进入将好友加入数据库成功");
            }else{
                NSLog(@"初次进入将好友加入数据库失败");
            }
        }
        weakSelf.data = [weakSelf getFriendListDataBy:weakSelf.friendsData];
        weakSelf.sectionHeaders = [weakSelf getFriendListSectionBy:[weakSelf.data mutableCopy]];
        if (weakSelf.dataChangedBlock) {
            weakSelf.dataChangedBlock(weakSelf.data,weakSelf.sectionHeaders,weakSelf.friendsData.count);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

//获取表格右侧索引数组
- (NSMutableArray *)getIndexArrayFromDataSource:(NSMutableArray *)dataSource{
    NSMutableArray *tempIndexArray = [NSMutableArray arrayWithCapacity:30];
    NSString *tempString;
    for (YDFriendModel *model in dataSource) {
        NSString *indexString = model.firstchar;
        if (![tempString isEqualToString:indexString]) {
            [tempIndexArray addObject:indexString];
            tempString = indexString;
        }
    }
    return tempIndexArray;
}
//获取排序后的数组
- (NSMutableArray *)getDataArrayFromDataSource:(NSMutableArray *)dataSource{
    NSMutableArray *tempDataArray = [NSMutableArray arrayWithCapacity:dataSource.count];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString;
    for (YDFriendModel *model in dataSource) {
        NSString *indexString = model.firstchar;
        if (![tempString isEqualToString:indexString]) {//不同
            item = [NSMutableArray array];
            [item addObject:model];
            [tempDataArray addObject:item];
            //往下遍历
            tempString = indexString;
        }else{
            [item addObject:model];//相同
        }
    }
    return tempDataArray;
}

#pragma mark - Public Methods -
- (YDFriendModel *)getFriendInfoByUserID:(NSNumber *)userID
{
    if (userID == nil) {
        return nil;
    }
    for (YDFriendModel *friend in self.friendsData) {
        if ([friend.friendid isEqual:userID]) {
            return friend;
        }
    }
    return nil;
}

- (BOOL )friendIsInExistenceByUid:(NSNumber *)uid{
    return [self.friendStore friendIsInExistenceByUid:uid];
}

- (BOOL )addFriendByUid:(YDFriendModel *)model{
    return [self.friendStore addFriend:model];
}

- (BOOL )deleteFriendByUid:(NSNumber *)uid{
    return [self.friendStore deleteFriendByFid:uid forUid:[YDUserDefault defaultUser].user.ub_id];
}




#pragma mark - Getter -
- (YDDBFriendStore *)friendStore{
    if (!_friendStore) {
        _friendStore = [YDDBFriendStore new];
    }
    return _friendStore;
}

@end
