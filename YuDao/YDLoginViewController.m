//
//  YDLoginViewController.m
//  YuDao
//
//  Created by 汪杰 on 16/10/11.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDLoginViewController.h"
#import "YDSpotView.h"
#import "YDLoginInputView.h"
#import "YDRegisterController.h"
#import "JPUSHService.h"
#import "SetupTableViewController.h"

@interface YDLoginViewController ()<YDSpotViewDelegate,UITextFieldDelegate,YDLoginInputViewDelegate>

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) YDLoginInputView *accountView;
@property (nonatomic, strong) YDLoginInputView *passwordView;

@property (nonatomic, strong) YDSpotView *noDyPasswordView;
@property (nonatomic, strong) UILabel *thirdLoginLabel;
@property (nonatomic, strong) UIView *thirdLoginView;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *webLabel;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation YDLoginViewController
{
    NSTimer *_timer;
    NSInteger _time;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    [self.navigationItem setTitle:@"登录"];
    
    UIImageView *backImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageV.image = [UIImage imageNamed:@"login_backIcon"];
    [self.view addSubview:backImageV];
    
    [self.view sd_addSubviews:@[self.titleImageView,self.accountView,self.passwordView,self.noDyPasswordView,self.loginButton,self.registerButton,self.cancelButton,self.thirdLoginView,self.thirdLoginLabel,self.webLabel,self.companyLabel]];
    
    UITapGestureRecognizer *tapV = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackView)];
    [self.view addGestureRecognizer:tapV];
    
    [self y_layoutSubviews];
}

//MARK:Event
- (void)tapBackView{
    [self.accountView.textF resignFirstResponder];
    [self.passwordView.textF resignFirstResponder];
}
- (void)registerBtnAction:(UIButton *)sender{
    [self presentViewController:[YDRegisterController new]  animated:YES completion:^{
        
    }];
}
//取消按钮
- (void)cancelButtonAction:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setAccount:(NSString *)account{
    _account = account;
    self.accountView.textF.text = account;
}

#pragma mark - YDLoginInputViewDelegate
//获取验证码
- (void)loginInputView:(YDLoginInputView *)inView getPassword:(UIButton *)btn{
    if (![self.accountView.textF.text isMobileNumber]) {
        [YDMBPTool showBriefAlert:@"手机号输入错误" time:1];
        return;
    }
    
    [btn setTitle:@"获取中..." forState:0];
    __weak YDLoginViewController *weakSelf = self;
    [YDNetworking postUrl:kSmsURL parameters:@{@"ub_cellphone":self.accountView.textF.text, @"type":@1} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSString *status = [originalDic valueForKey:@"status"];
        NSNumber *status_code = [originalDic objectForKey:@"status_code"];
        if ([status_code isEqual:@4005]) {//手机号未注册
            [btn setTitle:@"获取验证码" forState:0];
            [YDMBPTool showBriefAlert:status time:1.5];
            YDRegisterController *reVC = [YDRegisterController new];
            reVC.account = weakSelf.accountView.textF.text;
            [reVC setRegisterBlock:^(NSString *account) {
                weakSelf.accountView.textF.text = account;
            }];
            [weakSelf presentViewController:reVC animated:YES completion:nil];
        }
        else if ([status_code isEqual:@4004]) {//验证码超限
            [YDMBPTool showBriefAlert:status time:1.5];
        }else if ([status_code isEqual:@200]){//成功
            _time = 59;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lgTimerAction:) userInfo:nil repeats:YES];
            btn.enabled = NO;
            [YDMBPTool showBriefAlert:@"验证码正火速赶往中..." time:1.5];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取验证码失败 error ＝ %@",error);
        [YDMBPTool showBriefAlert:@"获取失败，请检查网络或手机号" time:1];
        [btn setTitle:@"获取动态密码" forState:0];
    }];
    
}
//登录
- (void)loginBtnAction:(UIButton *)sender{
    if (![self.accountView.textF.text isMobileNumber]) {
        [YDMBPTool showBriefAlert:@"手机号输入错误" time:1];
        return;
    }
    if (self.passwordView.textF.text.length != 4) {
        [YDMBPTool showBriefAlert:@"验证码输入错误" time:1];
        return;
    }
    
    [YDMBPTool showLoading];
    [self.accountView.textF resignFirstResponder];
    [self.passwordView.textF resignFirstResponder];
    [YDNetworking postUrl:kLoginURL parameters:@{@"ub_cellphone":self.accountView.textF.text,@"code":self.passwordView.textF.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        [YDMBPTool hideAlert];
        NSDictionary *originalDic = [responseObject mj_JSONObject];
        NSString *status = [originalDic valueForKey:@"status"];
        NSNumber *status_code = [originalDic objectForKey:@"status_code"];
        NSDictionary *dataDic = [originalDic objectForKey:@"data"];
        NSDictionary *infoDic = [dataDic objectForKey:@"info"];
        
        //NSArray *codes = @[@3000,@3001,@3002,@3003,@3004,@3010];
        if ([status_code isEqual:@200]) {//登录成功
            if ([YDAppConfigure defaultAppConfigure].userStatus == YDUserStatusNotLogin) {
                [YDAppConfigure defaultAppConfigure].userStatus = YDUserStatusHadLogin;
            }else if ([YDAppConfigure defaultAppConfigure].userStatus == YDUserStatusLogout){
                [YDAppConfigure defaultAppConfigure].userStatus = YDUserStatusReLogin;
            }
            
            [YDUserDefault defaultUser].user = [YDUser mj_objectWithKeyValues:infoDic];
            //[[YDXMPPManager defaultManager] loginwithName:[NSString stringWithFormat:@"%@",[YDUserDefault defaultUser].user.ub_id] andPassword:[YDUserDefault defaultUser].user.ub_password];
            [[YDXMPPTool sharedInstance] loginWithUserId:[YDUserDefault defaultUser].user.ub_id andPassword:[YDUserDefault defaultUser].user.ub_password];
            
            NSString *access_token = [YDUserDefault defaultUser].user.access_token;
            //下载车库数据
            [YDNetworking getUrl:kCarsListURL parameters:@{@"access_token":access_token} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *originalDic = [responseObject mj_JSONObject];
                NSArray *dataArray = [originalDic objectForKey:@"data"];
                NSArray *garageArray = [YDCarDetailModel mj_objectArrayWithKeyValuesArray:dataArray];
                [[YDCarHelper sharedHelper] insertCars:garageArray];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"下载车辆数据失败: error = %@",error);
            }];
            
            //绑定用户与极光推送的id
            NSString *jPushID = [JPUSHService registrationID];
            NSDictionary *bindJPDic = @{ @"access_token":YDNoNilString(access_token),
                                        @"source":@2,
                                        @"registration_id":YDNoNilString(jPushID)};
            [YDNetworking getUrl:kBindJPushIDURL parameters:bindJPDic progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *response = [responseObject mj_JSONObject];
                NSLog(@"绑定JPushID: response = %@",response);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"绑定JPushID: 失败 error = %@",error);
            }];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [YDMBPTool showBriefAlert:status time:1.5];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"登录失败 error = %@",error);
        [YDMBPTool hideAlert];
        [YDMBPTool showBriefAlert:@"登录失败" time:1];
    }];
}

- (void)lgTimerAction:(id)sender{
    _time -= 1;
    [self.passwordView.variableBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)_time] forState:0];
    if (_time == 0) {
        self.passwordView.variableBtn.enabled = YES;
        [self.passwordView.variableBtn setTitle:@"获取动态密码" forState:0];
        [_timer invalidate];
        _timer = nil;
    }
}

//MARK:Layout
- (void)y_layoutSubviews{
    self.titleImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,100)
    .heightIs(self.titleImageView.image.size.height)
    .widthIs(self.titleImageView.image.size.width);
    
    self.accountView.sd_layout
    .centerXEqualToView(self.view)
    .leftSpaceToView(self.view,kWidth(25))
    .rightSpaceToView(self.view,kWidth(25))
    .topSpaceToView(self.titleImageView,30)
    .heightIs(kHeight(50));
    
    self.passwordView.sd_layout
    .centerXEqualToView(self.view)
    .leftSpaceToView(self.view,kWidth(25))
    .rightSpaceToView(self.view,kWidth(25))
    .topSpaceToView(self.accountView,25)
    .heightIs(kHeight(50));
    
    self.noDyPasswordView.sd_layout
    .topSpaceToView(self.passwordView,10)
    .rightSpaceToView(self.view,10)
    .heightIs(21)
    .widthIs(0);
    
    self.loginButton.sd_layout
    .topSpaceToView(self.noDyPasswordView,50)
    .leftEqualToView(self.passwordView)
    .rightEqualToView(self.passwordView)
    .heightIs(self.passwordView.height_sd);
    
    self.registerButton.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.loginButton,5)
    .heightIs(21)
    .widthIs(screen_width/2);
    
    self.thirdLoginView.sd_layout
    .topSpaceToView(self.loginButton,50)
    .leftEqualToView(self.loginButton)
    .rightEqualToView(self.loginButton)
    .heightIs(70);
    
    self.thirdLoginLabel.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.thirdLoginView,10)
    .heightIs(21);
    [self.thirdLoginLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.webLabel.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view,25)
    .heightIs(21);
    [self.webLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.companyLabel.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.webLabel,kHeight(10))
    .heightIs(21)
    .widthIs(screen_width);
}


#pragma mark - YDSpotViewDelegate
- (void)spotViewWithTitle:(NSString *)title{
    NSLog(@"title = %@",title);
}



#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length > 0) {
        string = [textField.text stringByAppendingString:string];
    }else{
        string = [textField.text substringWithRange:NSMakeRange(0, textField.text.length-1)];
    }
    
    if ([string length] == 4) {
        textField.text = string;
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Gettes
- (UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
    }
    return _titleImageView;
}
- (YDLoginInputView *)accountView{
    if (!_accountView) {
        _accountView = [YDLoginInputView new];
        _accountView.dataDic = @{@"label":@"帐号"};
    }
    return _accountView;
}
- (YDLoginInputView *)passwordView{
    if (!_passwordView) {
        _passwordView = [YDLoginInputView new];
        _passwordView.dataDic = @{@"label":@"密码"};
        _passwordView.delegate = self;
    }
    return _passwordView;
}

- (YDSpotView *)noDyPasswordView{
    if (!_noDyPasswordView) {
        _noDyPasswordView = [[YDSpotView alloc]initWithTitle:@"没有验证码？"];
        _noDyPasswordView.delegate = self;
    }
    return _noDyPasswordView;
}
- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton new];
        //[_loginButton setBackgroundImage:[UIImage imageNamed:@"login_input_backIcon"] forState:0];
        [_loginButton setTitle:@"登录" forState:0];
        [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:0];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        _loginButton.layer.cornerRadius = 8.f;
        _loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _loginButton.layer.borderWidth = 1.f;
        
        [_loginButton addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [UIButton new];
        [_registerButton setTitle:@"没有账户?创建新用户" forState:0];
        [_registerButton.titleLabel setFont:kFont(16)];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:0];
        [_registerButton addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:0];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:0];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.frame = CGRectMake(10, 40, kWidth(80), 40);
    }
    return _cancelButton;
}

- (UILabel *)thirdLoginLabel{
    if (!_thirdLoginLabel) {
        _thirdLoginLabel = [UILabel new];
        _thirdLoginLabel.text = @"第三方登录";
        _thirdLoginLabel.textColor = [UIColor whiteColor];
        _thirdLoginLabel.textAlignment = NSTextAlignmentCenter;
        _thirdLoginLabel.hidden = YES;
    }
    return _thirdLoginLabel;
}

- (UIView *)thirdLoginView{
    if (!_thirdLoginView) {
        _thirdLoginView = [UIView new];
        
        CGSize size = [UIImage imageNamed:@"qq"].size;
        UIButton *weiboBtn = [UIButton new];
        [weiboBtn setBackgroundImage:[UIImage imageNamed:@"weibo"] forState:0];
        UIButton *QQBtn = [UIButton new];
        [QQBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:0];
        UIButton *weixinBtn = [UIButton new];
        [weixinBtn setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:0];
        _thirdLoginView.hidden = YES;
        
        [_thirdLoginView sd_addSubviews:@[weiboBtn,weixinBtn,QQBtn]];
        
        QQBtn.sd_layout
        .centerXEqualToView(_thirdLoginView)
        .topSpaceToView(_thirdLoginView,0)
        .widthIs(size.width)
        .heightEqualToWidth();
        
        weixinBtn.sd_layout
        .rightSpaceToView(QQBtn,28*widthHeight_ratio)
        .topSpaceToView(_thirdLoginView,0)
        .widthIs(size.width)
        .heightEqualToWidth();
        
        weiboBtn.sd_layout
        .leftSpaceToView(QQBtn,28*widthHeight_ratio)
        .topSpaceToView(_thirdLoginView,0)
        .widthIs(size.width)
        .heightEqualToWidth();
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.alpha = 0.7;
        [_thirdLoginView addSubview:lineView];
        
        lineView.sd_layout
        .leftEqualToView(weixinBtn)
        .rightEqualToView(weiboBtn)
        .bottomSpaceToView(_thirdLoginView,0)
        .heightIs(1);
    }
    return _thirdLoginView;
}

- (UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:@"驭联智能科技发展(上海)有限公司版权所有" fontSize:kFontSize(16) textAlignment:NSTextAlignmentCenter];
    }
    return _companyLabel;
}

- (UILabel *)webLabel{
    if (!_webLabel) {
        _webLabel = [YDUIKit labelWithTextColor:[UIColor whiteColor] text:@"ve-link.com" fontSize:kFontSize(16) textAlignment:NSTextAlignmentCenter];;
        _webLabel.text = @"ve-link.com";
        _webLabel.hidden = YES;
    }
    return _webLabel;
}

@end
