//
//  YDIllegalViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/18.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDIllegalViewController.h"
#import "YDIllegalModel.h"

#define kIllegalDataURL @"http://www.ve-link.com/yulian/api/wzquery"

@interface YDIllegalViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *noDataLabel;

@end

@implementation YDIllegalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"违章记录"];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.noDataLabel];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [YDMBPTool showLoading];
    YDWeakSelf(self);
    [YDNetworking postUrl:kIllegalDataURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token,@"ug_id":self.ug_id} success:^(NSURLSessionDataTask *task, id responseObject) {
        [YDMBPTool hideAlert];
        
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSNumber *status_code = [originalDic valueForKey:@"status_code"];
        NSString *status = [originalDic valueForKey:@"status"];
        if ([status_code isEqual:@200]) {
            NSArray *tempData = [originalDic objectForKey:@"data"];
            if (tempData || tempData.count > 0) {
                //weakself.data = [YDIllegalModel mj_objectArrayWithKeyValuesArray:tempData];
            }else{
                weakself.noDataLabel.hidden = NO;
            }
        }else{//没有数据
            weakself.noDataLabel.hidden = NO;
        }
        [YDMBPTool showBriefAlert:status time:1.5];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        weakself.noDataLabel.hidden = NO;
        [YDMBPTool hideAlert];
        NSLog(@"error = %@",error);
    }];
}

#pragma mark  - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data ? self.data.count : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data ? [self.data[section] count ]: 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *YDLCellID = @"YDLCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YDLCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:YDLCellID];
    }
    NSDictionary *dic = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic allKeys][0];
    cell.detailTextLabel.text = [dic valueForKey:cell.textLabel.text];
    return cell;
}

#pragma mark  - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

#pragma mark - Getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 45.f;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = [UITableViewHeaderFooterView new];
    }
    return _tableView;
}

- (UILabel *)noDataLabel{
    if (!_noDataLabel) {
        _noDataLabel = [YDUIKit labelWithTextColor:[UIColor colorWithString:@"#2B3552"] text:@"您没有违章信息，请继续保持!" fontSize:16 textAlignment:NSTextAlignmentCenter];
        _noDataLabel.frame = CGRectMake(0, kHeight(140), screen_width, 21);
        _noDataLabel.hidden = YES;
    }
    return _noDataLabel;
}


@end
