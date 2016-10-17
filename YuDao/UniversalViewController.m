//
//  FirstTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "UniversalViewController.h"
#import "SetupModel.h"

@interface UniversalViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) ControllerType type;
@end

@implementation UniversalViewController

- (id)init{
    if (self = [super init]) {
        self.type = ControllerTypeOne;
        self.title = @"通用设置";
    }
    return self;
}

- (id)initWithControllerType:(ControllerType )type title:(NSString *)title{
    if (self = [super init]) {
        self.type = type;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}

//根据控制器类型取得相应的数据源
- (NSArray *)dataSource{
    if (!_dataSource) {
        switch (self.type) {
            case ControllerTypeOne:
            {
                SetupModel *model1 = [SetupModel modelWithTitle:@"系统活动" subTitle:nil];
                SetupModel *model2 = [SetupModel modelWithTitle:@"好友聊天" subTitle:nil];
                SetupModel *model3 = [SetupModel modelWithTitle:@"车辆异常" subTitle:nil];
                _dataSource = @[model1,model2,model3];
                break;
            }
            case ControllerTypeTwo:
            {
                SetupModel *model1 = [SetupModel modelWithTitle:@"通过搜索找到我" subTitle:@"关闭后其它用户将无法通过搜索找到你"];
                SetupModel *model2 = [SetupModel modelWithTitle:@"屏蔽手机联系人" subTitle:@"屏蔽你的手机联系人好友"];
                SetupModel *model3 = [SetupModel modelWithTitle:@"共同联系人" subTitle:nil];
                SetupModel *model4 = [SetupModel modelWithTitle:@"哔哔时不要显示我" subTitle:@"使用哔哔时别人无法获得你的位置"];
                SetupModel *model5 = [SetupModel modelWithTitle:@"刷脸不要显示我" subTitle:nil];
                SetupModel *model6 = [SetupModel modelWithTitle:@"显示我的动态" subTitle:@"不向陌生人展示位的动态"];
                _dataSource = @[model1,model2,model3,model4,model5,model6];
                break;
            }
            case ControllerTypeThree:
            {
                SetupModel *model1 = [SetupModel modelWithTitle:@"路况分析" subTitle:@"通过车辆行驶路线分析路况"];
                SetupModel *model2 = [SetupModel modelWithTitle:@"检测我的爱车" subTitle:@"定期检测车辆保障行驶安全"];
                _dataSource = @[model1,model2];
                break;
            }
            default:
                break;
        }
        
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource ? self.dataSource.count: 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"firstCell";
    SetupModel *model = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = [UIColor colorTextGray];
    }
    UISwitch *swit = [UISwitch new];
    swit.tag = indexPath.row;
    [swit addTarget:self action:@selector(SwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    //设置开关的状态
    swit.on = [[NSUserDefaults standardUserDefaults] boolForKey:model.title];
    cell.accessoryView = swit;
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.subTitle;
    return cell;
}

- (void)SwitchValueChange:(UISwitch *)sender{
    SetupModel *model = self.dataSource[sender.tag];
    //把开关状态保存到用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.isOn forKey:model.title];
    [defaults synchronize];//保存同步
}



@end
