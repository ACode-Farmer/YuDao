//
//  TableNode.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableNode : NSObject

@property (nonatomic , assign) NSNumber *parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) NSNumber *nodeId;//本节点的id

@property (nonatomic , assign) NSNumber *depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态

@property (nonatomic, assign) NSNumber *dataIndex;//数据索引

@property (nonatomic , strong) id nodeData;//本节点的数据


+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

- (void)setDataWithArray:(NSArray<id> *)array;

@end
