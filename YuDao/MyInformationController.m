//
//  MyInformationController.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/6.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "MyInformationController.h"
#import "PersonalHeadController.h"
#import "RealOrNickNameController.h"
#import "AgeOrPlaceController.h"
#import "InterestController.h"
#import "IDCardViewController.h"

#import "MCommonModel.h"
#import "UIImage+ChangeIt.h"

@interface MyInformationController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MyInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.tableView.estimatedRowHeight = 45.0f;
    //self.titles = @[@"头像",@"呢称",@"真实姓名",@"年龄",@"性别",@"情感状态",@"常出没地点",@"兴趣"];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadDataSource];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)reloadDataSource{
    MCommonModel *model0 = [MCommonModel singleModelWithTitle:@"头像"];
    MCommonModel *model1 = [MCommonModel singleModelWithTitle:@"昵称"];
    MCommonModel *model2 = [MCommonModel singleModelWithTitle:@"真实姓名"];
    MCommonModel *model3 = [MCommonModel singleModelWithTitle:@"年龄"];
    MCommonModel *model4 = [MCommonModel singleModelWithTitle:@"性别"];
    MCommonModel *model5 = [MCommonModel singleModelWithTitle:@"情感状态"];
    MCommonModel *model6 = [MCommonModel singleModelWithTitle:@"常出没地点"];
    MCommonModel *model7 = [MCommonModel singleModelWithTitle:@"我的兴趣"];
    _dataSource = @[model0,model1,model2,model3,model4,model5,model6,model7];

}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource? self.dataSource.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"myInformationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont font_16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = 0;
    }
    
    MCommonModel *model = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        UIImage *image = [[UIImage alloc] clipImageWithImage:[UIImage imageNamed:@"icon1.jpg"] inRect:CGRectMake(60, 60, 60, 60)];
        UIImageView *userImage = [[UIImageView alloc] initWithImage:image];
        userImage.layer.cornerRadius = 10.0f;
        userImage.layer.masksToBounds = YES;
        cell.accessoryView = userImage;
    }else{
        cell.detailTextLabel.text = model.subTitle;
        cell.detailTextLabel.textColor = [UIColor colorWithString:@"#707070"];
    }
    cell.textLabel.text = model.title;
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80.0f;
    }else{
        return 40.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 100)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithString:@"#e4c500"];
    [btn setTitle:@"个人认证" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.frame = CGRectMake(20, 10, screen_width-40, 40);
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = true;
    [btn addTarget:self action:@selector(footBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"*个人认证后可查看周边妹子(帅哥)哦!";
    label.frame = CGRectMake(20, 60, screen_width-40, 30);
    
    [view sd_addSubviews:@[lineView,btn,label]];
    return view;
}

- (void)footBtnAction:(UIButton *)sender{
    IDCardViewController *idVC = [IDCardViewController new];
    idVC.variableTitle = @"个人认证";
    idVC.firstTitle = @"请拍照上传身份证正面";
    idVC.secondTitle = @"请拍照上传身份证反面";
    [self.navigationController secondLevel_push_fromViewController:self toVC:idVC];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController secondLevel_push_fromViewController:self toVC:[PersonalHeadController new]];
            break;}
        case 1:
        {
            RealOrNickNameController *vc =  [RealOrNickNameController new];
            vc.isReal = NO;
            [self.navigationController secondLevel_push_fromViewController:self toVC:vc];
            break;}
        case 2:
        {
            RealOrNickNameController *vc =  [RealOrNickNameController new];
            vc.isReal = YES;
            [self.navigationController secondLevel_push_fromViewController:self toVC:vc];
            break;}
        case 3:
        {
            AgeOrPlaceController *vc = [AgeOrPlaceController new];
            vc.vcType = ControllerTypeAge;
            [self.navigationController secondLevel_push_fromViewController:self toVC:vc];
            break;}
        case 4:
        {
            AgeOrPlaceController *vc = [AgeOrPlaceController new];
            vc.vcType = ControllerTypeGender;
            [self.navigationController secondLevel_push_fromViewController:self toVC:vc];
            break;}
        case 5:
        {
            AgeOrPlaceController *vc = [AgeOrPlaceController new];
            vc.vcType = ControllerTypeEmotion;
            [self.navigationController secondLevel_push_fromViewController:self toVC:vc];
            break;}
        case 6:
        {
            AgeOrPlaceController *vc = [AgeOrPlaceController new];
            vc.vcType = ControllerTypePlace;
            [self.navigationController secondLevel_push_fromViewController:self toVC:vc];
            break;}
        case 7:
        {
            InterestController *inVC = [InterestController new];
            inVC.optionalTitle = @"个人兴趣";
            [self.navigationController secondLevel_push_fromViewController:self toVC:inVC];
            break;}
        default:
            break;
    }
}


@end
