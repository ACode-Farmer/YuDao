//
//  YDFriendStore.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDBFriendStore.h"
#import "YDDBFriendSQL.h"
#import "YDDBManager.h"
#import "NSObject+Category.h"

@implementation YDDBFriendStore

- (id)init{
    if (self = [super init]) {
        self.dbQueue = [YDDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB:好友表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_FRIENDS_TABLE, FRIENDS_TABLE_NAME];
    return [self createTable:FRIENDS_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addFriend:(YDFriendModel *)user{
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_FRIEND, FRIENDS_TABLE_NAME];
    YDFriendModel *tempClass = [user checkAndChangeObjectPropertyValue];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        tempClass.friendid,
                        tempClass.currentUserid,
                        tempClass.friendImage,
                        tempClass.friendName,
                        tempClass.friendGrade,
                        tempClass.firstchar,nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (BOOL)deleteFriendByFid:(NSNumber *)fid forUid:(NSNumber *)uid{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_FRIEND, FRIENDS_TABLE_NAME, uid.integerValue, fid.integerValue];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}


//f_ub_id, ud_face, ub_nickname, ub_auth_grade, f_firstchar, ub_id
- (NSMutableArray *)friendsDataByUid:(NSNumber *)uid{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_FRIENDS, FRIENDS_TABLE_NAME, uid.integerValue];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            YDFriendModel *user = [[YDFriendModel alloc] init];
            user.friendid = [NSNumber numberWithInt:[retSet intForColumn:@"friendid"]];
            user.friendImage = [retSet stringForColumn:@"friendImage"];
            user.friendName = [retSet stringForColumn:@"friendName"];
            user.friendGrade = [NSNumber numberWithInt:[retSet intForColumn:@"friendGrade"]];
            user.firstchar = [retSet stringForColumn:@"firstchar"];
            user.currentUserid = [NSNumber numberWithInt:[retSet intForColumn:@"currentUserid"]];
            [data addObject:user];
        }
        [retSet close];
    }];
    
    return data;
}

/**
 *  查询是否存在此好友
 *
 */
- (BOOL )friendIsInExistenceByUid:(NSNumber *)uid{
    
    return NO;
}
@end
