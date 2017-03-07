//
//  YDFriendStore.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDBBaseStore.h"
#import "YDFriendModel.h"

@interface YDDBFriendStore : YDDBBaseStore



/**
 *  添加好友
 *
 */
- (BOOL)addFriend:(YDFriendModel *)user;

/**
 *  获得所有好友
 *
 */
- (NSMutableArray *)friendsDataByUid:(NSNumber *)uid;

/**
 *  查询是否存在此好友
 *
 */
- (BOOL )friendIsInExistenceByUid:(NSNumber *)uid;

/**
 *  删除好友
 *
 */
- (BOOL)deleteFriendByFid:(NSNumber *)fid forUid:(NSNumber *)uid;


@end
