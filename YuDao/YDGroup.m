//
//  YDGroup.m
//  YuDao
//
//  Created by 汪杰 on 16/10/24.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGroup.h"
#import "NSString+PinYin.h"


@implementation YDGroup

- (id)init
{
    if (self = [super init]) {
        [YDGroup mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"users" : @"TLUser" };
        }];
    }
    return self;
}

- (NSInteger)count
{
    return self.users.count;
}

- (void)addObject:(id)anObject
{
    [self.users addObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.users objectAtIndex:index];
}

- (YDUser *)memberByUserID:(NSString *)uid
{
//    for (YDUser *user in self.users) {
//        if ([user.userID isEqualToString:uid]) {
//            return user;
//        }
//    }
    return nil;
}

- (NSString *)groupName
{
//    if (_groupName == nil || _groupName.length == 0) {
//        for (YDUser *user in self.users) {
//            if (user.showName.length > 0) {
//                if (_groupName == nil || _groupName.length <= 0) {
//                    _groupName = user.showName;
//                }
//                else {
//                    _groupName = [NSString stringWithFormat:@"%@,%@", _groupName, user.showName];
//                }
//            }
//        }
//    }
    return _groupName;
}

- (NSString *)myNikeName
{
//    if (_myNikeName.length == 0) {
//        _myNikeName = [YDUserDefault defaultUser].user.showName;
//    }
    return _myNikeName;
}

- (NSString *)pinyin
{
    if (_pinyin == nil) {
        _pinyin = self.groupName.pinyin;
    }
    return _pinyin;
}

- (NSString *)pinyinInitial
{
    if (_pinyinInitial == nil) {
        _pinyinInitial = self.groupName.pinyinInitial;
    }
    return _pinyinInitial;
}

- (NSString *)groupAvatarPath
{
    if (_groupAvatarPath == nil) {
        _groupAvatarPath = [self.groupID stringByAppendingString:@".png"];
    }
    return _groupAvatarPath;
}

@end
