//
//  MyselfController.m
//  JiaPlus
//
//  Created by 汪杰 on 16/9/2.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMyselfController.h"

#import "YDLikePeopleController.h"

#import "YDQRCodeController.h"
#import "YDGarageViewController.h"

#import "YDMyselfModel.h"
#import "YDMyselfCell.h"

#import "YDContactsViewController.h"
#import "YDMyDataViewController.h"

#import "YDMyselfHeaderView.h"

#import "YDMyDynamicController.h"
#import "YDConversationController.h"

#import "YDVisitorsCell.h"
#import "YDUserFilesController.h"
#import "YDVisitorsController.h"

#import "YDChatController.h"

#define kLikeMeURL @"http://www.ve-link.com/yulian/api/enjoymy"

@interface YDMyselfController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,YDMyselfHeaderViewDelegate,YDVisitorsCellDelegate>

@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YDMyselfHeaderView *userHeaderView;

@end

@implementation YDMyselfController
{
    YDUser        *_user;
    
    NSMutableArray *_visitors;
    
    NSNumber      *_likeNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"discover_test_set"] style:UIBarButtonItemStylePlain target:self action:@selector(myselfRightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getNumberOfLikes];
    
    //刷新用户信息
    _user = [[YDUserDefault defaultUser].user getTempUserData];
    [self.userHeaderView updateDataWith:_user.ud_face name:_user.ub_nickname start:_user.ud_constellation gender:_user.ud_sex.integerValue level:[NSString stringWithFormat:@"V%@",_user.ub_auth_grade] likeNum:_likeNum?_likeNum:@0 score:_user.ud_credit backgroudImageUrl:_user.ud_background];
    //下载访客记录
    [self downloadVisitors];
    
    //获取通知数量
    YDMyselfModel *messageModel = [self.datasource objectAtIndex:3];
    NSInteger conversationUnreadCount = [[YDConversationHelper shareInstance] allUnreadMessageByUid:[YDUserDefault defaultUser].user.ub_id];
    NSInteger systemUnreadCount = [[YDSystemMessageHelper sharedSystemMessageHelper] unreadSystemMessageCount];
    messageModel.remindCount = conversationUnreadCount + systemUnreadCount;
    [self.tableView reloadData];
    
}


//更新消息或联系人提醒
- (void)updateMessageOrContactsRemindWith:(YDNotificationType )type count:(NSInteger )count{
    if (type == YDNotificationTypeMessage) {
        YDMyselfModel *model = [self.datasource objectAtIndex:3];
        model.remindCount = count;
        [self.tableView reloadData];
    }
}

//获取喜欢的人数
- (void)getNumberOfLikes{
    YDWeakSelf(self);
    [YDNetworking getUrl:kLikeMePersonsURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"[responseObject mj_JSONObject] = %@",[responseObject mj_JSONObject]);
        NSNumber *likeNum = [[[responseObject mj_JSONObject] objectForKey:@"data"] valueForKey:@"num"];
        _likeNum = likeNum;
        if (likeNum) {
            //weakself.userHeaderView.likeLabel.text = [NSString stringWithFormat:@"%@人喜欢",likeNum];
            [weakself.userHeaderView.likeLabel setLabelAttributeWithContent:[NSString stringWithFormat:@"%@",likeNum] footString:@"  喜欢"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取喜欢的人数错误 error = %@",error);
    }];
}
//获取用户信息
- (void)getUserInformationWithUrl:(NSString *)url{
    YDWeakSelf(self);
    NSString *access_token = [YDUserDefault defaultUser].user.access_token;
    NSNumber *currentUserId = [YDUserDefault defaultUser].user.ub_id;
    [YDNetworking getUrl:kOtherFilesURL parameters:@{@"access_token":access_token?access_token:@"",@"ub_id":currentUserId} progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSDictionary *dataDic = [originalDic objectForKey:@"data"];
        NSLog(@"dataDic = %@",dataDic);
        [YDUserDefault defaultUser].user = [YDUser mj_objectWithKeyValues:dataDic];
        _user = [[YDUserDefault defaultUser].user getTempUserData];
        
        [weakself.userHeaderView updateDataWith:_user.ud_face name:_user.ub_nickname start:_user.ud_constellation gender:_user.ud_sex.integerValue level:[NSString stringWithFormat:@"V%@",_user.ub_auth_grade] likeNum:@0 score:_user.ud_credit backgroudImageUrl:_user.ud_background];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

//MARK:获取访客记录
- (void)downloadVisitors{
    YDWeakSelf(self);
    NSDictionary *parameters = @{@"access_token":[YDUserDefault defaultUser].user.access_token,
                                 @"limit":@5,
                                 @"type":@0};
    [YDNetworking getUrl:kVisitorsURL parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArray = [[responseObject mj_JSONObject] objectForKey:@"data"];
        _visitors = [YDVisitorsModel mj_objectArrayWithKeyValuesArray:dataArray];
        if (_visitors) {
            [_visitors addObject:[YDVisitorsModel new]];
            [weakself.datasource replaceObjectAtIndex:0 withObject:_visitors];
            [weakself.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"");
    }];
}

//MARK:点击背景视图
- (void)tapBackgroundViewAction:(UITapGestureRecognizer *)tap{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
    [controller setDelegate:self];// 设置代理
    YDSystemActionSheet *actionSheet = [[YDSystemActionSheet alloc] initViewWithMultiTitles:@[@"拍照",@"从相册中选取"] title:@"修改背景图片" clickedBlock:^(NSInteger index) {
        if (index == 1) {
            [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
            // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
            controller.mediaTypes = @[(NSString *)kUTTypeImage];
            [self presentViewController:controller animated:YES completion:nil];
        }else if (index == 2){
            [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:controller animated:YES completion:nil];
        }
    }];
    [actionSheet show];
    [self.view addSubview:actionSheet];
}

//MARK:喜欢 - YDMyselfHeaderViewDelegate
- (void)myselfHeaderView:(YDMyselfHeaderView *)headerView didSelectedIndex:(NSInteger )index{
    if (index == 1) {
        [self.navigationController pushViewController:[YDLikePeopleController new] animated:YES];
    }
}

#pragma mark - UIImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    YDWeakSelf(self);
    [YDNetworking uploadUserBackgroudImage:image url:kChangeUserBackgroudImageURL success:^{
        [weakself viewWillAppear:YES];
    } failure:^{
        [YDMBPTool showBriefAlert:@"修改背景失败" time:1];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Events
- (void)myselfRightBarButtonItemAction:(UIBarButtonItem *)sender{
//    YDChatController *chatVC = [YDChatController new];
//    chatVC.fid = @20;
//    [self.navigationController pushViewController:chatVC animated:YES];
    //[self pushViewController:@"YDChatController"];
    [self pushViewController:@"SetupTableViewController"];
}

#pragma mark - Private Methods
- (void)pushViewController:(NSString *)className{
    
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:[NSClassFromString(className) new] animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

#pragma mark - YDVisitorsCellDelegate
//MARK:点击访客
- (void)visitorsCell:(YDVisitorsCell *)cell didSelectedIndex:(NSInteger )index{
    NSLog(@"index = %ld",index);
    YDVisitorsModel *model = [_visitors objectAtIndex:index];
    if (index == _visitors.count-1) {
        YDVisitorsController *visitorsVC = [YDVisitorsController new];
        
        [self.navigationController pushViewController:visitorsVC animated:YES];
    }else{
        YDUserFilesController *userVC = [YDUserFilesController new];
        userVC.currentUserId = model.vis_id;
        [self.navigationController pushViewController:userVC animated:YES];
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datasource? self.datasource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YDVisitorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDVisitorsCell"];
        cell.visitors = _datasource[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    
    YDMyselfCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDMyselfCell"];
    cell.model = _datasource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kHeight(62);
    }
    return 57.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (YDHadLogin) {
        switch (indexPath.row) {
            case 1:
                [self.navigationController pushViewController:[YDMyDataViewController new] animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:[YDMyDynamicController new] animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:[YDConversationController new] animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:[YDGarageViewController new] animated:YES];
                break;
            case 5:
                [self.navigationController pushViewController:[YDContactsViewController new] animated:YES];
                break;
            case 6:
                [self.navigationController pushViewController:[YDQRCodeController new] animated:YES];
                break;
            default:
                break;
        }
    }else{
        [YDMBPTool showBriefAlert:@"未登录不可操作" time:1];
    }
    
}

//是否开启滑倒顶部后不可滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y < -64.f) {
        //[self.tableView setContentOffset:CGPointMake(0.f, -64.f)];
    }
    //NSLog(@"y = %f",y);
}

#pragma mark - Getters
- (NSMutableArray *)datasource{
    if (!_datasource) {
        YDMyselfModel *model1 = [YDMyselfModel modelWithIamgeName:@"mine_mainPage_information" name:@"我的资料"];
        YDMyselfModel *model2 = [YDMyselfModel modelWithIamgeName:@"mine_mainPage_dynamic" name:@"我的动态"];
        YDMyselfModel *model3 = [YDMyselfModel modelWithIamgeName:@"mine_mainPage_message" name:@"我的消息"];
        YDMyselfModel *model4 = [YDMyselfModel modelWithIamgeName:@"mine_mainPage_carpark" name:@"我的车库"];
        YDMyselfModel *model5 = [YDMyselfModel modelWithIamgeName:@"mine_mainPage_contacts" name:@"通讯录"];
        YDMyselfModel *model6 = [YDMyselfModel modelWithIamgeName:@"mine_mainPage_erCode" name:@"我的二维码"];
        _datasource = [NSMutableArray arrayWithArray:@[@[[YDVisitorsModel new]],model1,model2,model3,model4,model5,model6]];
    }
    return _datasource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height-64)];
        [_tableView setTableHeaderView:self.userHeaderView];
        [_tableView setTableFooterView:[UIView new]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithString:@"#6C7BA9"];
        [_tableView registerClass:[YDMyselfCell class] forCellReuseIdentifier:@"YDMyselfCell"];
        [_tableView registerClass:[YDVisitorsCell class] forCellReuseIdentifier:@"YDVisitorsCell"];
    }
    return _tableView;
}

- (YDMyselfHeaderView *)userHeaderView{
    if (_userHeaderView == nil) {
        _userHeaderView = [YDMyselfHeaderView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundViewAction:)];
        _userHeaderView.backImageV.userInteractionEnabled = YES;
        [_userHeaderView.backImageV addGestureRecognizer:tap];
        _userHeaderView.frame = CGRectMake(0, 0, screen_width, 322);
        _userHeaderView.delegate = self;
    }
    return _userHeaderView;
}

@end
