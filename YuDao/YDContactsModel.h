//
//  ContactsModel.h
//  YuDao
//
//  Created by 汪杰 on 16/9/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"


@interface YDContactsModel : NSObject

@property (nonatomic, assign) YDGroupDetailType groupType;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pinYin;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, strong) NSNumber *ub_id;
@property (nonatomic, assign) BOOL isJoined;

@property (nonatomic, strong) XMPPJID *jid;

//1.已经是好友了  2.已注册但不是好友  3.未注册(邀请注册)
@property (nonatomic, assign) NSInteger type;


+ (instancetype)modelWith:(NSString *)name;

+ (instancetype)modelWith:(NSString *)name imageName:(NSString *)imageName;

+ (instancetype)modelWith:(NSString *)name imageName:(NSString *)imageName groupType:(YDGroupDetailType )groupType;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;


///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

@end
