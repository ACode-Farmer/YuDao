//
//  SortTableView.m
//  YuDao
//
//  Created by 汪杰 on 16/9/28.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "SortTableView.h"
#import "ContactsModel.h"


@implementation SortTableView
{
    NSMutableArray *_dataSource;
    NSMutableArray *_indexArray;
    UILabel        *_sectionTitleView;
    NSTimer        *_timer;
}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(NSMutableArray *)dataSource{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        self.tableHeaderView = [UITableViewHeaderFooterView new];
        self.tableFooterView = [UITableViewHeaderFooterView new];
        self.dataSource = self;
        self.delegate = self;
        
        //排序数据源
        _indexArray = [ContactsModel IndexArray:dataSource];
        _dataSource = [ContactsModel LetterSortArray:dataSource];
        
        _sectionTitleView = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-50, screen_height/2-100,100,100)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:60];
            label.textColor = [UIColor blueColor];
            label.backgroundColor = [UIColor clearColor];
            label.layer.cornerRadius = 20;
            label.layer.borderWidth = 1.0f;
            label.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            label;
        });
        [self addSubview:_sectionTitleView];
        [self bringSubviewToFront:_sectionTitleView];
    }
    return self;
}


#pragma mark - dataSource
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _indexArray[section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _indexArray? _indexArray.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource? [_dataSource[section] count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//        cell.accessoryView = ({
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(0, 0, 100, 40);
//            [button setTitle:@"邀请加入" forState:0];
//            button.titleLabel.textAlignment = NSTextAlignmentRight;
//            [button setTitleColor:[UIColor orangeColor] forState:0];
//            [button addTarget:self action:@selector(friendOperation:) forControlEvents:UIControlEventTouchUpInside];
//            
//            button;
//        });
    }
    ContactsModel *model = [[_dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)friendOperation:(UIButton *)sender{
    NSLog(@"邀请加入或添加好友!");
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self showSectionTitle:title];
    return index;
}

#pragma mark - delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.text = [_indexArray objectAtIndex:section];
    lab.textColor = [UIColor lightGrayColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsModel *model = [[_dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:model.name
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - private
- (void)timerHandler:(NSTimer *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            _sectionTitleView.alpha = 0;
        } completion:^(BOOL finished) {
            _sectionTitleView.hidden = YES;
            [_timer invalidate];
            _timer = nil;
        }];
    });
}

-(void)showSectionTitle:(NSString*)title{
    _sectionTitleView.text = title;
    _sectionTitleView.hidden = NO;
    _sectionTitleView.alpha = 1;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

@end
