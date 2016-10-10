//
//  YDListTableView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/10.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListViewModel;

@protocol YDListTableViewDelegate <NSObject>

- (void)ListTableViewWithName:(NSString *)name;

@end

@interface YDListTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<YDListTableViewDelegate> listTableViewDelegate;

- (instancetype)initWithDataSource:(NSMutableArray<ListViewModel *> *)dataSource;

@end
