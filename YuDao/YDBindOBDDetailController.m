//
//  YDBindOBDDetailController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDBindOBDDetailController.h"
#import "YDBindOBDCell.h"
#import "YDMainViewController.h"
#import "YDGarageViewController.h"
#import "YDChooseDefaultCarTableView.h"
#import "CaptureViewController.h"

#define kBindOBDURL @"http://www.ve-link.com/yulian/api/bound"

static NSString *kBindOBDCellID = @"YDBindOBDCell";

@interface YDBindOBDDetailController ()<YDBindOBDCellDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) YDChooseDefaultCarTableView *chooseTable;

@property (nonatomic, strong) YDCarDetailModel *carDetail;

@end

@implementation YDBindOBDDetailController
{
    NSInteger _selectedIndex;
    UIButton *_defaultBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"输入设备号"];
    
    [self.tableView setTableFooterView:self.bottomView];
    [self.tableView registerClass:[YDBindOBDCell class] forCellReuseIdentifier:kBindOBDCellID];
    
    _selectedIndex = -1;
    
}

#pragma mark - Events
//点击绑定
- (void)bindButtonAction:(UIButton *)sender{
    if (!self.ug_id) {
        [YDMBPTool showBriefAlert:@"车辆不可为空" time:1.0];
        return;
    }
    sender.selected = !sender.selected;
    YDBindOBDCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell.textF resignFirstResponder];
    [YDMBPTool showLoading];
    YDWeakSelf(self);
    NSDictionary *parameters = @{@"access_token":[YDUserDefault defaultUser].user.access_token,
                                 @"obd_IMEI":cell.textF.text,
                                 @"ug_id":self.ug_id,
                                 @"ug_status":_defaultBtn.selected ? @1 : @0};
    [YDNetworking postUrl:kBindOBDURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [YDMBPTool hideAlert];
        
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSNumber *status_code = [originalDic valueForKey:@"status_code"];
        NSString *status = [originalDic valueForKey:@"status"];
        NSLog(@"status_code = %@",status_code);
        [YDMBPTool showBriefAlert:status time:1.5];
        if ([status_code isEqual:@200]) {
            [[YDCarHelper sharedHelper] insertOneCar:weakself.carDetail];
            for (id vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[YDMainViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }else if ([vc isKindOfClass:[YDGarageViewController class]]){
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YDMBPTool hideAlert];
        NSLog(@"error = %@",error);
    }];
}

- (void)defaultButtonAcion:(UIButton *)defaultBtn{
    defaultBtn.selected = !defaultBtn.selected;
    
}

#pragma mark - YDBindOBDCellDelegate
- (void)bindOBDCell:(YDBindOBDCell *)cell didTouchChooseButton:(UIButton *)btn{
    if ([cell.titleLabel.text isEqualToString:@"设备号"]) {
        CaptureViewController *capture = [CaptureViewController new];
        YDNavigationController *naviVC = [[YDNavigationController alloc] initWithRootViewController:capture];
        capture.CaptureSuccessBlock = ^(CaptureViewController *captureVC,NSString *s){
            NSLog(@"url = %@",s);
            [captureVC dismissViewControllerAnimated:YES completion:nil];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]];
        };
        capture.CaptureFailBlock = ^(CaptureViewController *captureVC){
            [captureVC dismissViewControllerAnimated:YES completion:nil];
        };
        capture.CaptureCancelBlock = ^(CaptureViewController *captureVC){
            [captureVC dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:naviVC animated:YES completion:nil];

    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data? self.data.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDBindOBDCell *cell = [tableView dequeueReusableCellWithIdentifier:kBindOBDCellID];
    if (indexPath.row == 0) {
        cell.textF.enabled = NO;
    }
    cell.model = self.data[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        for (YDBindOBDCell *cell in self.tableView.visibleCells) {
            [cell.textF resignFirstResponder];
        }
        //遍历出已选车辆的index
        if (_selectedIndex < 0) {
            [[YDCarHelper sharedHelper].carArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YDCarDetailModel *car = obj;
                if ([car.ug_id isEqual:self.ug_id]) {
                    _selectedIndex = idx;
                    *stop = YES;
                }
            }];
        }
        _chooseTable = [[YDChooseDefaultCarTableView alloc] initWithFrame:CGRectMake(screen_width-64, 84, 0, 0) data:[YDCarHelper sharedHelper].carArray selectedIndex:_selectedIndex];
        YDWeakSelf(self);
        [_chooseTable setSelectedCarBlock:^(YDCarDetailModel *model, NSInteger selectedIndex) {
            _selectedIndex = selectedIndex;
            YDBindOBDCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.textF.text = model.ug_series_name;
            weakself.ug_id = model.ug_id;
            weakself.carDetail = [[YDCarHelper sharedHelper] getOneCarWithCarid:model.ug_id];
        }];
        [_chooseTable popAtView:[UIApplication sharedApplication].keyWindow];
    }
    
    
//    YDBindOBDModel *model = self.data[indexPath.row];
//    if ([model.title isEqualToString:@"请选择要绑定的车辆"]) {
//        YDGarageViewController *garageVC =  [YDGarageViewController new];
//        YDWeakSelf(self);
//        [garageVC setDidSelectedCarBlock:^(YDCarDetailModel *car) {
//            [weakself.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                YDBindOBDModel *model = (YDBindOBDModel *)obj;
//                if (idx == 3) {
//                    model.subTitle = car.ug_brand_name;
//                }else if (idx == 4){
//                    model.subTitle = car.ug_series_name;
//                }else if (idx == 5){
//                    model.subTitle = car.ug_model_name;
//                }
//            }];
//            weakself.ug_id = car.ug_id;
//            [weakself.tableView reloadData];
//        }];
//        [self.navigationController secondLevel_push_fromViewController:self toVC:garageVC];
//    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (YDBindOBDCell *cell in self.tableView.visibleCells) {
        [cell.textF resignFirstResponder];
    }
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray arrayWithCapacity:3];
        if (self.ug_id) {
            self.carDetail = [[YDCarHelper sharedHelper] getOneCarWithCarid:self.ug_id];
        }
        NSString *car_series_name = self.carDetail ? self.carDetail.ug_series_name :@"请选择已有车辆或绑定新车辆";
        YDBindOBDModel *model1 = [YDBindOBDModel modelWithTitle:@"选择车辆" placeholder:car_series_name imageString:@"bingOBD_detail_rightArrow"];
        YDBindOBDModel *model2 = [YDBindOBDModel modelWithTitle:@"设备号" placeholder:@"请输入VE-BOX设备上的编号" imageString:@"bingOBD_detail_sm"];
        YDBindOBDModel *model3 = [YDBindOBDModel modelWithTitle:@"设备序列号" placeholder:@"请输入VE-BOX设备上的序列号" imageString:nil];
        
        [_data addObjectsFromArray:@[model1,model2,model3]];
        
    }
    return _data;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.frame = CGRectMake(0, 0, screen_width, screen_height-210);
        
        UIButton *defaultBtn = [YDUIKit buttonWithImage:[UIImage imageNamed:@"bindOBD_defaultCar_normal"] selectedImage:[UIImage imageNamed:@"bindOBD_defaultCar_selected"] selector:@selector(defaultButtonAcion:)  target:self];
        [defaultBtn setTitle:@"设为默认车辆" forState:0];
        [defaultBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:7];
        [defaultBtn setTitleColor:[UIColor colorWithString:@"#2B3552"] forState:0];
        defaultBtn.frame = CGRectMake(0, 10, 120, 30);
        [defaultBtn.titleLabel setFont:[UIFont font_12]];
        
        _defaultBtn = defaultBtn;
        [_bottomView addSubview:defaultBtn];
        
        UIButton *button = [YDUIKit buttonWithTitle:@"绑定" titleColor:[UIColor whiteColor]   target:self];
        [button addTarget:self action:@selector(bindButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithString:@"#2B3552"];
        button.layer.cornerRadius = 8.0f;
        
        [_bottomView addSubview:button];
        
        button.sd_layout
        .bottomSpaceToView(_bottomView,32)
        .leftSpaceToView(_bottomView,74)
        .rightSpaceToView(_bottomView,74)
        .heightIs(36);
    }
    return _bottomView;
}

@end
