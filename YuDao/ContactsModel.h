//
//  ChineseString.h
//  https://github.com/c6357/YUChineseSorting
//
//  Created by BruceYu on 15/4/19.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"

@interface ContactsModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pinYin;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *phoneNumber;

//1.已经是好友了  2.已注册但不是好友  3.未注册(邀请注册)
@property (nonatomic, assign) NSInteger *type;

+ (instancetype)modelWith:(NSString *)name imageName:(NSString *)imageName;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;


///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

@end