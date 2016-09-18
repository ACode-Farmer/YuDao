//
//  HomePageTableView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "HomePageTableView.h"
#import "MenuCell.h"
#import "DrivingDataCell.h"
#import "ListTypeCell.h"
#import "ListCell.h"

#import "TableNode.h"
#import "MenuModel.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
NSString *const menuCellIdentifier = @"MenuCell";
NSString *const DrivingDataCellIdentifier = @"DrivingDataCell";
NSString *const ListTypeCellIdentifier = @"ListTypeCell";
NSString *const ListCellIdentifier = @"ListCell";
NSString *const NormalCellIdentifier = @"NormalCell";

@implementation HomePageTableView
{
    NSArray *_dataSource;
    NSMutableArray *_showData;
    NSMutableArray *_menuCellArray;
    ListTypeCell *_listTypeCell;
}


- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource{
    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
        _dataSource = dataSource;
        _menuCellArray = [NSMutableArray arrayWithCapacity:4];
        
        _showData = [self getShowDataFrom:_dataSource];
        [self registerClass:[MenuCell class] forCellReuseIdentifier:menuCellIdentifier];
        [self registerClass:[DrivingDataCell class] forCellReuseIdentifier:DrivingDataCellIdentifier];
        [self registerClass:[ListTypeCell class] forCellReuseIdentifier:ListTypeCellIdentifier];
        [self registerClass:[ListCell class] forCellReuseIdentifier:ListCellIdentifier];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NormalCellIdentifier];
        
        self.tableFooterView = [UIView new];
        self.separatorColor = [UIColor whiteColor];
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}

- (NSMutableArray *)getShowDataFrom:(NSArray *)datasource{
    
    NSMutableArray *showData = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < datasource.count; i++) {
        TableNode *node = datasource[i];
        if (node.expand) {
            [showData addObject:node];
        }
    }
    for (int i = 0; i < showData.count-1; i++) {
        for (int j = 0; j < showData.count-1; j++) {
            TableNode *node1 = [showData objectAtIndex:j];
            TableNode *node2 = [showData objectAtIndex:j+1];
            if (node1.nodeId > node2.nodeId) {
                [showData exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return showData;
}

#pragma mark dataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _showData.count > 0 ? _showData.count: 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier];
    
    TableNode *currentNode = _showData[indexPath.row];
    if (currentNode.depth.integerValue == 0) {
        if (currentNode.nodeId.integerValue != 0) {
            cell.model = currentNode.nodeData;
            if (![_menuCellArray containsObject:cell]) {
                [_menuCellArray addObject:cell];
            }
        }
        
    }else{
        if (currentNode.parentId.integerValue == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:DrivingDataCellIdentifier];
            cell.model = currentNode.nodeData;
        }
        else if (currentNode.parentId.integerValue == 6) {
            if (currentNode.nodeId.integerValue == 7) {
                cell = [tableView dequeueReusableCellWithIdentifier:ListTypeCellIdentifier];
                _listTypeCell = (ListTypeCell *)cell;
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:ListCellIdentifier];
            }
        }
        else if (currentNode.parentId.integerValue == 11){
            if (currentNode.nodeId.integerValue == 12) {
                cell = [tableView dequeueReusableCellWithIdentifier:NormalCellIdentifier];
                cell.textLabel.text = @"注册新用户";
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:NormalCellIdentifier];
                cell.textLabel.text = @"注册新用户";
            }
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:NormalCellIdentifier];
            cell.textLabel.text = @"好友动态";
        }
    }
    
    return cell;
}



/**
 *  剪切图片
 *
 *  @param image 原始图片
 *  @param rect  裁剪范围
 *
 *  @return 剪切好的图片
 */
- (UIImage*)clipImageWithImage:(UIImage*)image inRect:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, imageRef);
    UIImage* clipImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    return clipImage;
}

#pragma mark delegate - 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *table = [tableView viewWithTag:1001];
    if (table) {
        table.height = 0;
        [table removeFromSuperview];
        _listTypeCell.arrowBtn.selected = NO;
    }
    
    TableNode *clickedNode = _showData[indexPath.row];
    int depth = [clickedNode.depth intValue];
    int nodeId = [clickedNode.nodeId intValue];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect clickedRect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    
    if ((self.homeTableViewDelegate && [self.homeTableViewDelegate respondsToSelector:@selector(clickCell:rect:)] && depth != 0) || (nodeId == 0)) {
        [self.homeTableViewDelegate clickCell:clickedNode rect:clickedRect];
    }
    if (depth == 1) {
        return;
    }
    else {
        //修改箭头
        MenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        for (NSInteger i = 0; i < _menuCellArray.count; i++) {
            MenuCell *otherCell = _menuCellArray[i];
            if (otherCell.arrowBtn.selected && ![cell isEqual:otherCell]) {
                otherCell.arrowBtn.selected = !otherCell.arrowBtn.selected;
            }
        }
        cell.arrowBtn.selected = !cell.arrowBtn.selected;
        
        NSUInteger start = indexPath.row + 1;
        NSUInteger end = start;
        BOOL expand = NO;
        for (int i = 0; i < _dataSource.count; i++) {
            TableNode *node = _dataSource[i];
            if (node.parentId == clickedNode.nodeId) {
                node.expand = !node.expand;
                if (node.expand) {
                    [_showData insertObject:node atIndex:end];
                    expand = YES;
                    end++;
                }else{
                    expand = NO;
                    end = [self removeAllSonNodesAtParentNode:clickedNode];
                    break;
                }
            }
        }
        
        //得到需要修改的indexPath
        NSMutableArray *indexPathArray = [NSMutableArray array];
        for (NSUInteger i = start; i < end; i++) {
            NSIndexPath *tempIndextPath = [NSIndexPath indexPathForRow:i inSection:0];
            [indexPathArray addObject:tempIndextPath];
        }
        
        //插入或删除本节点的子节点
        if (expand) {
            [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        }else{
            [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        }
        
        //获得其它打开的节点
        NSMutableArray *otherOpen = [NSMutableArray array];
        for (TableNode *node in _showData) {
            if (node.parentId != clickedNode.nodeId && [node.depth intValue] == 1){
                if (node.expand) {
                    node.expand = !node.expand;
                    [otherOpen addObject:node];
                }
            }
        }
        //当有其他被打开节点时
        if (otherOpen.count > 0) {
            NSMutableArray *otherIndexPathArray = [NSMutableArray array];
            [_showData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (TableNode *node in otherOpen) {
                    if ([node isEqual:_showData[idx]]) {
                        NSIndexPath *tempIndextPath = [NSIndexPath indexPathForRow:idx inSection:0];
                        [otherIndexPathArray addObject:tempIndextPath];
                    }
                }
            }];
            [_showData removeObjectsInArray:otherOpen];
            [self deleteRowsAtIndexPaths:otherIndexPathArray withRowAnimation:UITableViewRowAnimationTop];
        }
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableNode *currentNode = _showData[indexPath.row];
    if (currentNode.depth.integerValue == 0) {
        return 50.0f;
    }else{
        if (currentNode.parentId.integerValue == 1) {
            return 80.0f;
        }else if (currentNode.parentId.integerValue == 6) {
            if (currentNode.nodeId.integerValue == 7) {
                return 50.0f;
            }else{
                return 270.0f;
            }
        }

    }
    return 50.0f;
}

/**
 *  删除改父节点下的所有子节点
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点位置
 */
- (NSUInteger)removeAllSonNodesAtParentNode:( TableNode *)parentNode{
    NSUInteger start = [_showData indexOfObject:parentNode];
    NSUInteger end = start;
    for (NSUInteger i = start + 1; i < _showData.count; i++) {
        TableNode *node = _showData[i];
        end++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if (end == _showData.count - 1) {
            end++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (end > start) {
        [_showData removeObjectsInRange:NSMakeRange(start + 1, end - start -1)];
    }
    return end;
}


@end
