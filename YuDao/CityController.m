//
//  CityController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "CityController.h"
#import "DistrictController.h"
#import "MyInformationController.h"

@interface CityController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) UITableViewCellAccessoryType cellType;

@end

@implementation CityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.provinceTitle;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        NSArray *bigCitys = @[@"北京市",@"天津市",@"上海市",@"重庆市"];
        if ([bigCitys containsObject:self.provinceTitle]) {
            for (NSDictionary *dic in data) {
                NSArray *array = [dic objectForKey:self.provinceTitle];
                for (NSDictionary *subDic in array) {
                    NSString *city = [[subDic allKeys] firstObject];
                    if ([city isEqualToString:self.provinceTitle]) {
                        NSArray *disArray = [subDic objectForKey:city];
                        _dataSource = [NSMutableArray arrayWithArray:disArray];
                    }
                }
            }
            self.cellType = 0;
        }else{
            _dataSource = [NSMutableArray array];
            for (NSDictionary *dic in data) {
                NSArray *array = [dic objectForKey:self.provinceTitle];
                for (NSDictionary *subDic in array) {
                    NSString *city = [[subDic allKeys] firstObject];
                    [_dataSource addObject:city];
                }
            }
            self.cellType = 1;
        }
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count ? self.dataSource.count: 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = self.cellType;
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellType == 0) {
        NSArray *controllers = self.navigationController.viewControllers;
        for (UIViewController *rootVC in controllers) {
            if ([rootVC isKindOfClass:[MyInformationController class]]) {
                [self.navigationController popToViewController:rootVC animated:YES];
            }
        }
    }else{
        DistrictController *disVC = [DistrictController new];
        disVC.provinceTitle = self.provinceTitle;
        disVC.cityTitle = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:disVC animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
