//
//  YDChatBaseViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/20.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDChatBaseViewController.h"

#import "YDChatBaseViewController+ChatBar.h"
#import "YDChatBaseViewController+MessageDisplayView.h"
#import "YDChatBaseViewController+Proxy.h"

#import "UIImage+Size.h"
#import "NSFileManager+YDChat.h"

@interface YDChatBaseViewController ()

@end

@implementation YDChatBaseViewController

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.messageDisplayView];
    [self.view addSubview:self.chatBar];
    
    [self y_addMasonry];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadKeyboard];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[[TLAudioPlayer sharedAudioPlayer] stopPlayingAudio];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#ifdef DEBUG_MEMERY
    NSLog(@"dealloc ChatBaseVC");
#endif
}

#pragma mark - # Public Methods
- (void)setPartner:(id<YDChatUserProtocol>)partner
{
    if (_partner && [[_partner chat_userID] isEqualToString:[partner chat_userID]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.messageDisplayView scrollToBottomWithAnimation:NO];
        });
        return;
    }
    _partner = partner;
    [self.navigationItem setTitle:[_partner chat_username]];
    [self resetChatVC];
}

- (void)setChatMoreKeyboardData:(NSMutableArray *)moreKeyboardData
{
    [self.moreKeyboard setChatMoreKeyboardData:moreKeyboardData];
}

- (void)setChatEmojiKeyboardData:(NSMutableArray *)emojiKeyboardData
{
    //[self.emojiKeyboard setEmojiGroupData:emojiKeyboardData];
}

- (void)resetChatVC
{
    NSString *chatViewBGImage;
    if (self.partner) {
        chatViewBGImage = [[NSUserDefaults standardUserDefaults] objectForKey:[@"CHAT_BG_" stringByAppendingString:[self.partner chat_userID]]];
    }
    if (chatViewBGImage == nil) {
        chatViewBGImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"CHAT_BG_ALL"];
        if (chatViewBGImage == nil) {
            [self.view setBackgroundColor:[UIColor colorGrayCharcoalBG]];
        }
        else {
            NSString *imagePath = [NSFileManager pathUserChatBackgroundImage:chatViewBGImage];
            UIImage *image = [UIImage imageNamed:imagePath];
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
        }
    }
    else {
        NSString *imagePath = [NSFileManager pathUserChatBackgroundImage:chatViewBGImage];
        UIImage *image = [UIImage imageNamed:imagePath];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
    
    [self resetChatTVC];
}

/**
 *  发送图片消息
 */
- (void)sendImageMessage:(UIImage *)image
{
    NSData *imageData = (UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 0.5));
    NSString *imageName = [NSString stringWithFormat:@"%lf.jpg", [NSDate date].timeIntervalSince1970];
    NSString *imagePath = [NSFileManager pathUserChatImage:imageName];
    [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
    
    YDImageMessage *message = [[YDImageMessage alloc] init];
    message.fromUser = self.user;
    message.ownerTyper = YDMessageOwnerTypeSelf;
    message.imagePath = imageName;
    message.imageSize = image.size;
    [self sendMessage:message];
    if ([self.partner chat_userType] == YDChatUserTypeUser) {
        YDImageMessage *message1 = [[YDImageMessage alloc] init];
        message1.fromUser = self.partner;
        message1.ownerTyper = YDMessageOwnerTypeFriend;
        message1.imagePath = imageName;
        message1.imageSize = image.size;
        [self receivedMessage:message1];
    }
    else {
        for (id<YDChatUserProtocol> user in [self.partner groupMembers]) {
            YDImageMessage *message1 = [[YDImageMessage alloc] init];
            message1.friendID = [user chat_userID];
            message1.fromUser = user;
            message1.ownerTyper = YDMessageOwnerTypeFriend;
            message1.imagePath = imageName;
            message1.imageSize = image.size;
            [self receivedMessage:message1];
        }
    }
}

#pragma mark - # Private Methods
- (void)y_addMasonry
{

    self.messageDisplayView.sd_layout
    .topSpaceToView(self.view,0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.chatBar,0);
    
    self.chatBar.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(height_tabBar);
    [self.view layoutIfNeeded];
}

#pragma mark - # Getter
- (YDChatMessageDisplayView *)messageDisplayView
{
    if (_messageDisplayView == nil) {
        _messageDisplayView = [[YDChatMessageDisplayView alloc] init];
        [_messageDisplayView setDelegate:self];
    }
    return _messageDisplayView;
}
- (YDChatBar *)chatBar
{
    if (_chatBar == nil) {
        _chatBar = [[YDChatBar alloc] init];
        [_chatBar setDelegate:self];
    }
    return _chatBar;
}
- (YDRecoderIndicatorView *)recorderIndicatorView
{
    if (_recorderIndicatorView == nil) {
        _recorderIndicatorView = [[YDRecoderIndicatorView alloc] init];
    }
    return _recorderIndicatorView;
}



@end
