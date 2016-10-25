//
//  ViewController.m
//  https://github.com/c6357/YUChineseSorting
//
//  Created by BruceYu on 15/4/19.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "GroupController.h"
#import "PhoneContactsTableViewController.h"
#import "HeaderTableView.h"
#import "HeaderModel.h"
#import "YDContactsModel.h"
#import "YDChatViewController.h"
#import "UIImage+ChangeIt.h"
#import "YDPersonalDataController.h"
#import "YDAddFriendViewController.h"

@interface ContactsTableViewController ()<HeaderTableViewDelegate>

@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@property (nonatomic, strong) UILabel *sectionTitleView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic ,strong) HeaderTableView *headerView;

@property (nonatomic, strong) NSArray *headerViewDataSource;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    self.sectionTitleView = ({
            UILabel *sectionTitleView = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-100)/2, (screen_height-100)/2,100,100)];
            sectionTitleView.textAlignment = NSTextAlignmentCenter;
            sectionTitleView.font = [UIFont boldSystemFontOfSize:60];
            sectionTitleView.textColor = [UIColor blueColor];
            sectionTitleView.backgroundColor = [UIColor clearColor];
            _sectionTitleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        sectionTitleView;
    });
    [self.navigationController.view addSubview:self.sectionTitleView];
    self.sectionTitleView.hidden = YES;
    
    
    NSArray *stringsToSort = [NSArray arrayWithObjects:
                              @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                              @"开源技术",@"社区",@"开发者",@"传播",
                              @"2014",@"a1",@"100",@"中国",@"暑假作业",
                              @"键盘", @"鼠标",@"鼠标",@"hello",@"world",@"b1",
                              nil];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *name in stringsToSort) {
        YDContactsModel *model = [[YDContactsModel alloc] init];
        model.imageName = @"icon1.jpg";
        model.name = name;
        [tempArray addObject:model];
    }
    self.indexArray = [YDContactsModel IndexArray:tempArray];
    self.letterResultArr = [YDContactsModel LetterSortArray:tempArray];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = 45;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(contactsRightBarItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - Events

- (void)contactsRightBarItemAction:(UIBarButtonItem *)sender{
    [self.navigationController secondLevel_push_fromViewController:self toVC:[YDAddFriendViewController new]];
}

/**
 *  获得点击图片所在的行
 *
 */
- (void)tapCellGuestureAction:(UIGestureRecognizer *)tap{
    id selectedCell = [[tap.view superview] superview];
    NSIndexPath *selectedIndex = [self.tableView indexPathForCell:selectedCell];
    NSLog(@"section = %ld  row = %ld",selectedIndex.section,selectedIndex.row);
    [self.navigationController secondLevel_push_fromViewController:self toVC:[YDPersonalDataController new]];
}

#pragma mark -  HeaderTableViewDelegate -
- (void)clickHeaderTableViewCell:(HeaderModel *)model{
    if ([model.name isEqualToString:@"群聊"]) {
        [self.navigationController secondLevel_push_fromViewController:self toVC:[GroupController new]];
    }else{
        [self.navigationController secondLevel_push_fromViewController:self toVC:[PhoneContactsTableViewController new]];
    }
}

#pragma mark - UITableViewDataSource
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
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.imageView.layer.cornerRadius = 5.0f;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.userInteractionEnabled = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        
        //给头像添加点击事件
        UITapGestureRecognizer *tapCell = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapCellGuestureAction:)];
        [cell.imageView addGestureRecognizer:tapCell];
    }
    YDContactsModel *model = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.imageName] inRect:CGRectMake(60, 60, 40, 40)];
    cell.imageView.image = image;
    cell.detailTextLabel.text = @"v5";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self showSectionTitle:title];
    return index;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YDContactsModel *model = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    YDChatViewController *chatVC = [YDChatViewController sharedChatVC];
    chatVC.title = model.name;
    [self.navigationController secondLevel_push_fromViewController:self toVC:chatVC];
}

#pragma mark - private
- (void)timerHandler:(NSTimer *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            self.sectionTitleView.alpha = 0;
        } completion:^(BOOL finished) {
            self.sectionTitleView.hidden = YES;
        }];
    });
}

-(void)showSectionTitle:(NSString*)title{
    [self.sectionTitleView setText:title];
    self.sectionTitleView.hidden = NO;
    self.sectionTitleView.alpha = 1;
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - Getters
- (HeaderTableView *)headerView{
    if (!_headerView) {
        _headerView = [[HeaderTableView alloc] initWithFrame:CGRectMake(0, 0, screen_width-15, 120) withDataSource:self.headerViewDataSource];
        _headerView.clickCellDelegate = self;
    }
    return _headerView;
}

- (NSArray *)headerViewDataSource{
    if (!_headerViewDataSource) {
        HeaderModel *model1 = [HeaderModel modelWithImageName:@"" Name:@"群聊"];
        HeaderModel *model2 = [HeaderModel modelWithImageName:@"" Name:@"手机联系人"];
        _headerViewDataSource = @[model1,model2];
    }
    return _headerViewDataSource;
}

@end
