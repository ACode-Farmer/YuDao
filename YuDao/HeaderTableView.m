//
//  headerTableVIew.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "HeaderTableView.h"
#import "HeaderModel.h"
@implementation HeaderTableView
{
    NSArray *_dataSource;
}
- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource{
    if (self = [super initWithFrame:frame]) {
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 40;
        _dataSource = dataSource;
    }
    return self;
}

#pragma mark - dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count>0 ? _dataSource.count : 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"headerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HeaderModel *model = _dataSource[indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:model.imageName];
    cell.textLabel.text = model.name;
    
    return cell;
}

#pragma mark delegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeaderModel *model = _dataSource[indexPath.row];
    if (self.clickCellDelegate && [self.clickCellDelegate respondsToSelector:@selector(clickHeaderTableViewCell:)]) {
        [self.clickCellDelegate clickHeaderTableViewCell:model];
    }
}

@end
