//
//  HomePageController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "HomePageController.h"

#import "HomePageTableView.h"
#import "SignInView.h"
#import "LocationView.h"

#import "TableNode.h"
#import "MenuModel.h"
#import "DrivingDataModel.h"
#import "ListTypeCell.h"

#import <SDAutoLayout/UIView+SDAutoLayout.h>

@interface HomePageController ()<homeTableViewDelegate,ListTypeCellDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) LocationView *locationView;
@property (nonatomic, strong) HomePageTableView *homeTableView;
@property (nonatomic, strong) SignInView *signView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *menuData;
@property (nonatomic, strong) NSArray *drivingData;
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, strong) NSArray *targetData;
@property (nonatomic, strong) NSArray *friendsData;

@property (nonatomic, strong) UITableView *relationTableView;
@property (nonatomic, strong) NSArray *relationTableDataSource;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = RGBCOLOR(8, 169, 195);
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.locationView];
    // Do any additional setup after loading the view.
}

#pragma mark - lazy load

- (LocationView *)locationView{
    if (!_locationView) {
        _locationView = [[LocationView alloc] initWithFrame:CGRectMake(0, 64, screen_width, 40)];
        _locationView.backgroundColor = [UIColor lightGrayColor];
    }
    return _locationView;
}

- (HomePageTableView *)tableView{
    if (!_homeTableView) {
        _homeTableView = [[HomePageTableView alloc] initWithFrame:CGRectMake(0, 40, screen_width, screen_height) withDataSource:self.dataSource];
        _homeTableView.homeTableViewDelegate = self;
    }
    return _homeTableView;
}

- (NSArray *)relationTableDataSource{
    if (!_relationTableDataSource) {
        _relationTableDataSource = @[@"不限",@"附近",@"仅男生",@"仅女生",@"仅好友"];
    }
    return _relationTableDataSource;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TableNodeDataSource.plist" ofType:nil];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dic in data) {
            TableNode *node = [TableNode modelWithDictionary:dic];
            if (node.depth.integerValue == 0) {
                if (node.nodeId.integerValue == 0) {
                    
                }else{
                    [node setDataWithArray:self.menuData];
                }
                
            }
            else if (node.parentId.integerValue == 1){
                [node setDataWithArray:self.drivingData];
            }
            else if (node.parentId.integerValue == 6){
                [node setDataWithArray:nil];
            }
            else if (node.parentId.integerValue == 11){
                [node setDataWithArray:nil];
            }
            else if (node.parentId.integerValue == 14){
                [node setDataWithArray:nil];
            }
            [_dataSource addObject:node];
        }
    }
    return _dataSource;
}

- (NSArray *)menuData{
    if (!_menuData) {
        MenuModel *carNodeData = [[MenuModel alloc]initWithIcon:@"carIcon" lable:@"车辆信息" arrow:@"bottomArrow"];
        MenuModel *listNodaData = [[MenuModel alloc] initWithIcon:@"listIcon" lable:@"榜单" arrow:@"bottomArrow"];
        MenuModel *targetNodeData = [[MenuModel alloc] initWithIcon:@"targetIcon" lable:@"任务" arrow:@"bottomArrow"];
        MenuModel *friendNodeData = [[MenuModel alloc] initWithIcon:@"friendIcon" lable:@"朋友圈" arrow:@"bottomArrow"];
        _menuData = @[carNodeData,listNodaData,targetNodeData,friendNodeData];
    }
    return _menuData;
}

- (NSArray *)drivingData{
    if (!_drivingData) {
        DrivingDataModel *model1 = [DrivingDataModel modelWith:@"上海天气" imageName:@"" firstData:@"" secondData:@""];
        DrivingDataModel *model2 = [DrivingDataModel modelWith:@"油耗" imageName:@"" firstData:@"" secondData:@""];
        DrivingDataModel *model3 = [DrivingDataModel modelWith:@"里程" imageName:@"" firstData:@"" secondData:@""];
        DrivingDataModel *model4 = [DrivingDataModel modelWith:@"时速" imageName:@"" firstData:@"" secondData:@""];
        
        _drivingData = @[model1,model2,model3,model4];
    }
    return _drivingData;
}


- (SignInView *)signView{
    if (!_signView) {
        CGFloat width = 150;
        CGRect frame = CGRectMake((self.view.frame.size.width - width) / 2, (self.view.frame.size.height - width) / 2, width, width);
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:7];
        for (NSUInteger i = 0; i < 7; i++) {
            NSString *string = [NSString stringWithFormat:@"sora_%zd.png",i];
            UIImage *image = [UIImage imageNamed:string];
            [images addObject:image];
        }
        _signView = [[SignInView alloc] initWithFrame:frame backColor:[UIColor blackColor] images:images animationDuration:1 labelString:nil];
    }
    return _signView;
}

#pragma mark items - Action -
- (IBAction)SignInAction:(id)sender {
    [self.view addSubview:self.signView];
    [self.signView startanimation];
}

- (IBAction)SearchAction:(id)sender {
    
}


#pragma mark hometableViewDelegate -
- (void)clickCell :(TableNode *)node rect :(CGRect)rect{
    NSLog(@"ok...");
}

#pragma mark ListTypeCellDelegate -
- (void)arrowBtnAction:(ListTypeCell *)cell button:(UIButton *)sender{
    CGRect frame = [_homeTableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    CGRect relationTableViewFrame = CGRectMake(screen_width - 100, frame.origin.y, 100, 0);
    if (!_relationTableView) {
        _relationTableView = [[UITableView alloc] initWithFrame:relationTableViewFrame style:UITableViewStylePlain];
        _relationTableView.backgroundColor = [UIColor orangeColor];
        _relationTableView.scrollEnabled = NO;
        _relationTableView.rowHeight = 30.0f;
        _relationTableView.tag = 1001;
        _relationTableView.dataSource = self;
        _relationTableView.delegate = self;
    }
    if (sender.selected) {
        [_homeTableView addSubview:_relationTableView];
        [_homeTableView bringSubviewToFront:_relationTableView];
        [UIView animateWithDuration:0.5f animations:^{
            _relationTableView.height = 150.f;
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            _relationTableView.height = 0;
        } completion:^(BOOL finished) {
            [_relationTableView removeFromSuperview];
        }];
    }
}

- (void)typeBtnAction:(ListTypeCell *)cell button:(UIButton *)sender{
    ListCell *lCell = [self.homeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    UIScrollView *scrView = [lCell viewWithTag:101];
    CGPoint offset = scrView.contentOffset;
    offset.x = (sender.tag-100) *screen_width;
    [scrView setContentOffset:offset animated:YES];
}

#pragma tableView dataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.relationTableDataSource? self.relationTableDataSource.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *sortCellIdentifier = @"sortCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sortCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sortCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = self.relationTableDataSource[indexPath.row];
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
