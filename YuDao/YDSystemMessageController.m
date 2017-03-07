//
//  YDSystemMessageController.m
//  YuDao
//
//  Created by 汪杰 on 17/2/24.
//  Copyright © 2017年 汪杰. All rights reserved.
//

#import "YDSystemMessageController.h"


@interface YDSystemMessageController ()

@property (nonatomic,strong) NSMutableArray<YDSystemMessage *> *data;

@end

@implementation YDSystemMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统通知";
    
    self.data = [NSMutableArray array];
    self.tableView.rowHeight = 53.f;
    
    YDWeakSelf(self);
    [[YDSystemMessageHelper sharedSystemMessageHelper] allSystemMessageByUserid:[YDUserDefault defaultUser].user.ub_id fromDate:[NSDate date] count:10 complete:^(NSArray *data, BOOL hasMore) {
        [weakself.data addObjectsFromArray:data];
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data ? self.data.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *systemCell = @"kSystemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:systemCell];
        
    }
    YDSystemMessage *message = [self.data objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"YuDaoLogo"];
    cell.textLabel.text = message.content;
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
