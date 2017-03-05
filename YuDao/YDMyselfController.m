//
//  MyselfController.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyselfController.h"
#import "ChangeImageController.h"
#import "LikedPeopleController.h"
#import "GarageViewController.h"
#import "MyQRCodeViewController.h"
#import "MyInformationController.h"
#import "MyMessageTableViewController.h"
#import "ContactsTableViewController.h"
#import "YDGarageViewController.h"

#import "MyselfModel.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "UIButton+ImageTitleSpacing.h"

#import "YDContactsViewController.h"
#import "YDMyDataViewController.h"

#import "YDXMPPManager.h"

@interface MyselfController ()

@property (nonatomic, strong) NSArray *datasource;

@property (nonatomic, strong) UIImageView *headerView;

@end

@implementation MyselfController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
   
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.rowHeight = 60*widthHeight_ratio;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_mainPage_setup"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)dealloc{
    NSLog(@"myselfVC");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender{
    
    [self pushViewController:@"SetupTableViewController"];
}

- (void)tapAction:(id)sender{
    [self userImageBtnAction:nil];
}

- (void)userImageBtnAction:(UIButton *)sender{
    NSString *title = nil;
    if (sender) {
        title = @"更换头像";
    }else{
        title = @"更换封面背景";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *one = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ChangeImageController *changeVC = [ChangeImageController new];
        changeVC.optionalTitle = title;
        [self.navigationController firstLevel_push_fromViewController:self toVC:changeVC];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:one];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Private Methods
- (void)pushViewController:(NSString *)className{
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:[NSClassFromString(className) new] animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datasource? self.datasource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"NO.2Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    MyselfModel *model = self.datasource[indexPath.row];
    cell.textLabel.text = model.name;
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self.navigationController firstLevel_push_fromViewController:self toVC:[YDMyDataViewController new]];
            break;
        case 1:
            [self.navigationController firstLevel_push_fromViewController:self toVC:[MyMessageTableViewController new]];
            break;
        case 2:
            [self.navigationController firstLevel_push_fromViewController:self toVC:[YDGarageViewController new]];
            break;
        case 3:
            [self.navigationController firstLevel_push_fromViewController:self toVC:[YDContactsViewController new]];
            break;
        case 4:
            [self.navigationController firstLevel_push_fromViewController:self toVC:[LikedPeopleController new]];
            break;
        case 5:
            [self.navigationController firstLevel_push_fromViewController:self toVC:[MyQRCodeViewController new]];
            break;
        default:
            break;
    }
}

#pragma mark - Getters
- (NSArray *)datasource{
    if (!_datasource) {
        MyselfModel *model1 = [MyselfModel modelWithIamgeName:@"mine_mainPage_information" name:@"我的资料"];
        MyselfModel *model2 = [MyselfModel modelWithIamgeName:@"mine_mainPage_message" name:@"我的消息"];
        MyselfModel *model3 = [MyselfModel modelWithIamgeName:@"mine_mainPage_carpark" name:@"我的车库"];
        MyselfModel *model4 = [MyselfModel modelWithIamgeName:@"mine_mainPage_contacts" name:@"通讯录"];
        MyselfModel *model5 = [MyselfModel modelWithIamgeName:@"mine_mainPage_likePerson" name:@"喜欢的人"];
        MyselfModel *model6 = [MyselfModel modelWithIamgeName:@"mine_mainPage_erCode" name:@"我的二维码"];
        _datasource = @[model1,model2,model3,model4,model5,model6];
    }
    return _datasource;
}

- (UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 220*widthHeight_ratio)];
        _headerView.image = [UIImage imageNamed:@"mine_header_back"];
        _headerView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_headerView addGestureRecognizer:tap];
        
        UIButton *userImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [userImageBtn setImage:[UIImage imageNamed:@"icon1.jpg"] forState:0];
        [userImageBtn setImage:[UIImage imageNamed:@"icon1.jpg"] forState:1];
        userImageBtn.frame = CGRectMake(screen_width/2 - 50*widthHeight_ratio, 20, 100*widthHeight_ratio, 100*widthHeight_ratio);
        userImageBtn.layer.cornerRadius = 50*widthHeight_ratio;
        userImageBtn.layer.masksToBounds = YES;
        [userImageBtn addTarget:self action:@selector(userImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [vipBtn setTitle:@"认证等级 V5" forState:0];
        [vipBtn.titleLabel setFont:[UIFont font_14]];
        [vipBtn setTitleColor:[UIColor whiteColor] forState:0];
        [vipBtn setImage:[UIImage imageNamed:@"Like"] forState:0];
        vipBtn.backgroundColor = [UIColor orangeColor];
        vipBtn.enabled = NO;
        
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeBtn setTitle:@"666喜欢" forState:0];
        [likeBtn.titleLabel setFont:[UIFont font_14]];
        [likeBtn setTitleColor:[UIColor whiteColor] forState:0];
        [likeBtn setImage:[UIImage imageNamed:@"Like"] forState:0];
        likeBtn.backgroundColor = [UIColor orangeColor];
        likeBtn.enabled = NO;
        
        NSArray *headerSubViews = @[userImageBtn,likeBtn,vipBtn];
        [headerSubViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_headerView addSubview:obj];
        }];
        
        vipBtn.sd_layout
        .rightSpaceToView(userImageBtn,-10)
        .bottomSpaceToView(_headerView,30*widthHeight_ratio)
        .leftSpaceToView(_headerView,20*widthHeight_ratio)
        .heightIs(40*widthHeight_ratio);
        vipBtn.sd_cornerRadius = @5;
        
        likeBtn.sd_layout
        .leftSpaceToView(userImageBtn,-10)
        .bottomEqualToView(vipBtn)
        .rightSpaceToView(_headerView,20*widthHeight_ratio)
        .heightIs(40*widthHeight_ratio);
        likeBtn.sd_cornerRadius = @5;
        
        //[vipBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
        //[likeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
    }
    return _headerView;
}

@end
