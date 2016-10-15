//
//  PhoneContactsTableViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/8.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "PhoneContactsTableViewController.h"
#import <AddressBook/AddressBook.h>
#import "YDContactsModel.h"

@interface PhoneContactsTableViewController ()

@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic, strong) UILabel *sectionTitleView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PhoneContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPerson];
    _indexArray = [YDContactsModel IndexArray:_dataSource];
    _dataSource = [YDContactsModel LetterSortArray:_dataSource];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(loadPerson) withObject:nil afterDelay:2];
}

/**
 *  判断能否访问用户通讯录,调用此方法获得数据源
 */
- (void)loadPerson
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            [self copyAddressBook:addressBook];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        [self copyAddressBook:addressBook];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            //[hud turnToError:@"没有获取通讯录权限"];
        });
    }
    
}

/**
 *  获得通讯录的每个人
 *
 *  @param addressBook 用户通讯录
 */
- (void)copyAddressBook:(ABAddressBookRef)addressBook
{
    _dataSource = [NSMutableArray array];
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for ( int i = 0; i < numberOfPeople; i++){
        YDContactsModel *model = [[YDContactsModel alloc] init];
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        model.name = [NSString stringWithFormat:@"%@%@",firstName,lastName];
        
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            
            if ([personPhoneLabel isEqualToString:@"mobile"] || [personPhoneLabel isEqualToString:@"手机"]) {
                model.phoneNumber = personPhone;
            }
        }
        [_dataSource addObject:model];
    }
    CFRelease(people);
}

#pragma mark - UITableViewDataSource
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryView = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, 100, 40);
            [button setTitle:@"邀请加入" forState:0];
            button.titleLabel.textAlignment = NSTextAlignmentRight;
            [button setTitleColor:[UIColor orangeColor] forState:0];
            [button addTarget:self action:@selector(friendOperation:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    YDContactsModel *model = [[self.dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self showSectionTitle:title];
    return index;
}

#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [UILabel new];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor lightGrayColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)friendOperation:(UIButton *)sender{
    NSLog(@"邀请加入或添加好友!");
}


#pragma mark - private
- (void)timerHandler:(NSTimer *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.sectionTitleView.alpha = 0;
        } completion:^(BOOL finished) {
            self.sectionTitleView.hidden = YES;
            [self.timer invalidate];
            self.timer = nil;
        }];
    });
}

-(void)showSectionTitle:(NSString*)title{
    self.sectionTitleView.text = title;
    self.sectionTitleView.hidden = NO;
    self.sectionTitleView.alpha = 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (UILabel *)sectionTitleView{
    if (!_sectionTitleView) {
        _sectionTitleView = [[UILabel alloc] initWithFrame:CGRectMake((screen_width-100)/2, (screen_height-100)/2,100,100)];
        _sectionTitleView.textAlignment = NSTextAlignmentCenter;
        _sectionTitleView.font = [UIFont boldSystemFontOfSize:60];
        _sectionTitleView.textColor = [UIColor blueColor];
        _sectionTitleView.backgroundColor = [UIColor clearColor];
        //            sectionTitleView.layer.cornerRadius = 6;
        //            sectionTitleView.layer.borderWidth = 1.0f;
        _sectionTitleView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [self.navigationController.view addSubview:_sectionTitleView];
    }
    return _sectionTitleView;
}


@end
