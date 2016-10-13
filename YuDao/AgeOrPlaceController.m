//
//  AgeOrPlaceController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "AgeOrPlaceController.h"
#import "ProvinceController.h"

#import "IQActionSheetPickerView.h"
#import "APCell.h"
#import "APModel.h"

static NSString *const APCellIdentifier = @"APCell";

@interface AgeOrPlaceController ()<IQActionSheetPickerViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation AgeOrPlaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - TableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource ? self.dataSource.count: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    APCell *cell = [tableView dequeueReusableCellWithIdentifier:APCellIdentifier];
    if (cell == nil) {
        cell = [[APCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:APCellIdentifier];
    }
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.vcType) {
        case ControllerTypeAge:
        {
            if (indexPath.row == 0) {
                IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"出生年月日" delegate:self];
                [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
                [picker show];
            }
            break;}
        case ControllerTypePlace:
        {
            if (indexPath.row == 0) {
                
            }else{
                [self.navigationController pushViewController:[ProvinceController new] animated:YES];
            }
            break;}
        case ControllerTypeGender:
        {
            APModel *model = self.dataSource[indexPath.row];
            model.type = CellTypeCheckmark;
            [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj isEqual:model]) {
                    APModel *m = (APModel *)obj;
                    m.type = CellTypeSubTitle;
                }
            }];
            [tableView reloadData];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:model.title forKey:self.title];
            [defaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            break;}
        case ControllerTypeEmotion:
        {
            APModel *model = self.dataSource[indexPath.row];
            model.type = CellTypeCheckmark;
            [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj isEqual:model]) {
                    APModel *m = (APModel *)obj;
                    m.type = CellTypeSubTitle;
                }
            }];
            [tableView reloadData];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:model.title forKey:self.title];
            [defaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            break;}
        default:
            break;
    }
}

#pragma mark - PickerViewDelegate
- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//日历
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
    NSInteger year = [components year];
    NSInteger month = [components month];
    //NSInteger day = [components day];
    if (month>=0) {
        year+=1;
    }
    NSString *age = [NSString stringWithFormat:@"%ld",year];
    APModel *model = self.dataSource[0];
    model.subTitle = age;
    [self.tableView reloadData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:age forKey:self.title];
    [defaults synchronize];
}

#pragma mark - Getters
- (NSArray *)dataSource{
    if (!_dataSource) {
        switch (self.vcType) {
            case ControllerTypeAge:
            {
                self.title = @"年龄";
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *age = [defaults stringForKey:self.title];
                APModel *model1 = [APModel modelWithTitle:@"年龄" subTitle:age cellType:CellTypeArrow];
                APModel *model2 = [APModel modelWithTitle:@"星座" subTitle:@"天枰座" cellType:CellTypeSubTitle];
                APModel *model3 = [APModel modelWithTitle:@"公开年龄" subTitle:nil cellType:CellTypeSwitch];
                _dataSource = @[model1,model2,model3];
                break;}
            case ControllerTypePlace:
            {
                self.title = @"常出没地点";
                APModel *model1 = [APModel modelWithTitle:@"国家" subTitle:@"中国" cellType:CellTypeSubTitle];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *place = [defaults stringForKey:@"常出没地点"];
                APModel *model2 = [APModel modelWithTitle:@"地区" subTitle:place cellType:CellTypeArrow];
                _dataSource = @[model1,model2];
                break;}
            case ControllerTypeGender:
            {
                self.title = @"性别";
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *gender = [defaults stringForKey:self.title];
                APModel *model1 = [APModel modelWithTitle:@"男" subTitle:nil cellType:CellTypeSubTitle];
                APModel *model2 = [APModel modelWithTitle:@"女" subTitle:nil cellType:CellTypeSubTitle];
                if ([gender isEqualToString:@"男"]) {
                    model1.type = CellTypeCheckmark;
                }else{
                    model2.type = CellTypeCheckmark;
                }
                _dataSource = @[model1,model2];
                break;}
            case ControllerTypeEmotion:
            {
                self.title = @"情感状态";
                APModel *model1 = [APModel modelWithTitle:@"单身" subTitle:nil cellType:CellTypeSubTitle];
                APModel *model2 = [APModel modelWithTitle:@"热恋中" subTitle:nil cellType:CellTypeSubTitle];
                APModel *model3 = [APModel modelWithTitle:@"已婚" subTitle:nil cellType:CellTypeSubTitle];
                APModel *model4 = [APModel modelWithTitle:@"保密" subTitle:nil cellType:CellTypeSubTitle];
                _dataSource = @[model1,model2,model3,model4];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *emotion = [defaults stringForKey:self.title];
                [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    APModel *checkModel = (APModel *)obj;
                    if ([checkModel.title isEqual:emotion]) {
                        checkModel.type = CellTypeCheckmark;
                        *stop = YES;
                    }
                }];
                break;}
            default:
                break;
        }
    }
    return _dataSource;
}


@end
