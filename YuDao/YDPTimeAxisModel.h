//
//  YDPTimeAxisModel.h
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDPTimeAxisModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSMutableArray *picArray;
@property (nonatomic, copy) NSString *likeBtnTitle;
@property (nonatomic, copy) NSString *commentBtnTitle;


@end
