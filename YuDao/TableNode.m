//
//  TableNode.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "TableNode.h"

@implementation TableNode


+ (instancetype)modelWithDictionary:(NSDictionary *)dic{
    TableNode *model = [[TableNode alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setDataWithArray:(NSArray *)array{
    if (array == nil) {
        return;
    }
    _nodeData = array[_dataIndex.integerValue];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%d",_parentId,_nodeId,_depth,_expand];
}

@end
