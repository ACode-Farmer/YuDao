//
//  YDGarageViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/14.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDGarageViewController.h"

#import "YDIllegalViewController.h"
#import "YDGaragesCell.h"
#import "YDBrandController.h"
#import "YDCarAuthenticateController.h"
#import "YDCarHelper.h"
#import "YDIllegalViewController.h"
#import "YDBindOBDController.h"

#import "YDCarMessageViewController.h"

#define kMyGarageURL @"http://www.ve-link.com/yulian/api/vehiclelist"


@interface YDGarageViewController ()<YDGaragesCellDelegate>

@property (nonatomic, strong) NSMutableArray<YDCarDetailModel *> *data;

@end

@implementation YDGarageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的车库";
    
    self.tableView.rowHeight = 165.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YDGaragesCell class] forCellReuseIdentifier:@"YDGaragesCell"];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_contacts_addPerson"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAcion:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _data = [NSMutableArray arrayWithArray:[YDCarHelper sharedHelper].carArray];
    [self.tableView reloadData];
    if (_data.count == 0) {
        NSLog(@"数据库空，联网请求数据");
        [self getMyGarageData];
    }
    
}

- (void)waitToLoadDataBase{

}

- (void)getMyGarageData{
    //[YDMBPTool showLoading];
    if (YDHadLogin) {
        __weak YDGarageViewController *weakSelf = self;
        [YDNetworking getUrl:kMyGarageURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token} progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            [YDMBPTool hideAlert];
            NSDictionary *originalDic = [responseObject mj_JSONObject];
            NSArray *dataArray = [originalDic objectForKey:@"data"];
            NSArray *garageArray = [YDCarDetailModel mj_objectArrayWithKeyValuesArray:dataArray];
            [[YDCarHelper sharedHelper] insertCars:garageArray];
            [weakSelf.data removeAllObjects];
            [weakSelf.data addObjectsFromArray:garageArray];
            [weakSelf.tableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [YDMBPTool hideAlert];
            NSLog(@"error = %@",error);
        }];
    }
    
}

#pragma mark - Events
- (void)rightBarButtonItemAcion:(id)sender{
    if (self.data.count == 5 || self.data.count > 5) {
        [UIAlertView bk_showAlertViewWithTitle:@"最多只能添加五辆车" message:nil cancelButtonTitle:@"确认" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        }];
    }else{
        [self.navigationController pushViewController:[YDBrandController new] animated:YES];
    }
    
}

#pragma mark - YDGaragesCellDelegate
//MARK:点击单元格里的button
- (void)garagesCell:(YDGaragesCell *)cell didTouchButton:(UIButton *)sender{
    NSString *title = sender.titleLabel.text;
    NSLog(@"title = %@",title);
    if ([title isEqualToString:@"车辆认证"]) {
        YDCarAuthenticateController *vc = [YDCarAuthenticateController new];
        vc.ug_id = cell.model.ug_id;
        vc.ug_vehicle_auth = cell.model.ug_vehicle_auth;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"违章查询"]){
        YDIllegalViewController *illegalVC = [YDIllegalViewController new];
        illegalVC.ug_id = cell.model.ug_id;
        [self.navigationController pushViewController:illegalVC animated:YES];
    }else if ([title isEqualToString:@"绑定VE-BOX"]){
        YDBindOBDController *bindVC = [YDBindOBDController new];
        bindVC.ug_id = cell.model.ug_id;
        [self.navigationController pushViewController:bindVC animated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data.count == 5) {
        return self.data.count;
    }
    return self.data? self.data.count + 1: 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDGaragesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDGaragesCell"];
    cell.delegate = self;
    if (indexPath.row == _data.count && _data.count < 5) {
        UITableViewCell *addCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addCell"];
        addCell.selectionStyle = 0;
        UIImageView *addImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_garage_addCar"]];
        [addCell.contentView addSubview:addImageV];
        addImageV.sd_layout.spaceToSuperView(UIEdgeInsetsMake(7, 19, 7, 19));
        return addCell;
    }else{
        cell.model = self.data[indexPath.row];
        YDWeakSelf(self);
        [cell setGaragesCellDeleteCarBlock:^(YDCarDetailModel *model) {
            if (model.ug_boundtype.integerValue == 1) {
                [YDMBPTool showBriefAlert:@"请先解绑VE-BOX..." time:1.5];
                return ;
            }
            YDSystemActionSheet *actionS = [[YDSystemActionSheet alloc] initViewWithTitle:@"删除" title:nil clickedBlock:^(NSInteger index) {
                if (index == 1) {
                    //[YDMBPTool showMessage:@"删除中"];
                    [weakself deleteCar:model];
                }
            }];
            [actionS show];
            [weakself.view addSubview:actionS];
        }];
    }
    //cell.delegate = self;
    return cell;
}
//MARK:删除车辆
- (void)deleteCar:(YDCarDetailModel *)car{
    YDWeakSelf(self);
    [YDNetworking postUrl:kDeleteCar parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token,@"ug_id":car.ug_id} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *code = [[responseObject  mj_JSONObject] valueForKey:@"status_code"];
        if ([code isEqual:@200]) {
            [_data enumerateObjectsUsingBlock:^(YDCarDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YDCarDetailModel *model = obj;
                if ([model.ug_id isEqual:car.ug_id]) {
                    [_data removeObjectAtIndex:idx];
                    [[YDCarHelper sharedHelper] deleteOneCar:car.ug_id];
                    *stop = YES;
                    
                    [weakself.tableView reloadData];
                    
                    //[weakself getMyGarageData];
                }
            }];
        }else if ([code isEqual:@9024]){
            [YDMBPTool showBriefAlert:@"请先解除绑定的VE-BOX" time:1.f];
        }else{
            [YDMBPTool showBriefAlert:@"删除车辆失败" time:1.f];
            NSLog(@"删除车辆失败: %@",[responseObject  mj_JSONObject]);
        }
        //[YDMBPTool hideAlert];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"删除车辆失败: %@",error);
        //[YDMBPTool hideAlert];
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //YDCarDetailModel *model = self.data[indexPath.row];
    
    if (self.didSelectedCarBlock) {
        //self.didSelectedCarBlock(model);
        //[self.navigationController popViewControllerAnimated:YES];
    }else{
        if (indexPath.row == _data.count && _data.count < 5) {//点击添加车辆
            [self rightBarButtonItemAcion:nil];
        }else{
//            YDCarDetailViewController *carDetail = [YDCarDetailViewController new];
//            YDCarDetailModel *model = self.data[indexPath.row];
//            if (model.ug_vehicle_auth.integerValue == 1) {
//                carDetail.hadAuth = YES;
//            }else{
//                carDetail.hadAuth = NO;
//            }
//            carDetail.ug_id = model.ug_id;
//            [self.navigationController secondLevel_push_fromViewController:self toVC:carDetail];
            YDCarMessageViewController *messageVC = [YDCarMessageViewController new];
            YDCarDetailModel *model = self.data[indexPath.row];
            messageVC.selectedCarId = model.ug_id;
            [self.navigationController pushViewController:messageVC animated:YES];
        }
    }
}

#pragma mark - Getters
- (NSMutableArray *)data{
    if (!_data) {
        _data = [YDCarHelper sharedHelper].carArray;
    }
    return _data;
}

@end
