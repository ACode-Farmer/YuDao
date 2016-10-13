//
//  OrdinaryTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/12.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDOrdinaryTableViewController.h"

@interface YDOrdinaryModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
//是否打勾
@property (nonatomic, assign) BOOL isCheck;

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title isCheck:(BOOL )isCheck;

@end

@implementation YDOrdinaryModel

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title isCheck:(BOOL)isCheck{
    YDOrdinaryModel *model = [self new];
    model.imageName = imageName;
    model.title = title;
    model.isCheck = isCheck;
    return model;
}

@end


@interface YDOrdinaryTableViewController ()

@end

@implementation YDOrdinaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 40*widthHeight_ratio;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.data? self.data.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"YDOrdinaryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    YDOrdinaryModel *model = self.data[indexPath.row];
    if (model.imageName) {
        cell.imageView.image = [UIImage imageNamed:model.imageName];
    }
    cell.textLabel.text = model.title;
    if (model.isCheck) {
        cell.textLabel.textColor = [UIColor orangeColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //调用代理方法，收起视图
    if (self.selectedDelegate && [self.selectedDelegate respondsToSelector:@selector(OrdinaryTableViewControllerWith:)]) {
        [self.selectedDelegate OrdinaryTableViewControllerWith:tableView];
    }
    YDOrdinaryModel *model = self.data[indexPath.row];
    if (model.isCheck) {
        return;
    }else{
        [self.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YDOrdinaryModel *m = (YDOrdinaryModel *)obj;
            m.isCheck = NO;
        }];
        model.isCheck = YES;
        [tableView reloadData];
    }
    
}

#pragma mark Getters - 
- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithCapacity:8];
        NSArray *array = @[@"不限",@"上海",@"杭州",@"附近",@"只看男生",@"只看女生",@"仅看好友",@"同系车友"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YDOrdinaryModel *model = [YDOrdinaryModel modelWithImageName:nil title:obj isCheck:NO];
            if (idx == 0) {
                model.isCheck = YES;
            }
            [_data addObject:model];
        }];
    }
    return _data;
}

- (void)setIsShow:(BOOL)isShow{
    _isShow = isShow;
    if (_isShow) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.height = self.tableView.rowHeight * 8;
        }];
        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.view.height = 0;
        }];
    }
}

@end
