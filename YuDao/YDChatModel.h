//
//  ChatModel.h
//  UUChatTableView
//
//  Created by shake on 15/1/6.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UUMessage.h"
#import "UUMessageFrame.h"
@interface YDChatModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) FMDatabase *dataBase;

@property (nonatomic) BOOL isGroupChat;

@property (nonatomic) NSNumber *userId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *headerUrl;

+ (YDChatModel *)chatModelWithUserId:(NSNumber *)userId name:(NSString *)name headerUrl:(NSString *)headerUrl;

//获取对应用户id的聊天记录
- (void)getHistoryChatRecordWith:(NSNumber *)userId;

//************** 测试 数据 ******************************
- (void)populateRandomDataSource;
- (void)addRandomItemsToDataSource:(NSInteger)number;

// 添加别人的item
- (UUMessageFrame *)addOthersItemWithContent:(NSDictionary *)dic;

// 添加自己的item
- (UUMessageFrame *)addSpecifiedItem:(NSDictionary *)dic;

@end
