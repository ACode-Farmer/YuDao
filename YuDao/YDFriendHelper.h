//
//  YDFriendHelper.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDFriendModel.h"

@interface YDFriendHelper : NSObject

#pragma mark - # 好友

/// 好友数据(原始)
@property (nonatomic, strong) NSMutableArray<YDFriendModel *> *friendsData;

/// 格式化的好友数据（二维数组，列表用）
@property (nonatomic, strong) NSMutableArray *data;

/// 格式化好友数据的分组标题
@property (nonatomic, strong) NSMutableArray *sectionHeaders;

///  好友数量
@property (nonatomic, assign, readonly) NSInteger friendCount;

@property (nonatomic, copy  ) void(^dataChangedBlock)(NSMutableArray *data, NSMutableArray *sectionHeaders, NSInteger friendCount);


+ (YDFriendHelper *)sharedFriendHelper;

//刷新好友数据
- (void)updateFriendData:(void (^)(NSArray *data, NSArray *headers, NSInteger count))completeBlock;

- (YDFriendModel *)getFriendInfoByUserID:(NSNumber *)userID;

/**
 *  查询是否存在此好友
 *
 */
- (BOOL )friendIsInExistenceByUid:(NSNumber *)uid;

/**
 *  添加好友
 *
 */
- (BOOL )addFriendByUid:(YDFriendModel *)model;

/**
 *  删除好友
 *
 */
- (BOOL )deleteFriendByUid:(NSNumber *)uid;


@end
