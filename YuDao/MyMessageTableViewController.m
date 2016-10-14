//
//  MyMessageTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyMessageTableViewController.h"
#import "ChatTableViewController.h"
#import "MyMseeageModel.h"
#import "UIImage+ChangeIt.h"
@interface MyMessageTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation MyMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    self.tableView.rowHeight = 45.0f;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        MyMseeageModel *model = [MyMseeageModel modelWith:@"message" name:@"系统通知" lastMessage:@"想要邂逅你的她/他，速来尝试发现里的逛一逛..." time:@"下午4:00"];
        [_dataSource addObject:model];
        for (NSInteger i = 0; i<10; i++) {
            MyMseeageModel *model = [MyMseeageModel modelWith:@"icon1.jpg" name:@"小明" lastMessage:@"好多美女，速来xxxx酒吧，在那个xxxx路上" time:@"下午4:00"];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Message");
}

#pragma mark - TableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource ? self.dataSource.count : 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyMessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.imageView.layer.cornerRadius = 5.0f;
        cell.imageView.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyMseeageModel *model = self.dataSource[indexPath.row];
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.imageName] inRect:CGRectMake(40, 40, 40, 40)];
    cell.imageView.image = image;
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.lastMessage;
    if (indexPath.row == 0) {
        
    }else{
        cell.accessoryView = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentRight;
            label.text = model.time;
            label;
        });
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController secondLevel_push_fromViewController:self toVC:[ChatTableViewController new]];
}


@end
