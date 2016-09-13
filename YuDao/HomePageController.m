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



@interface HomePageController ()<homeTableViewDelegate>

@property (nonatomic, strong) LocationView *locationView;
@property (nonatomic, strong) HomePageTableView *tableView;
@property (nonatomic, strong) SignInView *signView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *menuData;
@property (nonatomic, strong) NSArray *drivingData;
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, strong) NSArray *targetData;
@property (nonatomic, strong) NSArray *friendsData;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
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
    if (!_tableView) {
        _tableView = [[HomePageTableView alloc] initWithFrame:CGRectMake(0, 40, screen_width, screen_height) withDataSource:self.dataSource];
        _tableView.homeTableViewDelegate = self;
    }
    return _tableView;
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
                [node setDataWithArray:nil];
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
