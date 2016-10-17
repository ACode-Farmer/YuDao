//
//  YDPersonalTableView.h
//  YuDao
//
//  Created by 汪杰 on 16/10/17.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDPTimeAxisModel.h"

@interface YDPersonalTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<YDPTimeAxisModel *> *data;

@end
