//
//  MembersListController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/22.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MembersListController.h"
#import "ContactsModel.h"
#import "UIImage+ChangeIt.h"

@interface MembersListController ()

@property (nonatomic, strong) NSMutableArray<ContactsModel *> *dataSource;

@end

@implementation MembersListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成员列表";
    self.tableView.rowHeight = 45.f;
    
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i<5; i++) {
            
            NSString *string = [NSString stringWithFormat:@"head%ld.jpg",i];
            ContactsModel *model = [ContactsModel modelWith:@"来啊来啊！！！" imageName:string];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

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
    ContactsModel *model = self.dataSource[indexPath.row];
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.imageName] inRect:CGRectMake(60, 60, 40, 40)];
    cell.imageView.image = image;
    cell.textLabel.text = model.name;
    
    return cell;
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
