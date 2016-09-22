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
- (void)rightItemAction{
    InterestController *inVC = [InterestController new];
    inVC.optionalTitle = @"添加兴趣标签";
    [self.navigationController pushViewController:inVC animated:YES];
}

#pragma lazy load
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"123415",@"6334748",@"fasgdfshs",@"hadsbgcxbdfj",@"wfeshfcvb",@"fshdfjvc",@"geghdcbcxbc"];
    }
    return _dataSource;
}

#pragma table view dataSource
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

#pragma table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.place = self.dataSource[indexPath.row];
    NSLog(@"place = %@",self.place);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
