//
//  YDFriendModel.m
//  YuDao
//
//  Created by 汪杰 on 16/11/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDFriendModel.h"
#import "NSString+PinYin.h"

@implementation YDFriendModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"friendid":@"f_ub_id",
             @"friendImage":@"ud_face",
             @"friendName":@"ub_nickname",
             @"friendGrade":@"ub_auth_grade",
             @"firstchar":@"f_firstchar",
             @"currentUserid":@"ub_id"};
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",self.friendid,self.friendImage,self.friendName,self.friendGrade,self.firstchar,self.currentUserid];
}

- (XMPPJID *)jid{
    return [XMPPJID jidWithUser:[NSString stringWithFormat:@"%@",self.friendid] domain:@"ve-link.com" resource:@"iphone"];
}

- (NSString *)pinyin{
    return [self.friendName pinyin];
}

- (NSString *)pinyinInitial{
    return [self.friendName pinyinInitial];
}


@end
