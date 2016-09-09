//
//  ViewController.m
//  https://github.com/c6357/YUChineseSorting
//
//  Created by BruceYu on 15/4/19.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "HeaderTableView.h"
#import "HeaderModel.h"
#import "ContactsModel.h"

#import "UIImage+ChangeIt.h"

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
//            sectionTitleView.layer.cornerRadius = 6;
//            sectionTitleView.layer.borderWidth = 1.0f;
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
        ContactsModel *model = [[ContactsModel alloc] init];
        model.imageName = @"icon1.jpg";
        model.name = name;
        [tempArray addObject:model];
    }
    self.indexArray = [ContactsModel IndexArray:tempArray];
    self.letterResultArr = [ContactsModel LetterSortArray:tempArray];
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.rowHeight = 45;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - lazy load
- (HeaderTableView *)headerView{
    if (!_headerView) {
        _headerView = [[HeaderTableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 80) withDataSource:self.headerViewDataSource];
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

#pragma mark -  HeaderTableViewDelegate -
- (void)clickHeaderTableViewCell:(HeaderModel *)model{
    [self performSegueWithIdentifier:@"PhoneContacts" sender:nil];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.imageView.layer.cornerRadius = 5.0f;
        cell.imageView.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ContactsModel *model = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:model.imageName] inRect:CGRectMake(60, 60, 40, 40)];
    cell.imageView.image = image;
    return cell;
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



#pragma mark - 
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor lightGrayColor];
    return lab;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 40.0f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsModel *model = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:model.name
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
