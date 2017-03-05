//
//  YDFriendStore.h
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDBBaseStore.h"

@interface YDFriendStore : YDDBBaseStore

- (BOOL)updateFriendsData:(NSArray *)friendData
                   forUid:(NSString *)uid;

- (BOOL)addFriend:(YDUser *)user forUid:(NSString *)uid;

- (NSMutableArray *)friendsDataByUid:(NSString *)uid;

- (BOOL)deleteFriendByFid:(NSString *)fid forUid:(NSString *)uid;

@end
