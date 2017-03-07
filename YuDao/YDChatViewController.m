//
//  RootViewController.m
//  UUChatTableView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "YDChatViewController.h"
#import "UUInputFunctionView.h"

#import "UUMessageCell.h"
#import "YDChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"



@interface YDChatViewController ()<UUInputFunctionViewDelegate,UUMessageCellDelegate,UITableViewDataSource,UITableViewDelegate,XMPPOutgoingFileTransferDelegate>

@property (strong, nonatomic) YDChatModel *chatModel;

@property (nonatomic, strong) FMDatabase *dataBase;

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) XMPPOutgoingFileTransfer *xmppOutgoingFileTransfer;

@property (nonatomic, strong) XMPPJID *toJid;

@property (nonatomic,strong) MJRefreshNormalHeader *refresHeader;

@end

@implementation YDChatViewController{
    UUInputFunctionView *IFView;
    int _page;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseViewsAndData];
    
    self.toJid = [XMPPJID jidWithUser:[NSString stringWithFormat:@"%@",self.chatToUserId] domain:@"ve-link.com" resource:@"iOS"];
    NSLog(@"self.toJid = %@",self.toJid);
    [self addNotifacation];
    
    //添加上拉加载
    self.chatTableView.mj_header = self.refresHeader;
    
    YDWeakSelf(self);
    [self y_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
        if (!hasMore) {
            weakself.chatTableView.mj_header = nil;
        }
        if (count > 0) {
            [weakself.chatTableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself tableViewScrollToBottomAnimated:NO];
            });
        }
    }];
}

//添加通知
- (void)addNotifacation{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageNotification:) name:kXMPP_INPUTING_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageNotification:) name:kXMPP_RECEIVE_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessageSuccessNotification:) name:kXMPP_SEND_MESSAGE_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessageFailNotification:) name:kXMPP_SEND_MESSAGE_FAIL object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottomAnimated:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//MARK:对方正在输入
- (void)inputingMessageNotification:(NSNotification *)noti{
    self.title = @"对方正在输入";
    
}

//MARK:获取聊天记录
- (void)y_tryToRefreshMoreRecord:(void (^)(NSInteger count, BOOL hasMore))complete{
    YDWeakSelf(self);
    [[YDXMPPTool sharedInstance] selectHistoryByFid:self.toJid page:_page complete:^(NSArray<XMPPMessageArchiving_Message_CoreDataObject *> *data, BOOL hasMore) {
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(XMPPMessageArchiving_Message_CoreDataObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary *dic = @{@"strContent": obj.body?obj.body:@"",
                                      @"type": @(UUMessageTypeText),
                                      @"strTime":obj.timestamp};
                if (obj.isOutgoing) {//自己的消息
                    [weakself.chatModel.dataSource insertObject:[self.chatModel addSpecifiedItem:dic] atIndex:0];
                }else{                  //别人发来的消息
                    [weakself.chatModel.dataSource insertObject:[self.chatModel addOthersItemWithContent:dic] atIndex:0];
                }
            }];
            complete(data.count,hasMore);
        }else{
            complete(0,hasMore);
        }
    }];
}

//MARK:接受到消息
- (void)receiveMessageNotification:(NSNotification *)noti{
    XMPPMessage *message = noti.object;
    if ([message.from.user isEqualToString:[NSString stringWithFormat:@"%@",self.chatToUserId]]) {
        NSDictionary *dic = @{@"strContent": message.body,
                              @"type": @(UUMessageTypeText)};
        [self.chatModel.dataSource addObject:[self.chatModel addOthersItemWithContent:dic]];
        [self.chatTableView reloadData];
        [self tableViewScrollToBottomAnimated:YES];
    }
    
}
//MARK:发送消息成功
- (void)sendMessageSuccessNotification:(NSNotification *)noti{
    XMPPMessage *message = noti.object;
    NSDictionary *dic = @{@"strContent": message.body,
                          @"type": @(UUMessageTypeText),
                          @"strTime":[NSDate date]};
    [self.chatModel.dataSource addObject:[self.chatModel addSpecifiedItem:dic]];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottomAnimated:YES];
}
//MARK:发送消息失败
- (void)sendMessageFailNotification:(NSNotification *)noti{
    
    
    
}


- (void)loadBaseViewsAndData{
    self.chatModel = [YDChatModel chatModelWithUserId:[YDUserDefault defaultUser].user.ub_id name:self.name headerUrl:self.headerUrl];
    self.chatModel.isGroupChat = NO;
    [self.chatModel populateRandomDataSource];
    
    IFView = [[UUInputFunctionView alloc] initWithSuperVC:self];
    IFView.delegate = self;
    [self.view addSubview:IFView];
    
    [self.chatTableView reloadData];
    [self tableViewScrollToBottomAnimated:YES];
}

-(void)keyboardChange:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    //adjust ChatTableView's height
    if (notification.name == UIKeyboardWillShowNotification) {
        self.bottomConstraint.constant = keyboardEndFrame.size.height+40;
    }else{
        self.bottomConstraint.constant = 40;
    }
    
    [self.view layoutIfNeeded];
    
    //adjust UUInputFunctionView's originPoint
    CGRect newFrame = IFView.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height-64;
    IFView.frame = newFrame;
    
    [UIView commitAnimations];
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottomAnimated:(BOOL )animated{
    if (self.chatModel.dataSource.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}


#pragma mark - InputFunctionViewDelegate
//MARK:文字
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
    NSLog(@"发送文字");
//    NSDictionary *dic = @{@"strContent": message,
//                          @"type": @(UUMessageTypeText)};
    funcView.TextViewInput.text = @"";
    [funcView changeSendBtnWithPhoto:YES];
//    [self dealTheFunctionData:dic];
    
    XMPPMessage *xmppMessage = [XMPPMessage messageWithType:@"chat" to:self.toJid];
    [xmppMessage addBody:message];
    NSString *timeStamp = YDTimeStamp([NSDate date]);
    [xmppMessage addSubject:[NSString stringWithFormat:@"10001,%@",timeStamp]];
    [[YDXMPPTool sharedInstance].xmppStream sendElement:xmppMessage];

    
}
//MARK:图片
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image imageUrl:(NSString *)imageUrl
{
    NSLog(@"发送图片 = %@",imageUrl);
    
    NSDictionary *dic = @{@"picture": image,
                          @"type": @(UUMessageTypePicture)};
    
    [self.chatModel.dataSource addObject:[self.chatModel addSpecifiedItem:dic] ];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    XMPPJID *toJid = [XMPPJID jidWithUser:[NSString stringWithFormat:@"%@",self.chatToUserId] domain:kHostName resource:@"iOS"];
    NSLog(@"toJid = %@",toJid);

    NSError *error;
    [self.xmppOutgoingFileTransfer sendData:imageData named:@"image.jpg" toRecipient:toJid description:nil error:&error];
    if (error) {
        NSLog(@"发送图片error = %@",error);
    }
}
//MARK:语言
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    NSLog(@"发送语言");
    NSDictionary *dic = @{@"voice": voice,
                          @"strVoiceTime": [NSString stringWithFormat:@"%d",(int)second],
                          @"type": @(UUMessageTypeVoice)};
    [self dealTheFunctionData:dic];
    
    NSError *error = nil;
    [self.xmppOutgoingFileTransfer sendData:voice named:@"voice.mp3" toRecipient:[XMPPJID jidWithUser:[NSString stringWithFormat:@"%@",self.chatToUserId] domain:kHostName resource:@"iOS"] description:@"xx" error:&error];
    if (error) {
        NSLog(@"发送声音失败 error = %@",error);
    }
    
}
//处理数据
- (void)dealTheFunctionData:(NSDictionary *)dic{
    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottomAnimated:YES];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    [cell setMessageFrame:self.chatModel.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.chatModel.dataSource[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
//MARK:点击头像
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.messageFrame.message.strName message:@"headImage clicked" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Getters
- (XMPPOutgoingFileTransfer *)xmppOutgoingFileTransfer
{
    if (!_xmppOutgoingFileTransfer) {
        _xmppOutgoingFileTransfer = [[XMPPOutgoingFileTransfer alloc] initWithDispatchQueue:dispatch_get_global_queue(0, 0)];
        [_xmppOutgoingFileTransfer activate:[YDXMPPTool sharedInstance].xmppStream];
        [_xmppOutgoingFileTransfer addDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    return _xmppOutgoingFileTransfer;
}
#pragma mark - 文件发送代理
- (void)xmppOutgoingFileTransfer:(XMPPOutgoingFileTransfer *)sender
                didFailWithError:(NSError *)error
{
    NSLog(@"文件发送失败:%@",error);
}

- (void)xmppOutgoingFileTransferDidSucceed:(XMPPOutgoingFileTransfer *)sender
{
    NSLog(@"文件发送成功");
    /*
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.chatJID];
    
    //将这个文件的发送者添加到message的from
    [message addAttributeWithName:@"from" stringValue:[JKXMPPTool sharedInstance].xmppStream.myJID.bare];
    [message addSubject:@"audio"];
    
    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:sender.outgoingFileName];
    
    [message addBody:path.lastPathComponent];
    
    [[JKXMPPTool sharedInstance].xmppMessageArchivingCoreDataStorage archiveMessage:message outgoing:NO xmppStream:[JKXMPPTool sharedInstance].xmppStream];
     */
}


- (MJRefreshNormalHeader *)refresHeader{
    if (!_refresHeader) {
        YDWeakSelf(self);
        _refresHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page++;
            [weakself y_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
                [weakself.chatTableView.mj_header endRefreshing];
                if (!hasMore) {
                    weakself.chatTableView.mj_header = nil;
                }
                if (count > 0) {
                    [weakself.chatTableView reloadData];
                    [weakself.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }];
        }];
        _refresHeader.lastUpdatedTimeLabel.hidden = YES;
        _refresHeader.stateLabel.hidden = YES;
        _refresHeader.arrowView.image = [UIImage imageNamed:@"load_bottom_arrow"];
        //setTitle:(NSString *)title forState:(MJRefreshState)state;
        [_refresHeader setTitle:@"下拉加载更多" forState:MJRefreshStateIdle];
//        [_refresHeader setTitle:@"释放到达所有动态" forState:MJRefreshStatePulling];
//        [_refresHeader setTitle:@"释放到达所有动态" forState:MJRefreshStateRefreshing];
//        [_refresHeader setTitle:@"释放到达所有动态" forState:MJRefreshStateWillRefresh];
        [_refresHeader setTitle:@"下拉加载更多" forState:MJRefreshStateNoMoreData];
    }
    return _refresHeader;
}

@end
