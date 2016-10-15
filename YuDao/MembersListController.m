//
//  MembersListController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/22.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MembersListController.h"
#import "YDContactsModel.h"
#import "UIImage+ChangeIt.h"

@interface MembersListController ()

@property (nonatomic, strong) NSMutableArray<YDContactsModel *> *dataSource;

@end

@implementation MembersListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成员列表";
    self.tableView.rowHeight = 45.f;
    
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource ? self.dataSource.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"membersListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:cellId];
        cell.imageView.layer.cornerRadius = 5.0f;
        cell.imageView.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    YDContactsModel *model = self.dataSource[indexPath.row];
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.imageName] inRect:CGRectMake(60, 60, 40, 40)];
    cell.imageView.image = image;
    cell.textLabel.text = model.name;
    
    return cell;
}

#pragma mark - Getters
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i<5; i++) {
            
            NSString *string = [NSString stringWithFormat:@"head%ld.jpg",i];
            YDContactsModel *model = [YDContactsModel modelWith:@"来啊来啊！！！" imageName:string];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

@end
