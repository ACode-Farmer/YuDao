//
//  PlaceController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/22.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "PlaceController.h"
#import "InterestController.h"

@interface PlaceController ()

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSString *place;

@end

@implementation PlaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群组位置";
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
        rightItem;
    });
    
}

#pragma mark - Events
- (void)rightItemAction{
    InterestController *inVC = [InterestController new];
    inVC.optionalTitle = @"添加兴趣标签";
    [self.navigationController pushViewController:inVC animated:YES];
}

#pragma UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource? self.dataSource.count :0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"placeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.place = self.dataSource[indexPath.row];
    NSLog(@"place = %@",self.place);
}

#pragma mark - Getters
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"123415",@"6334748",@"fasgdfshs",@"hadsbgcxbdfj",@"wfeshfcvb",@"fshdfjvc",@"geghdcbcxbc"];
    }
    return _dataSource;
}

@end
