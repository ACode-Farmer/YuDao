//
//  YDPhoneContactsController.m
//  YuDao
//
//  Created by 汪杰 on 16/11/22.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDPhoneContactsController.h"
#import "YDContactsModel.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>
#import "YDPhoneContactsCell.h"

#define kUploadPhoneContactsURL @"http://www.ve-link.com/yulian/api/contacts"

@interface YDPhoneContactsController ()<UISearchBarDelegate,MFMessageComposeViewControllerDelegate,YDPhoneContactsCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSString *contactsString;

@end

@implementation YDPhoneContactsController
{
    NSMutableArray *_phoneStringArray;
    NSMutableArray *_JoinedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机联系人";
    self.tableView.rowHeight = 53.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YDPhoneContactsCell class] forCellReuseIdentifier:@"YDPhoneContactsCell"];
    
    self.dataSource = [NSMutableArray array];
    _phoneStringArray = [NSMutableArray array];
    
    [self loadPerson];
    
//    [YDMBPTool showLoading];
//    YDWeakSelf(self);
//    [YDNetworking postUrl:kUploadPhoneContactsURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token,@"contacts":self.contactsString? self.contactsString :@""} success:^(NSURLSessionDataTask *task, id responseObject) {
//        [YDMBPTool hideAlert];
//        
//        NSDictionary *originalDic = [responseObject mj_JSONObject];
//        NSString *status = [originalDic valueForKey:@"status"];
//        NSArray  *dataArray = [originalDic objectForKey:@"data"];
//        _JoinedArray = [dataArray copy];
//        for (YDContactsModel *model in weakself.dataSource) {
//            for (NSDictionary *dic in _JoinedArray) {
//                NSString *phone = [dic valueForKey:@"name"];
//                NSNumber *ud_id = [dic valueForKey:@"ub_id"];
//                if ([phone isEqualToString:model.phoneNumber] && ![ud_id isEqual:[YDUserDefault defaultUser].user.ub_id]) {
//                    [model setUb_id:ud_id];
//                    [model setIsJoined:YES];
//                }
//            }
//        }
//        [weakself.tableView reloadData];
//        [YDMBPTool showBriefAlert:status time:1.5];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [YDMBPTool hideAlert];
//        NSLog(@"error = %@",error);
//    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    
}

#pragma mark - YDPhoneContactsCellDelegate
//点击添加好友或邀请加入
- (void)phoneContactsCell:(YDPhoneContactsCell *)cell touchedButton:(UIButton *)btn model:(YDContactsModel *)model{
    if ([btn.titleLabel.text isEqualToString:@"邀请加入"]) {
        [self showMessageView:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",model.phoneNumber], nil] title:model.name body:@"【遇道好友邀请】每天都会遇到新鲜事，每天都会遇到好玩的人，邀请你一起来加入《遇道》，和我一起发现新的惊喜吧！！"];
    }else{
        [YDMBPTool showLoading];
        [YDNetworking getUrl:kAddFriendURL parameters:@{@"access_token":[YDUserDefault defaultUser].user.access_token,@"f_ub_id":model.ub_id} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [YDMBPTool hideAlert];
            NSDictionary *originalDic = [responseObject mj_JSONObject];
            NSString *status = [originalDic valueForKey:@"status"];
            [YDMBPTool showBriefAlert:status time:1.5];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [YDMBPTool hideAlert];
            NSLog(@"error = %@",error);
            
        }];
    }
}

#pragma mark - 发送短信方法
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [YDMBPTool hideAlert];
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - 发送短信代理方法
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

#pragma mark - Private Methods
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
            [YDMBPTool showBriefAlert:@"无访问通讯录权限" time:1.5];
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
    //__weak YDPhoneContactsController *weakSelf = self;
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for ( int i = 0; i < numberOfPeople; i++){
        YDContactsModel *model = [[YDContactsModel alloc] init];
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        model.name = [NSString stringWithFormat:@"%@%@",lastName?lastName:@"",firstName?firstName:@""];
        
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            
            if ([personPhoneLabel isEqualToString:@"mobile"] || [personPhoneLabel isEqualToString:@"手机"] || [personPhoneLabel isEqualToString:@"住宅"] || [personPhoneLabel isEqualToString:@"工作"] || [personPhoneLabel isEqualToString:@"iPhone"] || [personPhoneLabel isEqualToString:@"主要"]) {
                model.phoneNumber = personPhone;
            }
        }
        if (model.phoneNumber && model.name) {
            [self.dataSource addObject:model];
        }
    }
    CFRelease(people);
    
    for (YDContactsModel *model in self.dataSource) {
        if (model.phoneNumber) {
            [_phoneStringArray addObject:model.phoneNumber];
        }
    }
    self.contactsString = [_phoneStringArray componentsJoinedByString:@","];
    self.indexArray = [YDContactsModel IndexArray:self.dataSource];
    self.letterResultArr = [YDContactsModel LetterSortArray:self.dataSource];
}



#pragma mark - UITableViewDataSource
//组标题数据源
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}
//组眉
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YDPhoneContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YDPhoneContactsCell"];
    YDContactsModel *model = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, tableView.width, tableView.height) animated:NO];
        return -1;
    }
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    YDContactsModel *model = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    YDChatViewController *chatVC = [YDChatViewController sharedChatVC];
//    chatVC.chatToJid = model.jid;
//    chatVC.title = model.name;
//    [self.navigationController secondLevel_push_fromViewController:self toVC:chatVC];
}

#pragma mark - Getter -
- (YDSearchController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[YDSearchController alloc] initWithSearchResultsController:self.friendSearchVC];
        [_searchController setSearchResultsUpdater:self.friendSearchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setDelegate:self];
    }
    return _searchController;
}

@end
