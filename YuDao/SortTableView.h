//
//  SortTableView.h
//  YuDao
//
//  Created by 汪杰 on 16/9/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SortTVTapCellDelegate <NSObject>



@end

@interface SortTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id<SortTVTapCellDelegate> sortTVDelegate;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(NSMutableArray *)dataSource;

@end
