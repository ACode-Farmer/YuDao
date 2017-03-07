//
//  YDMyDataViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMyDataViewController.h"
#import "YDMyDataViewController+Delegate.h"

#import "YDPersonalAuthController.h"

@interface YDMyDataViewController ()

@property (nonatomic, strong) UIView *tableFootView;

@end

@implementation YDMyDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的资料"];
    
    
    [self.view addSubview:self.tableView];
    [self registerCell];
    
    //监听用户常出没地点的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserPlace:) name:@"kChangeUserPlace" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUserData];
    [self.tableView reloadData];
    
    _tempUser = [[YDUserDefault defaultUser].user getTempUserData];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
//    YDUser *user = [YDUserDefault defaultUser].user;
//    NSDictionary *userInfo = user.mj_keyValues;
//
//    [YDNetworking postUrl:kUpUserInfoURL parameters:userInfo success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *originalDic = [responseObject mj_JSONObject];
//        NSLog(@"originalDic = %@",originalDic);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"error = %@",error);
//    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//MARK:监听用户常出没地点的改变
- (void)changeUserPlace:(NSNotification *)noti{
    NSString *place = noti.object;
    
    NSArray *placeArray = [place componentsSeparatedByString:@","];
    _tempUser.ud_often_province_name = [placeArray objectAtIndex:0];
    _tempUser.ud_often_city_name = [placeArray objectAtIndex:1];
    _tempUser.ud_often_area_name = [placeArray objectAtIndex:2];
    
    [YDUserDefault defaultUser].user = _tempUser;
    
    YDMyDataModel *placeM = [_data objectAtIndex:6];
    placeM.subTitle = [_tempUser.ud_often_city_name stringByAppendingString:_tempUser.ud_often_area_name];
    [self.tableView reloadData];
}

//返回键的回调，上传用户信息
- (void)uploadMyInforMation{
    [YDUserDefault defaultUser].user = self.tempUser;
}


- (void)footBtnAction:(UIButton *)sender{

    YDPersonalAuthController *vc = [YDPersonalAuthController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Getter
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc ]initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
        _tableView.rowHeight = 50.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.tableFootView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


- (void)updateUserData{
    YDUser *user = [YDUserDefault defaultUser].user;
    YDMyDataModel *model1 = [YDMyDataModel modelWithTitle:@"头像" subTitle:nil subImageName:user.ud_face];
    YDMyDataModel *model2 = [YDMyDataModel modelWithTitle:@"昵称" subTitle:user.ub_nickname subImageName:nil];
    YDMyDataModel *model3 = [YDMyDataModel modelWithTitle:@"真实姓名" subTitle:user.ud_realname subImageName:nil];
    YDMyDataModel *model5 = [YDMyDataModel modelWithTitle:@"年龄" subTitle:[NSString stringWithFormat:@"%@",user.ud_age] subImageName:nil];
    YDMyDataModel *model6 = [YDMyDataModel modelWithTitle:@"性别" subTitle:@"男" subImageName:nil];
    if (user.ud_sex.integerValue == 2) {
       model6.subTitle = @"女";
    }
    YDMyDataModel *model7 = [YDMyDataModel modelWithTitle:@"情感状态" subTitle:@"" subImageName:nil];
    switch (user.ud_emotion.integerValue) {
        case 0:
            model7.subTitle = @"保密";    break;
        case 1:
            model7.subTitle = @"单身";    break;
        case 2:
            model7.subTitle = @"已婚";    break;
        case 3:
            model7.subTitle = @"离异";    break;
        case 4:
            model7.subTitle = @"恋爱";    break;
        default:
            break;
    }
    
    NSString *place = [user.ud_often_city_name stringByAppendingString:user.ud_often_area_name];
    YDMyDataModel *model8 = [YDMyDataModel modelWithTitle:@"常出没地点" subTitle:place subImageName:nil];
    
    YDMyDataModel *model9 = [YDMyDataModel modelWithTitle:@"感兴趣的事" subTitle:user.ud_tag_name subImageName:nil];
    self.data = [NSMutableArray arrayWithObjects:model1,model2,model3,model5,model6,model7,model8,model9, nil];
}

#pragma mark - Getters
- (UIView *)tableFootView{
    if (!_tableFootView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-50*7-64-64)];
        view.backgroundColor = [UIColor clearColor];
        
        UIButton *btn = [YDUIKit buttonWithTitle:@"我要认证" titleColor:[UIColor whiteColor]   target:self];
        btn.backgroundColor = [UIColor colorWithString:@"#2B3552"];
        btn.layer.cornerRadius = 8.0f;
        YDUser *user = [YDUserDefault defaultUser].user;
        
        switch (user.ud_userauth.integerValue) {
            case 0:
                [btn setTitle:@"我要认证" forState:0];
                break;
            case 1:
                [btn setTitle:@"已认证" forState:0];
                break;
            case 2:
                [btn setTitle:@"认证中" forState:0];
                break;
            default:
                break;
        }
        [btn addTarget:self action:@selector(footBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        btn.sd_layout
        .centerXEqualToView(view)
        .bottomSpaceToView(view,48)
        .widthIs(kWidth(225))
        .heightIs(36);
        _tableFootView = view;
    }
    return _tableFootView;
}

@end
