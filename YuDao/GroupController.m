//
//  GroupController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "GroupController.h"
#import "GroupDetailController.h"
#import "PersonalController.h"

#import "ContactsModel.h"
#import "UIImage+ChangeIt.h"

@interface GroupController ()

@property(nonatomic,strong)NSMutableArray *indexArray;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UILabel *sectionTitleView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indexArray = [ContactsModel IndexArray:self.dataSource];
    self.dataSource = [ContactsModel LetterSortArray:self.dataSource];
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        ContactsModel *model1 = [ContactsModel modelWith:@"为了部落" imageName:@"test8.jpg"];
        ContactsModel *model2 = [ContactsModel modelWith:@"艾欧尼亚" imageName:@"test8.jpg"];
        [_dataSource addObject:model1];
        [_dataSource addObject:model2];
    }
    return _dataSource;
}

#pragma mark - dataSource
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"groupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:cellId];
        cell.imageView.layer.cornerRadius = 5.0f;
        cell.imageView.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ContactsModel *model = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.imageName] inRect:CGRectMake(60, 60, 40, 40)];
    cell.imageView.image = image;
    cell.textLabel.text = model.name;
    return cell;
}

#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor lightGrayColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[PersonalController new] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self showSectionTitle:title];
    return index;
}

#pragma mark - private
- (void)timerHandler:(NSTimer *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.sectionTitleView.alpha = 0;
        } completion:^(BOOL finished) {
            self.sectionTitleView.hidden = YES;
            [self.timer invalidate];
            self.timer = nil;
        }];
    });
}

-(void)showSectionTitle:(NSString*)title{
    [self.sectionTitleView setText:title];
    self.sectionTitleView.hidden = NO;
    self.sectionTitleView.alpha = 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (UILabel *)sectionTitleView{
    if (!_sectionTitleView) {
        _sectionTitleView = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-100)/2, (screen_height-100)/2,100,100)];
        _sectionTitleView.textAlignment = NSTextAlignmentCenter;
        _sectionTitleView.font = [UIFont boldSystemFontOfSize:60];
        _sectionTitleView.textColor = [UIColor blueColor];
        _sectionTitleView.backgroundColor = [UIColor clearColor];
        //            sectionTitleView.layer.cornerRadius = 6;
        //            sectionTitleView.layer.borderWidth = 1.0f;
        _sectionTitleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [self.navigationController.view addSubview:_sectionTitleView];
    }
    return _sectionTitleView;
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
